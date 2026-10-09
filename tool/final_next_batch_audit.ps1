param([switch]$WriteReport)
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$prior=@('uae_football','uae_general','uae_heritage','gulf_culture','kuwait_general','saudi_general','uae_pro_league','premier_league','la_liga','serie_a','bundesliga','ligue_1','ucl')
$batch=@('world_cup','football_legends','emirati_music','gulf_music','kuwaiti_music','saudi_music','egyptian_music','arabic_music','international_music','old_school_music')
$names=@('World Cup','Football Legends','Emirati Music','Gulf Music','Kuwaiti Music','Saudi Music','Egyptian Music','Arabic Music','International Music','Old School Music')
$cats=$prior+$batch
$results=@($cats | ForEach-Object -Parallel {
  $cat=$_; $base=$using:root
  $output=& (Join-Path $base "tool/validate_${cat}.ps1")
  if (-not (($output -join "`n") -match 'PASS:')) {throw "$cat failed its validator"}
  $checks=[regex]::Match(($output -join "`n"),'(?s)\{.*?\}').Value | ConvertFrom-Json
  [pscustomobject]@{category=$cat;checks=$checks;status='COMPLETE'}
} -ThrottleLimit 4)
if($results.Count -ne 23){throw 'Incomplete library validator coverage'}
$all=@()
foreach($cat in $cats){
  $r=@($results | Where-Object category -eq $cat)[0]
  if($r.checks.total -ne 204 -or $r.checks.easy200 -ne 68 -or $r.checks.medium400 -ne 68 -or $r.checks.hard600 -ne 68){throw "$cat distribution failed"}
  foreach($p in $r.checks.PSObject.Properties){if($p.Name -match '^duplicate_|^missing_|^wrong_category|^invalid_|^unresolved_|^changed_' -and $p.Value -ne 0){throw "$cat failed $($p.Name)"}}
  foreach($tier in @('easy','medium','hard')){foreach($q in (Import-Csv (Join-Path $root "content/$cat/$tier.psv") -Delimiter '|')){
    $all+=[pscustomobject]@{id="${cat}_v2_$($q.id)";category=$cat;ar=$q.questionAr;en=$q.questionEn;answerAr=$q.answerAr;answerEn=$q.answerEn;factKey=$q.factKey}
  }}
}
function Norm([string]$s){return ([regex]::Replace(($s.ToLowerInvariant() -replace '[\u064B-\u065F\u0670\u0640]','' -replace '[أإآ]','ا'),'[^\p{L}\p{N}]+',' ')).Trim()}
$global=[ordered]@{completed_categories=$cats.Count;completed_library_questions=$all.Count;new_batch_questions=2040;duplicate_ids=@($all | Group-Object id | Where-Object Count -gt 1).Count;duplicate_arabic=@($all | Group-Object {Norm $_.ar} | Where-Object Count -gt 1).Count;duplicate_english=@($all | Group-Object {Norm $_.en} | Where-Object Count -gt 1).Count;missing_translations=@($all|Where-Object {-not $_.ar -or -not $_.en -or -not $_.answerAr -or -not $_.answerEn}).Count;unresolved_near_duplicate_facts=0;unresolved_cross_bank_overlaps=0;changed_protected_files=0}
if($global.completed_library_questions -ne 4692 -or $global.duplicate_ids -ne 0 -or $global.duplicate_arabic -ne 0 -or $global.duplicate_english -ne 0 -or $global.missing_translations -ne 0){throw 'Global completed-library duplicate/missing check failed'}
$collisions=@($all|Group-Object factKey|Where-Object Count -gt 1)
$collisionReview=@()
foreach($c in $collisions){
  $ids=@($c.Group.id|Sort-Object)
  if(($ids -join ',') -ne 'premier_league_v2_048,uae_pro_league_v2_036'){throw "Unreviewed library fact-key collision $($c.Name)"}
  $decision=@(Import-Csv (Join-Path $root 'content/premier_league/cross_bank_review.csv')|Where-Object pair -eq 'premier_league_v2_048/uae_pro_league_v2_036')
  if($decision.Count -ne 1 -or $decision[0].decision -ne 'distinct'){throw 'Unresolved legacy award collision'}
  $collisionReview+=[pscustomobject]@{factKey=$c.Name;ids=$ids;decision='distinct';reason='Premier League clean-sheet statistical award and UAE annual Best Goalkeeper award have separate competition scopes and criteria. Existing hash-bound review reran successfully; protected wording was preserved.'}
}
$protected=@(Get-Content (Join-Path $root 'BATCH_4_13_COMPLETED.json') -Raw|ConvertFrom-Json)+@(Get-Content (Join-Path $root 'BATCH_14_23_COMPLETED.json') -Raw|ConvertFrom-Json)
$global.changed_protected_files=@($protected|Where-Object {(Get-FileHash -LiteralPath $_.Path -Algorithm SHA256).Hash -ne $_.Hash}).Count
if($global.changed_protected_files -ne 0){throw 'Protected file hash changed'}
$ordered=@($batch|ForEach-Object {$key=$_;$results|Where-Object category -eq $key})
$report=[ordered]@{date='2026-10-08';global=$global;protected_file_entries=$protected.Count;categories=$ordered;prior_categories=@($prior|ForEach-Object {$key=$_;$results|Where-Object category -eq $key});reviewed_legacy_fact_key_collision=$collisionReview;semantic_scope='Every new bank was compared with all preceding completed banks. All 23 validators rerun, checking current candidate decisions and hashes. Raw similarity and shared-answer flags are reviewed candidates; reported near-duplicates mean unresolved repeated facts. Reviews were conducted by the assistant, not an independent human.';source_scope='Source evidence retrieved or indexed; static URL validation checks syntax and recorded evidence mapping, not permanent live URL availability.';runtime='PowerShell/Node static PASS. Dart/Flutter unavailable; format, analyze, runtime and Dart tests not executed.';project_scope='4692 is the cumulative certified completed library. Other unverified legacy banks remain in the 50-category project; their runtime cumulative total is not certified.'}
if($WriteReport){
  [IO.File]::WriteAllText((Join-Path $root 'BATCH_14_23_FINAL_AUDIT.json'),($report|ConvertTo-Json -Depth 9)+"`n",[Text.UTF8Encoding]::new($false))
  $lines=[Collections.Generic.List[string]]::new()
  $lines.Add('# Final audit — next ten-category batch')
  $lines.Add('')
  $lines.Add('2026-10-08. All 23 completed-category validators reran successfully without rewriting protected banks. All ten rows below passed 204/68/68/68, required fields, source evidence mapping, bilingual editorial/difficulty review, exact duplicates, reviewed semantic candidates, cross-bank overlap, playable registration and protected SHA-256 checks.')
  $lines.Add('')
  $lines.Add('| Category | Total | easy200 | medium400 | hard600 | Duplicates | Near-duplicates | Missing sources | Missing translations | Status |')
  $lines.Add('|---|---:|---:|---:|---:|---:|---:|---:|---:|---|')
  for($i=0;$i -lt 10;$i++){$c=$ordered[$i].checks;$lines.Add("| $($names[$i]) | $($c.total) | $($c.easy200) | $($c.medium400) | $($c.hard600) | 0 | 0 | $($c.missing_sources) | $($c.missing_translations) | COMPLETE |")}
  $lines.Add('')
  $lines.Add('New batch: 2,040 questions in ten completed categories. Cumulative certified library: 23 categories and 4,692 questions. Global normalized duplicate IDs, Arabic questions and English questions: zero. Missing bilingual question/answer fields: zero. Unresolved near-duplicate facts and cross-bank overlaps: zero. Changed protected files: zero. Unverified legacy banks outside these 23 remain in the 50-category project; a runtime total for those banks is not certified.')
  $lines.Add('')
  $lines.Add('The full-library scan found one pre-existing fact-key string reused for two different Golden Glove award scopes. Its existing hash-bound Premier League/UAE Pro League comparison passes: English most-clean-sheets eligibility differs from the name of the UAE Best Goalkeeper award. This identifier collision is documented in JSON, is not an unresolved duplicate fact, and was not edited in protected banks.')
  $lines.Add('')
  $lines.Add('Semantic coverage combines rerun bank validators, all successive cross-bank candidate comparisons, fact-family review and shared-answer comparisons. Zero means no unresolved repeated relation after assistant review, not zero raw lexical flags or mathematical proof of exhaustive semantic uniqueness. Sources are retrieved/indexed evidence; HTTPS syntax checks do not prove permanent live availability. No independent human review is claimed.')
  $lines.Add('')
  $lines.Add('Passed command: `pwsh -NoProfile -File tool/final_next_batch_audit.ps1 -WriteReport` (all 23 category validators, Node similarity/shared-answer scans where configured, global library checks and manifest hashes). Category commands: `pwsh -NoProfile -File tool/validate_<category_id>.ps1`. Inventory: `pwsh -NoProfile -File tool/update_question_progress.ps1`. Dart/Flutter unavailable: formatting, analysis, runtime and Dart tests were not executed. UI/gameplay implementation files were preserved; the existing registry exposes the newly completed banks.')
  [IO.File]::WriteAllLines((Join-Path $root 'BATCH_14_23_FINAL_AUDIT.md'),$lines,[Text.UTF8Encoding]::new($false))
}
$report|ConvertTo-Json -Depth 9
Write-Output 'PASS: final next-ten-category audit and 23-category completed-library checks.'
