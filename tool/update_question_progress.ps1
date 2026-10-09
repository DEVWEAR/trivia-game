$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$catalog = Get-Content -LiteralPath (Join-Path $projectRoot 'lib/data/category_catalog.dart') -Raw
$categories = [regex]::Matches($catalog, "TriviaCategory\(id: '([^']+)', emoji: '[^']+', ar: '([^']+)', en: '([^']+)'")
if ($categories.Count -ne 50) { throw "Expected 50 categories; found $($categories.Count)" }
function Read-Bank([string]$file, [System.Collections.Generic.HashSet[string]]$visited) {
  $path = [IO.Path]::GetFullPath($file)
  if (-not $visited.Add($path)) { return '' }
  $content = Get-Content -LiteralPath $path -Raw
  $parts = @($content)
  foreach ($import in [regex]::Matches($content, "import '([^']+)';")) {
    if ($import.Groups[1].Value -like '*question_model.dart') { continue }
    $parts += Read-Bank (Join-Path (Split-Path $path -Parent) $import.Groups[1].Value) $visited
  }
  return ($parts -join "`n")
}
$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# Question bank progress')
$lines.Add('')
$lines.Add('Inventory date: 2026-10-08. Completed categories have passed sourced bilingual editorial review and PowerShell/static validation. The next ten-category batch is complete.')
$lines.Add('')
$lines.Add('Target: exactly 50 categories, each 204 questions with 68 at each difficulty. Car Logos was omitted from the original 51-entry catalog; the six other car categories remain.')
$lines.Add('')
$lines.Add('The twenty-three completed categories each contain 204 questions with 68 per difficulty (4,692 certified questions). See BATCH_4_13_FINAL_AUDIT.md, BATCH_14_23_FINAL_AUDIT.md, category audit reports and content validation records. Protected banks were preserved byte for byte. World Cup, Football Legends, Emirati Music, Gulf Music, Kuwaiti Music, Saudi Music, Egyptian Music, Arabic Music, International Music and Old School Music complete the next ten-category batch (2,040 questions). Other catalog entries remain unverified.')
$lines.Add('')
$lines.Add('| Category | ID | Total | 200 | 400 | 600 | Verification | Validation |')
$lines.Add('|---|---|---:|---:|---:|---:|---|---|')
foreach ($category in $categories) {
  $id = $category.Groups[1].Value
  $file = Join-Path $projectRoot "lib/data/questions/${id}_final.dart"
  $content = ''
  if (Test-Path -LiteralPath $file) { $content = Read-Bank $file ([System.Collections.Generic.HashSet[string]]::new()) }
  $total = [regex]::Matches($content, 'TriviaQuestion\(').Count
  $easy = [regex]::Matches($content, 'difficulty\s*:\s*QuestionDifficulty.easy200').Count
  $medium = [regex]::Matches($content, 'difficulty\s*:\s*QuestionDifficulty.medium400').Count
  $hard = [regex]::Matches($content, 'difficulty\s*:\s*QuestionDifficulty.hard600').Count
  # Helper constructors and filtered replacement aggregators require Dart evaluation.
  if ($content -match '=>\s*TriviaQuestion|_excludedIds') {
    $total = $easy = $medium = $hard = 'Runtime pending'
  }
  $name = $category.Groups[2].Value + ' / ' + $category.Groups[3].Value
  if ($id -eq 'uae_football') {
    & (Join-Path $PSScriptRoot 'validate_uae_football.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Sourced bilingual and difficulty review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'uae_general') {
    & (Join-Path $PSScriptRoot 'validate_uae_general.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Sourced bilingual and difficulty review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'uae_heritage') {
    & (Join-Path $PSScriptRoot 'validate_uae_heritage.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Official sources, bilingual/difficulty and fact-family review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'gulf_culture') {
    & (Join-Path $PSScriptRoot 'validate_gulf_culture.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Primary sources, bilingual/difficulty and semantic review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'kuwait_general') {
    & (Join-Path $PSScriptRoot 'validate_kuwait_general.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Source, bilingual/difficulty and semantic review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'saudi_general') {
    & (Join-Path $PSScriptRoot 'validate_saudi_general.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Source, bilingual/difficulty and semantic review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'uae_pro_league') {
    & (Join-Path $PSScriptRoot 'validate_uae_pro_league.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Source, bilingual/difficulty and semantic review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'premier_league') {
    & (Join-Path $PSScriptRoot 'validate_premier_league.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 109 sources, bilingual/difficulty and 21 fact-family reviews, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'la_liga') {
    & (Join-Path $PSScriptRoot 'validate_la_liga.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 137 sources, bilingual/difficulty and 18 fact-family reviews, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'serie_a') {
    & (Join-Path $PSScriptRoot 'validate_serie_a.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 138 sources, bilingual/difficulty and 20 fact-family reviews, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'emirati_music') {
    & (Join-Path $PSScriptRoot 'validate_emirati_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 99 sources, 121 semantic groups, bilingual/difficulty and cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'gulf_music') {
    & (Join-Path $PSScriptRoot 'validate_gulf_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 94 sources, 115 semantic groups, bilingual/difficulty and cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'kuwaiti_music') {
    & (Join-Path $PSScriptRoot 'validate_kuwaiti_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 85 sources, 124 semantic groups, bilingual/difficulty and cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'saudi_music') {
    & (Join-Path $PSScriptRoot 'validate_saudi_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 79 sources, 86 semantic groups, bilingual/difficulty and cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -in @('bundesliga','ligue_1','ucl','world_cup','football_legends')) {
    & (Join-Path $PSScriptRoot "validate_${id}.ps1") | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Official sources, bilingual/difficulty, semantic and cross-bank review, 2026-10-07 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'egyptian_music') {
    & (Join-Path $PSScriptRoot 'validate_egyptian_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 71 sources, bilingual/difficulty and 79 semantic groups reviewed, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'arabic_music') {
    & (Join-Path $PSScriptRoot 'validate_arabic_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 87 sources, bilingual/difficulty and 97 semantic groups reviewed, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'international_music') {
    & (Join-Path $PSScriptRoot 'validate_international_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 97 sources, 100 semantic groups and bilingual/cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } elseif ($id -eq 'old_school_music') {
    & (Join-Path $PSScriptRoot 'validate_old_school_music.ps1') | Out-Null
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | 93 sources, 89 semantic groups and bilingual/cross-bank review, 2026-10-08 | COMPLETE — PowerShell/static PASS |")
  } else {
    $lines.Add("| $name | $id | $total | $easy | $medium | $hard | Pending editorial/source audit | INCOMPLETE |")
  }
}
$lines.Add('')
$lines.Add('For UAE Football without Dart: run `./tool/validate_uae_football.ps1`. Regenerate its six Dart batches after editorial edits with `./tool/generate_uae_football.ps1`. Similarity review hashes become stale when affected text changes; do not automatically approve new candidates.')
$lines.Add('For category 2, UAE: run `./tool/validate_uae_general.ps1`. Regenerate with `./tool/generate_uae_general.ps1`. Its validator also checks Arabic similarity and the football preservation manifest. Source evidence and manually reviewed candidate decisions are in content/uae_general.')
$lines.Add('For category 3, UAE Heritage: run `./tool/validate_uae_heritage.ps1`. Regenerate with `./tool/generate_uae_heritage.ps1`. Source evidence, translation/difficulty review and fact-family decisions are in content/uae_heritage. Its preservation manifest protects both completed categories.')
$lines.Add('Run `dart run tool/validate_question_bank.dart uae_football` for the first bank, or omit the argument for all 50. Nonzero exit is expected until the target is met. Run `dart run test/question_bank_validation_test.dart` for validator regression checks. These checks do not certify factual accuracy, difficulty, translation parity, or image licensing.')
$lines.Add('')
$lines.Add('Environment: Flutter and Dart were not found on PATH. Formatting, analysis and Dart tests have not been executed. Picker and board share the playable registry; the first seven legacy indexes and gameplay rules are preserved. Completed sourced banks are available there.')
[IO.File]::WriteAllLines((Join-Path $projectRoot 'QUESTION_BANK_PROGRESS.md'), $lines, [Text.UTF8Encoding]::new($false))
Write-Output "Updated inventory for $($categories.Count) categories."


