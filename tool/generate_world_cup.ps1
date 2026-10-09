$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$editorial = Join-Path $root 'content/world_cup'
$sources = @{}
foreach ($source in (Import-Csv (Join-Path $editorial 'sources.psv') -Delimiter '|')) {
  if ($sources.ContainsKey($source.key)) { throw "Duplicate source key: $($source.key)" }
  $sources[$source.key] = $source
}
function DartString([string]$value) {
  return "'" + $value.Replace('\', '\\').Replace("'", "\'").Replace('$', '\$') + "'"
}
$target = Join-Path $root 'lib/data/questions/world_cup'
New-Item -ItemType Directory -Path $target -Force | Out-Null
$imports = [Collections.Generic.List[string]]::new()
$spreads = [Collections.Generic.List[string]]::new()
$imports.Add("import '../question_model.dart';")
foreach ($tier in @('easy', 'medium', 'hard')) {
  $rows = @(Import-Csv (Join-Path $editorial "$tier.psv") -Delimiter '|')
  if ($rows.Count -ne 68) { throw "$tier has $($rows.Count) questions" }
  $difficulty = @{easy='easy200'; medium='medium400'; hard='hard600'}[$tier]
  for ($part = 0; $part -lt 2; $part++) {
    $name = "${tier}_$($part + 1)"
    $symbol = "world_cup" + (Get-Culture).TextInfo.ToTitleCase($tier) + ($part + 1)
    $imports.Add("import 'world_cup/$name.dart';")
    $spreads.Add("  ...$symbol,")
    $lines = [Collections.Generic.List[string]]::new()
    $lines.Add("import '../../question_model.dart';")
    $lines.Add('')
    $lines.Add('// Generated from content/world_cup. Edit the PSV and regenerate.')
    $lines.Add("final $symbol = <TriviaQuestion>[")
    foreach ($q in $rows[($part * 34)..($part * 34 + 33)]) {
      $source = $sources[$q.source]
      if (-not $source -or -not $source.evidence) { throw "Missing evidence: $($q.id)" }
      $lines.Add('  TriviaQuestion(')
      $fields = [ordered]@{id="world_cup_v2_$($q.id)";categoryId='world_cup';factKey=$q.factKey;questionAr=$q.questionAr;questionEn=$q.questionEn;answerAr=$q.answerAr;answerEn=$q.answerEn;sourceName=$source.name;sourceUrl=$source.url}
      foreach ($field in $fields.GetEnumerator()) { $lines.Add("    $($field.Key): $(DartString $field.Value),") }
      $lines.Add("    difficulty: QuestionDifficulty.$difficulty,")
      $lines.Add('    lastVerified: DateTime(2026, 10, 7),')
      $lines.Add('  ),')
    }
    $lines.Add('];')
    [IO.File]::WriteAllText((Join-Path $target "$name.dart"), ($lines -join "`n") + "`n", [Text.UTF8Encoding]::new($false))
  }
}
$final = ($imports -join "`n") + "`n`n/// World Cup: 204 verified bilingual questions, 68 per difficulty.`nfinal world_cupFinalQuestions = <TriviaQuestion>[`n" + ($spreads -join "`n") + "`n];`n"
[IO.File]::WriteAllText((Join-Path $root 'lib/data/questions/world_cup_final.dart'), $final, [Text.UTF8Encoding]::new($false))
Write-Output 'Generated 204 World Cup questions in six batches.'

