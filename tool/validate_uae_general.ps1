param([switch]$WriteCandidates, [switch]$WriteReport)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$data = Join-Path $root 'content/uae_general'
$sources = @{}
foreach ($s in (Import-Csv (Join-Path $data 'sources.psv') -Delimiter '|')) { $sources[$s.key] = $s }
$expected = @()
foreach ($tier in @('easy','medium','hard')) {
  foreach ($q in (Import-Csv (Join-Path $data "$tier.psv") -Delimiter '|')) {
    $q | Add-Member tier (@{easy='easy200';medium='medium400';hard='hard600'}[$tier])
    $expected += $q
  }
}
function Normalize([string]$s) {
  return ([regex]::Replace(([regex]::Replace($s.ToLowerInvariant(), '[\u064B-\u065F\u0670\u0640]', '') -replace '[أإآ]', 'ا'), '[^\p{L}\p{N}]+', ' ')).Trim()
}
function Hash([string]$s) {
  return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($s))).ToLowerInvariant()
}
function UnescapeDart([string]$s) { return $s.Replace('\$', '$').Replace("\'", "'").Replace('\\','\') }
$active = Get-Content (Join-Path $root 'lib/data/questions/uae_general_final.dart') -Raw
$actual = @()
$visited = @{}
foreach ($m in [regex]::Matches($active, "import '(uae_general/[^']+)';")) {
  $file = $m.Groups[1].Value
  if ($visited.ContainsKey($file)) { throw "Repeated import $file" }
  $visited[$file] = $true
  $text = Get-Content (Join-Path $root "lib/data/questions/$file") -Raw
  $symbol = [regex]::Match($text, 'final (uaeGeneral\w+) = <TriviaQuestion>').Groups[1].Value
  if (-not $symbol -or [regex]::Matches($active, "\.\.\.$symbol,").Count -ne 1) { throw "Import/spread mismatch: $file" }
  foreach ($block in [regex]::Matches($text, '(?s)TriviaQuestion\((.*?)\n  \),')) {
    $q = @{}
    foreach ($field in [regex]::Matches($block.Groups[1].Value, "(\w+): '((?:\\.|[^'\\])*)',")) { $q[$field.Groups[1].Value] = UnescapeDart $field.Groups[2].Value }
    $q.difficulty = [regex]::Match($block.Value,'QuestionDifficulty\.(\w+)').Groups[1].Value
    if ($block.Value -notmatch 'lastVerified: DateTime\(2026, 10, 7\)') { throw 'Missing verification date' }
    $actual += [pscustomobject]$q
  }
}
if ($visited.Count -ne 6 -or [regex]::Matches($active,'\.\.\.uaeGeneral').Count -ne 6) { throw 'Unexpected active imports/spreads' }
$checks = [ordered]@{total=$actual.Count;easy200=@($actual|Where-Object difficulty -eq easy200).Count;medium400=@($actual|Where-Object difficulty -eq medium400).Count;hard600=@($actual|Where-Object difficulty -eq hard600).Count}
foreach ($field in @('id','questionAr','questionEn','factKey')) {
  $values = @($actual | ForEach-Object { Normalize $_.$field })
  $checks["duplicate_$field"] = $values.Count - @($values | Sort-Object -Unique).Count
}
$checks.missing_sources = @($actual | Where-Object { -not $_.sourceName -or -not $_.sourceUrl }).Count
$checks.missing_translations = @($actual | Where-Object { -not $_.questionAr -or -not $_.questionEn -or -not $_.answerAr -or -not $_.answerEn }).Count
$checks.wrong_category_ids = @($actual | Where-Object categoryId -ne uae_general).Count
$allDefinitions = @(Get-ChildItem (Join-Path $root 'lib') -Filter '*.dart' -Recurse | ForEach-Object {
  [regex]::Matches((Get-Content $_.FullName -Raw), "id:\s*'(uae_general_v2_\d+)'" ) | ForEach-Object { $_.Groups[1].Value }
})
if ($allDefinitions.Count -ne 204 -or @($allDefinitions | Sort-Object -Unique).Count -ne 204) { throw 'UAE IDs not globally unique in repository' }
foreach ($q in $actual) {
  $uri = $null
  if (-not [Uri]::TryCreate($q.sourceUrl,[UriKind]::Absolute,[ref]$uri) -or $uri.Scheme -ne 'https') { throw "Invalid source URL $($q.id)" }
  $row = @($expected | Where-Object { "uae_general_v2_$($_.id)" -eq $q.id })
  if ($row.Count -ne 1) { throw "Missing editorial row $($q.id)" }
  $row = $row[0]
  foreach ($field in @('factKey','questionAr','questionEn','answerAr','answerEn')) { if ($row.$field -cne $q.$field) { throw "Dart/editorial mismatch: $($q.id) $field" } }
  $source = $sources[$row.source]
  if (-not $source.evidence -or $source.url -cne $q.sourceUrl -or $source.name -cne $q.sourceName -or $row.tier -ne $q.difficulty) { throw "Evidence/difficulty mismatch $($q.id)" }
  if ($q.questionAr -notmatch '[\u0600-\u06FF]' -or $q.questionEn -notmatch '[A-Za-z]') { throw "Wrong translation script $($q.id)" }
}
# Flag lexical similarity and repeated answers within the same event family.
# Human review distinguishes genuinely different facts from rewordings.
$candidates = @()
$maxEnglishSimilarity = 0.0
for ($i=0; $i -lt $actual.Count; $i++) {
  $a=$actual[$i]; $ta=@((Normalize $a.questionEn).Split(' ') | Sort-Object -Unique)
  for ($j=$i+1; $j -lt $actual.Count; $j++) {
    $b=$actual[$j]; $tb=@((Normalize $b.questionEn).Split(' ') | Sort-Object -Unique)
    $union=@(@($ta)+@($tb)|Sort-Object -Unique).Count
    $overlap=@($ta|Where-Object {$_ -in $tb}).Count / $union
    $maxEnglishSimilarity = [math]::Max($maxEnglishSimilarity,$overlap)
    $arA=@((Normalize $a.questionAr).Split(' ') | Sort-Object -Unique)
    $arB=@((Normalize $b.questionAr).Split(' ') | Sort-Object -Unique)
    $arOverlap=@($arA|Where-Object {$_ -in $arB}).Count / @(@($arA)+@($arB)|Sort-Object -Unique).Count
    $familyA=($a.factKey -split ':')[0..1] -join ':'
    $familyB=($b.factKey -split ':')[0..1] -join ':'
    if ($overlap -ge .60 -or $arOverlap -ge .60 -or ($familyA -eq $familyB -and (Normalize $a.answerEn) -eq (Normalize $b.answerEn))) {
      $hash=Hash ($a.questionAr+$a.questionEn+$a.answerAr+$a.answerEn+$b.questionAr+$b.questionEn+$b.answerAr+$b.answerEn)
      $candidates += [pscustomobject]@{pair="$($a.id)/$($b.id)";hash=$hash;similarity=[math]::Round($overlap,3);factA=$a.factKey;factB=$b.factKey;questionA=$a.questionEn;answerA=$a.answerEn;questionB=$b.questionEn;answerB=$b.answerEn;decision='';reason=''}
    }
  }
}
if ($WriteCandidates) { $candidates | Export-Csv (Join-Path $data 'near_duplicate_candidates.csv') -NoTypeInformation -Encoding utf8 }
$reviews=@{}
$reviewPath=Join-Path $data 'near_duplicate_review.csv'
if (Test-Path $reviewPath) { foreach($r in (Import-Csv $reviewPath)) {$reviews[$r.pair]=$r} }
$unreviewed=@($candidates | Where-Object { -not $reviews.ContainsKey($_.pair) -or $reviews[$_.pair].hash -ne $_.hash -or $reviews[$_.pair].decision -ne 'distinct' -or -not $reviews[$_.pair].reason })
$checks.near_duplicate_candidates=$candidates.Count
$checks.unresolved_near_duplicates=$unreviewed.Count
$checks.maximum_english_similarity=[math]::Round($maxEnglishSimilarity,3)
if ($maxEnglishSimilarity -ge .85) { throw 'Similarity exceeds the Dart validator threshold' }
$preserved = @(Get-Content (Join-Path $root 'CATEGORY_2_FOOTBALL_PRESERVATION.json') -Raw | ConvertFrom-Json)
$checks.changed_football_files = @($preserved | Where-Object { (Get-FileHash -LiteralPath $_.Path -Algorithm SHA256).Hash -ne $_.Hash }).Count
if ($checks.changed_football_files -ne 0) { throw 'Completed football bank changed' }
$checks | ConvertTo-Json
if ($checks.total -ne 204 -or $checks.easy200 -ne 68 -or $checks.medium400 -ne 68 -or $checks.hard600 -ne 68) { throw 'Wrong distribution' }
foreach ($key in @('duplicate_id','duplicate_questionAr','duplicate_questionEn','duplicate_factKey','missing_sources','missing_translations','wrong_category_ids','unresolved_near_duplicates')) { if ($checks[$key] -ne 0) { throw "Failed: $key" } }
if ($WriteReport) {
  [IO.File]::WriteAllText((Join-Path $data 'validation_result.json'), ($checks | ConvertTo-Json) + "`n", [Text.UTF8Encoding]::new($false))
  $expected | ForEach-Object {
    $q=$_; $s=$sources[$q.source]
    [pscustomobject]@{id="uae_general_v2_$($q.id)";difficulty=$q.tier;factKey=$q.factKey;topic=$q.topic;questionAr=$q.questionAr;questionEn=$q.questionEn;answerAr=$q.answerAr;answerEn=$q.answerEn;sourceName=$s.name;sourceUrl=$s.url;evidence=$s.evidence;lastVerified='2026-10-07'}
  } | Export-Csv (Join-Path $data 'evidence_ledger.csv') -NoTypeInformation -Encoding utf8
}
Write-Output 'PASS: UAE structural, evidence mapping and reviewed near-duplicate checks.'
