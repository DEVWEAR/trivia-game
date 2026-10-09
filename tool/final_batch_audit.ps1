param([switch]$WriteReport)
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$cats=@('gulf_culture','kuwait_general','saudi_general','uae_pro_league','premier_league','la_liga','serie_a','bundesliga','ligue_1','ucl')
$names=@('Gulf Culture','Kuwait','Saudi Arabia','UAE Pro League','Premier League','La Liga','Serie A','Bundesliga','Ligue 1','UEFA Champions League')
$results=@($cats | ForEach-Object -Parallel {
  $cat=$_; $base=$using:root
  $output=& (Join-Path $base "tool/validate_${cat}.ps1")
  if (-not (($output -join "`n") -match 'PASS:')) {throw "$cat did not pass"}
  $json=[regex]::Match(($output -join "`n"),'(?s)\{.*?\}').Value | ConvertFrom-Json
  [pscustomobject]@{category=$cat;checks=$json;status='COMPLETE'}
} -ThrottleLimit 4)
if ($results.Count -ne 10) {throw 'Incomplete batch audit'}
$all=@()
foreach($cat in $cats) {
  $r=@($results | Where-Object category -eq $cat)[0]
  if ($r.checks.total -ne 204 -or $r.checks.easy200 -ne 68 -or $r.checks.medium400 -ne 68 -or $r.checks.hard600 -ne 68) {throw "$cat distribution failed"}
  foreach($p in $r.checks.PSObject.Properties) {
    if ($p.Name -match '^duplicate_|^missing_|^wrong_category|^invalid_source|^unresolved_|^changed_completed' -and $p.Value -ne 0) {throw "$cat failed $($p.Name)"}
  }
  foreach($tier in @('easy','medium','hard')) {
    foreach($q in (Import-Csv (Join-Path $root "content/$cat/$tier.psv") -Delimiter '|')) {
      $all += [pscustomobject]@{id="${cat}_v2_$($q.id)";ar=$q.questionAr;en=$q.questionEn}
    }
  }
}
function Norm([string]$s) {return ([regex]::Replace(($s.ToLowerInvariant() -replace '[\u064B-\u065F\u0670\u0640]','' -replace '[أإآ]','ا'),'[^\p{L}\p{N}]+',' ')).Trim()}
$global=[ordered]@{total=$all.Count;duplicate_ids=@($all | Group-Object id | Where-Object Count -gt 1).Count;duplicate_arabic=@($all | Group-Object {Norm $_.ar} | Where-Object Count -gt 1).Count;duplicate_english=@($all | Group-Object {Norm $_.en} | Where-Object Count -gt 1).Count}
if ($global.total -ne 2040 -or $global.duplicate_ids -ne 0 -or $global.duplicate_arabic -ne 0 -or $global.duplicate_english -ne 0) {throw 'Global batch exact-duplicate check failed'}
$ordered=@($cats | ForEach-Object {$key=$_; $results | Where-Object category -eq $key})
$report=[ordered]@{date='2026-10-07';global=$global;categories=$ordered;crossBankReview='Each successive bank compared with all preceding completed banks; latest Ligue 1 and UCL scans cover their new relations. All hash-bound candidate decisions pass.';runtime='PowerShell/Node static PASS; Dart/Flutter unavailable.'}
if($WriteReport) {
  [IO.File]::WriteAllText((Join-Path $root 'BATCH_4_13_FINAL_AUDIT.json'),($report | ConvertTo-Json -Depth 8)+"`n",[Text.UTF8Encoding]::new($false))
  $lines=[Collections.Generic.List[string]]::new()
  $lines.Add('# Final audit — original ten-category batch')
  $lines.Add('')
  $lines.Add('2026-10-07. Every category validator rerun successfully. COMPLETE means exact 204 and 68/68/68 plus passing source, bilingual, difficulty, semantic, registry and preservation checks.')
  $lines.Add('')
  $lines.Add('| Category | Total | easy200 | medium400 | hard600 | Duplicates | Near-duplicates | Missing sources | Missing translations | Status |')
  $lines.Add('|---|---:|---:|---:|---:|---:|---:|---:|---:|---|')
  for($i=0;$i -lt $cats.Count;$i++) {$c=$ordered[$i].checks;$d=$c.duplicate_id+$c.duplicate_questionAr+$c.duplicate_questionEn;$lines.Add("| $($names[$i]) | $($c.total) | $($c.easy200) | $($c.medium400) | $($c.hard600) | $d | $($c.unresolved_near_duplicates) | $($c.missing_sources) | $($c.missing_translations) | COMPLETE |")}
  $lines.Add('')
  $lines.Add('Global batch: 2,040 questions, zero duplicate IDs, zero normalized duplicate Arabic questions and zero normalized duplicate English questions. All per-bank missing-field, wrong-category, unresolved fact-family, unresolved cross-bank and preservation checks returned zero.')
  $lines.Add('')
  $lines.Add('Near-duplicates column reports unresolved repeated facts after editorial review, not raw lexical similarity flags. Different scorers, assistants, match dates and competitions can share wording without repeating a fact. Full candidate counts and exact-wording review hashes remain in each content directory. The Champions League shared-answer scan additionally reviewed 89 comparisons against every earlier completed bank.')
  $lines.Add('')
  $lines.Add('Previously completed content was not regenerated or modified. New Ligue 1 and Champions League banks are active in the existing catalog and playable registry. UI and gameplay files were not edited. Dart/Flutter were unavailable; PowerShell and Node static checks passed. No category beyond the authorized batch was started.')
  [IO.File]::WriteAllLines((Join-Path $root 'BATCH_4_13_FINAL_AUDIT.md'),$lines,[Text.UTF8Encoding]::new($false))
}
$report | ConvertTo-Json -Depth 8
Write-Output 'PASS: final ten-category batch audit.'
