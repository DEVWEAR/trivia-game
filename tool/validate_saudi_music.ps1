param([switch]$WriteCandidates, [switch]$WriteReport)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$data = Join-Path $root 'content/saudi_music'
$sources = @{}
foreach ($s in (Import-Csv (Join-Path $data 'sources.psv') -Delimiter '|')) {
  if ($sources.ContainsKey($s.key)) { throw "Duplicate source key: $($s.key)" }
  $sources[$s.key] = $s
}
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
$catalogBank = Get-Content (Join-Path $root 'lib/data/question_bank.dart') -Raw
if ($catalogBank -notmatch "import 'questions/saudi_music_final.dart';" -or $catalogBank -notmatch "'saudi_music': saudi_musicFinalQuestions," -or $catalogBank -match 'saudi_music_questions_001_020') { throw 'Saudi Music active catalog wiring is wrong' }
$active = Get-Content (Join-Path $root 'lib/data/questions/saudi_music_final.dart') -Raw
$actual = @()
$visited = @{}
foreach ($m in [regex]::Matches($active, "import '(saudi_music/[^']+)';")) {
  $file = $m.Groups[1].Value
  if ($visited.ContainsKey($file)) { throw "Repeated import $file" }
  $visited[$file] = $true
  $text = Get-Content (Join-Path $root "lib/data/questions/$file") -Raw
  $symbol = [regex]::Match($text, 'final (saudi_music\w+) = <TriviaQuestion>').Groups[1].Value
  if (-not $symbol -or [regex]::Matches($active, "\.\.\.$symbol,").Count -ne 1) { throw "Import/spread mismatch: $file" }
  foreach ($block in [regex]::Matches($text, '(?s)TriviaQuestion\((.*?)\n  \),')) {
    $q = @{}
    foreach ($field in [regex]::Matches($block.Groups[1].Value, "(\w+): '((?:\\.|[^'\\])*)',")) { $q[$field.Groups[1].Value] = UnescapeDart $field.Groups[2].Value }
    $q.difficulty = [regex]::Match($block.Value,'QuestionDifficulty\.(\w+)').Groups[1].Value
    if ($block.Value -notmatch 'lastVerified: DateTime\(2026, 10, 8\)') { throw 'Missing verification date' }
    $actual += [pscustomobject]$q
  }
}
if ($visited.Count -ne 6 -or [regex]::Matches($active,'\.\.\.saudi_music').Count -ne 6) { throw 'Unexpected active imports/spreads' }
$checks = [ordered]@{total=$actual.Count;easy200=@($actual|Where-Object difficulty -eq easy200).Count;medium400=@($actual|Where-Object difficulty -eq medium400).Count;hard600=@($actual|Where-Object difficulty -eq hard600).Count}
foreach ($field in @('id','questionAr','questionEn','factKey')) {
  $values = @($actual | ForEach-Object { Normalize $_.$field })
  $checks["duplicate_$field"] = $values.Count - @($values | Sort-Object -Unique).Count
}
$checks.missing_sources = @($actual | Where-Object { -not $_.sourceName -or -not $_.sourceUrl }).Count
$checks.missing_translations = @($actual | Where-Object { -not $_.questionAr -or -not $_.questionEn -or -not $_.answerAr -or -not $_.answerEn }).Count
foreach ($field in @('questionAr','questionEn','answerAr','answerEn')) {
 $checks["missing_$field"] = @($actual | Where-Object { [string]::IsNullOrWhiteSpace($_.$field) }).Count
}
$checks.wrong_category_ids = @($actual | Where-Object categoryId -ne saudi_music).Count
$allDefinitions = @(Get-ChildItem (Join-Path $root 'lib') -Filter '*.dart' -Recurse | ForEach-Object {
  [regex]::Matches((Get-Content $_.FullName -Raw), "id:\s*'(saudi_music_v2_\d+)'" ) | ForEach-Object { $_.Groups[1].Value }
})
if ($allDefinitions.Count -ne 204 -or @($allDefinitions | Sort-Object -Unique).Count -ne 204) { throw 'Saudi Music IDs not globally unique in repository' }
foreach ($q in $actual) {
  $uri = $null
  if (-not [Uri]::TryCreate($q.sourceUrl,[UriKind]::Absolute,[ref]$uri) -or $uri.Scheme -ne 'https') { throw "Invalid source URL $($q.id)" }
  $row = @($expected | Where-Object { "saudi_music_v2_$($_.id)" -eq $q.id })
  if ($row.Count -ne 1) { throw "Missing editorial row $($q.id)" }
  $row = $row[0]
  foreach ($field in @('factKey','questionAr','questionEn','answerAr','answerEn')) { if ($row.$field -cne $q.$field) { throw "Dart/editorial mismatch: $($q.id) $field" } }
  $source = $sources[$row.source]
  if (-not $source.evidence -or $source.url -cne $q.sourceUrl -or $source.name -cne $q.sourceName -or $row.tier -ne $q.difficulty) { throw "Evidence/difficulty mismatch $($q.id)" }
  if ($q.questionAr -notmatch '[\u0600-\u06FF]' -or $q.questionEn -notmatch '[A-Za-z]') { throw "Wrong translation script $($q.id)" }
}
$registry = Get-Content (Join-Path $root 'lib/data/playable_category_registry.dart') -Raw
if ($registry -notmatch "PlayableCategory\('saudi_music'" -or $registry -notmatch 'saudi_musicFinalQuestions') {throw 'Saudi Music missing from playable registry'}
$picker = Get-Content (Join-Path $root 'lib/main.dart') -Raw
$board = Get-Content (Join-Path $root 'lib/game_board.dart') -Raw
if ($picker -notmatch 'playableCategories.map' -or $picker -notmatch 'playableCategories\[i\].questions.length' -or $board -notmatch 'playableCategories\[i\]') {throw 'Picker/board registry mismatch'}
$checks.playable_registry_check = 'PASS'
$model = Get-Content (Join-Path $root 'lib/data/question_model.dart') -Raw
if ($model -notmatch 'easy200\(200\)' -or $model -notmatch 'medium400\(400\)' -or $model -notmatch 'hard600\(600\)') { throw 'Invalid point mapping' }
$checks.invalid_difficulty_point_mapping = @($actual | Where-Object difficulty -notin @('easy200','medium400','hard600')).Count
$checks.invalid_source_urls = 0 # Every URL passed the absolute HTTPS check above.
# Flag lexical similarity and repeated answers within the same event family.
# Assistant editorial review distinguishes different facts from rewordings.
function EditorialHash($q) {
  $tier = $q.tier -replace '200|400|600', ''
  $s = $sources[$q.source]
  return Hash (($q.id,$tier,$q.factKey,$q.source,$q.questionAr,$q.questionEn,$q.answerAr,$q.answerEn,$s.name,$s.url,$s.evidence) -join "`n")
}
$editorialReviews = @{}
foreach ($r in (Import-Csv (Join-Path $data 'editorial_review.csv'))) {
  if ($editorialReviews.ContainsKey($r.id)) { throw "Duplicate editorial review: $($r.id)" }
  $editorialReviews[$r.id] = $r
}
$checks.unresolved_editorial_reviews = @($expected | Where-Object {
  $q = $_; $r = $editorialReviews[$q.id]
  -not $r -or $r.hash -ne (EditorialHash $q) -or $r.factKey -cne $q.factKey -or $r.source -cne $q.source -or
  $r.evidenceVerified -ne 'yes' -or $r.translationParity -ne 'yes' -or $r.difficultyReviewed -ne 'yes' -or $r.distinctFact -ne 'yes'
}).Count
if ($editorialReviews.Count -ne 204 -or $checks.unresolved_editorial_reviews -ne 0) { throw 'Missing/stale factual, translation or difficulty review' }
$familyIds = [Collections.Generic.HashSet[string]]::new()
$families = @(Import-Csv (Join-Path $data 'fact_family_review.csv'))
foreach ($family in $families) {
  $members = @()
  foreach ($id in ($family.ids -split ',')) {
    if (-not $familyIds.Add($id)) { throw "Repeated family-review member: $id" }
    $member = @($expected | Where-Object id -eq $id)
    if ($member.Count -ne 1) { throw "Invalid family-review member: $id" }
    $members += $member[0]
  }
  $hash = Hash (($members | Sort-Object id | ForEach-Object { EditorialHash $_ }) -join "`n")
  $facts = ($members | Sort-Object id | ForEach-Object factKey) -join ','
  if ($family.hash -ne $hash -or $family.facts -cne $facts -or $family.decision -ne 'distinct' -or -not $family.reason) { throw "Stale/unresolved semantic group: $($family.entity)" }
}
if ($familyIds.Count -ne 204) { throw 'Incomplete semantic fact-family review coverage' }
$checks.reviewed_semantic_groups = $families.Count
$checks.unresolved_fact_family_reviews = 0
$checks.source_entries_used = @($expected.source | Sort-Object -Unique).Count
$scanText = & node (Join-Path $PSScriptRoot 'saudi_music_similarity.js') saudi_music
if ($LASTEXITCODE -ne 0) { throw 'Bilingual similarity scanner failed' }
$scan = ($scanText -join "
") | ConvertFrom-Json
$candidates = @($scan.internal)
$maxEnglishSimilarity = $scan.maximumEnglishSimilarity
$crossReviews=@{}
foreach($r in (Import-Csv (Join-Path $data 'cross_bank_review.csv'))) {$crossReviews[$r.pair]=$r}
$checks.cross_bank_candidates=@($scan.cross).Count
$checks.unresolved_cross_bank_facts=@($scan.cross | Where-Object { $r=$crossReviews[$_.pair]; -not $r -or $r.hash -ne $_.hash -or $r.decision -ne 'distinct' -or -not $r.reason }).Count
if ($checks.unresolved_cross_bank_facts -ne 0) { throw 'Unresolved or stale comparison with completed banks' }
if ($WriteCandidates) { $candidates | Export-Csv (Join-Path $data 'near_duplicate_candidates.csv') -NoTypeInformation -Encoding utf8 }
$reviews=@{}
$reviewPath=Join-Path $data 'near_duplicate_review.csv'
if (Test-Path $reviewPath) { foreach($r in (Import-Csv $reviewPath)) {$reviews[$r.pair]=$r} }
$unreviewed=@($candidates | Where-Object { -not $reviews.ContainsKey($_.pair) -or $reviews[$_.pair].hash -ne $_.hash -or $reviews[$_.pair].decision -ne 'distinct' -or -not $reviews[$_.pair].reason })
$checks.near_duplicate_candidates=$candidates.Count
$checks.unresolved_near_duplicates=$unreviewed.Count
$checks.maximum_english_similarity=[math]::Round($maxEnglishSimilarity,3)
if ($maxEnglishSimilarity -ge .85) { throw 'Similarity exceeds the Dart validator threshold' }
$sharedText = & node (Join-Path $PSScriptRoot 'saudi_music_shared_answers.js')
if ($LASTEXITCODE -ne 0) { throw 'Shared-answer scanner failed' }
$shared = @((($sharedText -join "`n") | ConvertFrom-Json))
$sharedReviews = @{}
foreach ($r in (Get-Content (Join-Path $data 'shared_answer_review.json') -Raw | ConvertFrom-Json)) { $sharedReviews[$r.pair] = $r }
$checks.shared_answer_candidates = $shared.Count
$checks.unresolved_shared_answer_reviews = @($shared | Where-Object {
  $r = $sharedReviews[$_.pair]
  -not $r -or $r.qA -cne $_.qA -or $r.qB -cne $_.qB -or $r.answer -cne $_.answer -or $r.decision -ne 'distinct' -or -not $r.reason
}).Count
if ($checks.unresolved_shared_answer_reviews -ne 0) { throw 'Unresolved shared-answer semantic overlap' }
$preserved = @(Get-Content (Join-Path $root 'BATCH_4_13_COMPLETED.json') -Raw | ConvertFrom-Json)
$preserved += @(Get-Content (Join-Path $root 'BATCH_14_23_COMPLETED.json') -Raw | ConvertFrom-Json)
$checks.changed_completed_category_files = @($preserved | Where-Object { (Get-FileHash -LiteralPath $_.Path -Algorithm SHA256).Hash -ne $_.Hash }).Count
if ($checks.changed_completed_category_files -ne 0) { throw 'Protected completed category files changed' }
$checks | ConvertTo-Json
if ($checks.total -ne 204 -or $checks.easy200 -ne 68 -or $checks.medium400 -ne 68 -or $checks.hard600 -ne 68) { throw 'Wrong distribution' }
foreach ($key in @('duplicate_id','duplicate_questionAr','duplicate_questionEn','duplicate_factKey','missing_sources','missing_translations','wrong_category_ids','unresolved_near_duplicates')) { if ($checks[$key] -ne 0) { throw "Failed: $key" } }
if ($WriteReport) {
  [IO.File]::WriteAllText((Join-Path $data 'validation_result.json'), ($checks | ConvertTo-Json) + "`n", [Text.UTF8Encoding]::new($false))
  $expected | ForEach-Object {
    $q=$_; $s=$sources[$q.source]
    [pscustomobject]@{id="saudi_music_v2_$($q.id)";difficulty=$q.tier;factKey=$q.factKey;topic=$q.topic;questionAr=$q.questionAr;questionEn=$q.questionEn;answerAr=$q.answerAr;answerEn=$q.answerEn;sourceName=$s.name;sourceUrl=$s.url;evidence=$s.evidence;lastVerified='2026-10-08'}
  } | Export-Csv (Join-Path $data 'evidence_ledger.csv') -NoTypeInformation -Encoding utf8
}
Write-Output 'PASS: Saudi Music structural, evidence mapping and reviewed near-duplicate checks.'




