const fs=require('fs'),path=require('path');
const file=path.resolve(__dirname,'validate_gulf_culture.ps1');
let s=fs.readFileSync(file,'utf8');
const start=s.indexOf('$candidates = @()'),end=s.indexOf('if ($WriteCandidates)',start);
s=s.slice(0,start)+`$scanText = & node (Join-Path $PSScriptRoot 'gulf_similarity.js') gulf_culture
if ($LASTEXITCODE -ne 0) { throw 'Bilingual similarity scanner failed' }
$scan = ($scanText -join "\n") | ConvertFrom-Json
$candidates = @($scan.internal)
$maxEnglishSimilarity = $scan.maximumEnglishSimilarity
$crossReviews=@{}
foreach($r in (Import-Csv (Join-Path $data 'cross_bank_review.csv'))) {$crossReviews[$r.pair]=$r}
$checks.cross_bank_candidates=@($scan.cross).Count
$checks.unresolved_cross_bank_facts=@($scan.cross | Where-Object { $r=$crossReviews[$_.pair]; -not $r -or $r.hash -ne $_.hash -or $r.decision -ne 'distinct' -or -not $r.reason }).Count
if ($checks.unresolved_cross_bank_facts -ne 0) { throw 'Unresolved or stale comparison with completed banks' }
`+s.slice(end);
s=s.replace('$checks.wrong_category_ids =',`foreach ($field in @('questionAr','questionEn','answerAr','answerEn')) {
 $checks["missing_$field"] = @($actual | Where-Object { [string]::IsNullOrWhiteSpace($_.$field) }).Count
}
$checks.wrong_category_ids =`);
s=s.replace("# Flag lexical similarity",`$registry = Get-Content (Join-Path $root 'lib/data/playable_category_registry.dart') -Raw
if ($registry -notmatch "PlayableCategory\\('gulf_culture'" -or $registry -notmatch 'gulfCultureFinalQuestions') {throw 'Gulf Culture missing from playable registry'}
$picker = Get-Content (Join-Path $root 'lib/main.dart') -Raw
$board = Get-Content (Join-Path $root 'lib/game_board.dart') -Raw
if ($picker -notmatch 'playableCategories.map' -or $picker -notmatch 'playableCategories\\[i\\].questions.length' -or $board -notmatch 'playableCategories\\[i\\]') {throw 'Picker/board registry mismatch'}
$checks.playable_registry_check = 'PASS'
# Flag lexical similarity`);
fs.writeFileSync(file,s);
