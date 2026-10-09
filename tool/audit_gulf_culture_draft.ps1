$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$data = Join-Path $root 'content/gulf_culture'
$rows = @('easy','medium','hard') | ForEach-Object {
  $tier = $_
  Import-Csv (Join-Path $data "$tier.psv") -Delimiter '|' | ForEach-Object { $_ | Add-Member tier $tier; $_ }
}
function Normalize([string]$s) { return ([regex]::Replace(([regex]::Replace($s.ToLowerInvariant(),'[\u064B-\u065F\u0670\u0640]','') -replace '[أإآ]','ا'),'[^\p{L}\p{N}]+',' ')).Trim() }
function Hash([string]$s) { return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($s))).ToLowerInvariant() }
function Similarity([string]$a,[string]$b) {
  $ta=@((Normalize $a).Split(' ')|Sort-Object -Unique); $tb=@((Normalize $b).Split(' ')|Sort-Object -Unique)
  return @($ta|Where-Object {$_ -in $tb}).Count / @(@($ta)+@($tb)|Sort-Object -Unique).Count
}
$candidates=@()
for($i=0;$i -lt $rows.Count;$i++) {
  $a=$rows[$i]
  for($j=$i+1;$j -lt $rows.Count;$j++) {
    $b=$rows[$j]; $en=Similarity $a.questionEn $b.questionEn; $ar=Similarity $a.questionAr $b.questionAr
    $fa=($a.factKey -split ':')[0..1] -join ':'; $fb=($b.factKey -split ':')[0..1] -join ':'
    if($en -ge .60 -or $ar -ge .60 -or ($fa -eq $fb -and (Normalize $a.answerEn) -eq (Normalize $b.answerEn))) {
      $candidates += [pscustomobject]@{pair="gulf_culture_v2_$($a.id)/gulf_culture_v2_$($b.id)";hash=(Hash ($a.questionAr+$a.questionEn+$a.answerAr+$a.answerEn+$b.questionAr+$b.questionEn+$b.answerAr+$b.answerEn));similarity=[math]::Round($en,3);factA=$a.factKey;factB=$b.factKey;questionA=$a.questionEn;answerA=$a.answerEn;questionB=$b.questionEn;answerB=$b.answerEn;decision='';reason=''}
    }
  }
}
$candidates | Export-Csv (Join-Path $data 'near_duplicate_candidates.csv') -NoTypeInformation -Encoding utf8
$cross=@()
foreach($category in @('uae_football','uae_general','uae_heritage')) {
  $old=@('easy','medium','hard')|ForEach-Object {Import-Csv (Join-Path $root "content/$category/$_.psv") -Delimiter '|'}
  foreach($a in $rows) { foreach($b in $old) {
    $en=Similarity $a.questionEn $b.questionEn; $ar=Similarity $a.questionAr $b.questionAr
    if($en -ge .5 -or $ar -ge .5 -or $a.factKey -eq $b.factKey) {
      $cross += [pscustomobject]@{pair="gulf_culture_v2_$($a.id)/${category}_v2_$($b.id)";hash=(Hash ($a.questionAr+$a.questionEn+$a.answerAr+$a.answerEn+$b.questionAr+$b.questionEn+$b.answerAr+$b.answerEn));similarity=[math]::Round($en,3);factA=$a.factKey;factB=$b.factKey;questionA=$a.questionEn;answerA=$a.answerEn;questionB=$b.questionEn;answerB=$b.answerEn;decision='';reason=''}
    }
  }}
}
$cross | Export-Csv (Join-Path $data 'cross_bank_candidates.csv') -NoTypeInformation -Encoding utf8
$candidates | Format-Table pair,factA,factB,questionA,questionB -Wrap
$cross | Format-Table pair,factA,factB,questionA,questionB -Wrap
Write-Output "Internal candidates: $($candidates.Count); Cross-bank candidates: $($cross.Count)"
