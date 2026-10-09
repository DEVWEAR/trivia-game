$ErrorActionPreference='Stop'
$dir=Join-Path $PSScriptRoot '../content/ligue_1'
$rows=@{}
foreach($tier in 'easy','medium','hard'){$rows[$tier]=@(Import-Csv (Join-Path $dir "$tier.psv") -Delimiter '|')}
$q=$rows.easy | Where-Object id -eq '012';$q.questionAr='أي نادٍ حقق مفاجأة التتويج بالدوري الفرنسي عام 2012؟';$q.questionEn='Which club surprised France by winning the league in 2012?'
$q=$rows.medium | Where-Object id -eq '113';$q.questionAr='ما اسم ملعب لوريان الذي يستضيف مبارياته في الدوري الفرنسي؟';$q.questionEn='What is the name of the stadium hosting Lorient''s French league home matches?'
function Swap($a,$ida,$b,$idb){$qa=$rows[$a] | Where-Object id -eq $ida;$qb=$rows[$b] | Where-Object id -eq $idb;$qa.id=$idb;$qb.id=$ida;$rows[$a]=@($rows[$a] | Where-Object {$_ -ne $qa})+@($qb);$rows[$b]=@($rows[$b] | Where-Object {$_ -ne $qb})+@($qa)}
Swap 'easy' '064' 'medium' '092'
Swap 'medium' '119' 'hard' '176'
Swap 'easy' '059' 'medium' '105'
Swap 'easy' '066' 'medium' '094'
foreach($tier in $rows.Keys){$text=@('id|factKey|source|questionAr|questionEn|answerAr|answerEn');$text+=@($rows[$tier] | Sort-Object id | ForEach-Object {($_.id,$_.factKey,$_.source,$_.questionAr,$_.questionEn,$_.answerAr,$_.answerEn) -join '|'});[IO.File]::WriteAllText((Join-Path $dir "$tier.psv"),($text -join "`n")+"`n",[Text.UTF8Encoding]::new($false))}
