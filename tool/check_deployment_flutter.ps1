param([switch]$SmokeOnly)
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$prep=Join-Path $root 'deployment-preparation'
$clone=Join-Path $prep 'git-working-copy'
$flutter=Join-Path $prep 'sdk-3.47.6/flutter/bin/flutter.bat'
$dart=Join-Path $prep 'sdk-3.47.6/flutter/bin/dart.bat'
if(!(Test-Path $flutter)){throw 'Verified local SDK not ready'}
$env:CI='true'; $env:FLUTTER_SUPPRESS_ANALYTICS='true'
$env:PUB_CACHE=Join-Path $prep 'pub-cache'
$checks=[Collections.Generic.List[object]]::new()
function Check([string]$name,[string]$program,[string[]]$arguments) {
  $log=Join-Path $prep ($name+'.log')
  & $program @arguments *> $log
  $code=$LASTEXITCODE
  $checks.Add([pscustomobject]@{name=$name;exitCode=$code;log=$log})
  Write-Host "$name exit=$code"
  return $code
}
Push-Location $clone
try {
  if($SmokeOnly){
    $result=Check 'flutter-gameplay-smoke-test' $flutter @('test','--no-pub','test/deployment_smoke_test.dart')
    if($result -ne 0){throw 'Gameplay smoke test failed'}
    return
  }
  $null=Check 'flutter-version' $flutter @('--version','--machine')
  $pub=Check 'flutter-pub-get' $flutter @('pub','get','--enforce-lockfile')
  if($pub -ne 0){throw 'Dependency resolution failed; inspect log before proceeding'}
  $null=Check 'flutter-analyze' $flutter @('analyze')
  $null=Check 'dart-history-test' $dart @('run','test/question_history_test.dart')
  $null=Check 'dart-bank-test' $dart @('run','test/question_bank_validation_test.dart')
  $null=Check 'flutter-gameplay-smoke-test' $flutter @('test','test/deployment_smoke_test.dart')
  $certified=@('uae_football','uae_general','uae_heritage','gulf_culture','kuwait_general','saudi_general','uae_pro_league','premier_league','la_liga','serie_a','bundesliga','ligue_1','ucl','world_cup','football_legends','emirati_music','gulf_music','kuwaiti_music','saudi_music','egyptian_music','arabic_music','international_music','old_school_music')
  $null=Check 'dart-certified-catalog-validation' $dart (@('run','tool/validate_question_bank.dart')+$certified)
  $null=Check 'dart-release-validation' $dart @('run','tool/validate_release.dart')
  if(@($checks | Where-Object exitCode -ne 0).Count){throw 'Required release check failed; web build blocked'}
  $null=Check 'flutter-clean' $flutter @('clean')
  if($LASTEXITCODE -ne 0){throw 'Fresh build cleanup failed'}
  $null=Check 'flutter-web-release' $flutter @('build','web','--release','--base-href','/trivia-game/')
  if(@($checks | Where-Object exitCode -ne 0).Count){throw 'Required release check failed; publication blocked'}
} finally {
  Pop-Location
  $reportName=if($SmokeOnly){'flutter-smoke-check-results.json'}else{'flutter-check-results.json'}
  $checks | ConvertTo-Json -Depth 3 | Set-Content (Join-Path $prep $reportName)
}
# Compare both original and transferred protected files after the toolchain ran.
$protected=@(Get-Content (Join-Path $root 'BATCH_4_13_COMPLETED.json') -Raw | ConvertFrom-Json)+
           @(Get-Content (Join-Path $root 'BATCH_14_23_COMPLETED.json') -Raw | ConvertFrom-Json)
foreach($p in $protected){
  if((Get-FileHash -LiteralPath $p.Path).Hash -ne $p.Hash){throw 'Original protected hash changed'}
  $relative=$p.Path.Substring($root.Length+1)
  if((Get-FileHash -LiteralPath (Join-Path $clone $relative)).Hash -ne $p.Hash){throw "Transferred protected hash changed: $relative"}
}
Write-Output 'Original and transferred protected hashes unchanged.'
