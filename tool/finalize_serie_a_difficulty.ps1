$ErrorActionPreference='Stop'
$dir=Join-Path $PWD 'content/serie_a'
$banks=@{}
foreach($tier in @('easy','medium','hard')) { $banks[$tier]=@(Get-Content "$dir/$tier.psv") }
function SwapRows($a,$idA,$b,$idB) {
 $rowA=@($banks[$a] | Where-Object { $_ -match "^$idA\|" })[0]
 $rowB=@($banks[$b] | Where-Object { $_ -match "^$idB\|" })[0]
 $banks[$a]=@($banks[$a] | ForEach-Object { if($_ -match "^$idA\|") { $idA+$rowB.Substring(3) } else { $_ } })
 $banks[$b]=@($banks[$b] | ForEach-Object { if($_ -match "^$idB\|") { $idB+$rowA.Substring(3) } else { $_ } })
}
SwapRows 'easy' '043' 'medium' '122'
SwapRows 'easy' '066' 'medium' '108'
SwapRows 'medium' '096' 'hard' '181'
foreach($tier in @('easy','medium','hard')) {
 $banks[$tier]=$banks[$tier] | ForEach-Object { $_.Replace('ما اللونان اللذان يشيران إليهما لقب','ما اللونان اللذان يشير إليهما لقب').Replace('عام 1970 بقيادة جيجي ريفا؟','عام 1970 بوجود جيجي ريفا في الهجوم؟').Replace('بتسديدة مباشرة من قرب خط المنتصف','بتسديدة على الطائر من قرب خط المنتصف') }
 [IO.File]::WriteAllText("$dir/$tier.psv",($banks[$tier] -join "`n")+"`n",[Text.UTF8Encoding]::new($false))
}
