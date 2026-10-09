$ErrorActionPreference='Stop'
$dir=Join-Path $PSScriptRoot '../content/ligue_1'
$rows=@{}
foreach($tier in 'easy','medium','hard'){$rows[$tier]=@(Import-Csv (Join-Path $dir "$tier.psv") -Delimiter '|')}
function SetQuestion($id,$ar,$en){foreach($tier in $rows.Keys){$q=$rows[$tier] | Where-Object id -eq $id;if($q){$q.questionAr=$ar;$q.questionEn=$en;return}}}
SetQuestion '045' 'أي مدرب أرجنتيني تولى تدريب مارسيليا عام 2014؟' 'Which Argentine coach took charge of Marseille in 2014?'
SetQuestion '119' 'من مدافع بوردو الألماني الأصل الذي نال الجنسية الفرنسية عام 1982؟' 'Which German-born Bordeaux defender became a French citizen in 1982?'
SetQuestion '143' 'أي نادٍ أحرز لقب الدوري الفرنسي عام 1947؟' 'Which club won the French league title in 1947?'
$q=$rows.easy | Where-Object id -eq '061'
$q.factKey='coach:luisenrique:2025award';$q.source='coach_awards';$q.questionAr='من المدرب الإسباني لباريس سان جيرمان الذي نال جائزة أفضل مدرب في الدوري الفرنسي عام 2025؟';$q.questionEn='Which Spanish Paris Saint-Germain coach won Ligue 1 Coach of the Year in 2025?';$q.answerAr='لويس إنريكي';$q.answerEn='Luis Enrique'
$q=$rows.medium | Where-Object id -eq '129'
$q.factKey='coach:garcia:2011award';$q.source='coach_awards';$q.questionAr='من المدرب الذي نال جائزة أفضل مدرب في الدوري الفرنسي مع ليل عام 2011؟';$q.questionEn='Which coach won Ligue 1 Coach of the Year with Lille in 2011?';$q.answerAr='رودي غارسيا';$q.answerEn='Rudi Garcia'
function Swap($a,$ida,$b,$idb){$qa=$rows[$a] | Where-Object id -eq $ida;$qb=$rows[$b] | Where-Object id -eq $idb;$qa.id=$idb;$qb.id=$ida;$rows[$a]=@($rows[$a] | Where-Object {$_ -ne $qa})+@($qb);$rows[$b]=@($rows[$b] | Where-Object {$_ -ne $qb})+@($qa)}
Swap 'medium' '131' 'hard' '150'
Swap 'medium' '126' 'hard' '197'
foreach($tier in $rows.Keys){$text=@('id|factKey|source|questionAr|questionEn|answerAr|answerEn');$text+=@($rows[$tier] | Sort-Object id | ForEach-Object {($_.id,$_.factKey,$_.source,$_.questionAr,$_.questionEn,$_.answerAr,$_.answerEn) -join '|'});[IO.File]::WriteAllText((Join-Path $dir "$tier.psv"),($text -join "`n")+"`n",[Text.UTF8Encoding]::new($false))}
