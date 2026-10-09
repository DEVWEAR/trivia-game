$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
$root=Split-Path $PSScriptRoot -Parent
$prep=Join-Path $root 'deployment-preparation'
$manifest=Get-Content (Join-Path $prep 'flutter-releases-windows.json') -Raw | ConvertFrom-Json
$release=@($manifest.releases | Where-Object { $_.version -eq '3.47.6' -and $_.channel -eq 'stable' -and $_.dart_sdk_arch -eq 'x64' })
if($release.Count -ne 1){throw 'Exact official release missing'}
if($manifest.base_url -ne 'https://storage.googleapis.com/flutter_infra_release/releases'){throw 'Unexpected download host'}
$zip=Join-Path $prep 'flutter_windows_3.47.6-stable.zip'
if(!(Test-Path -LiteralPath $zip)) {
  Invoke-WebRequest -Uri ($manifest.base_url+'/'+$release[0].archive) -OutFile $zip
}
if((Get-FileHash -LiteralPath $zip).Hash.ToLowerInvariant() -ne $release[0].sha256){throw 'SDK checksum mismatch; will not execute'}
$destination=Join-Path $prep 'sdk-3.47.6'
if(Test-Path -LiteralPath $destination){throw 'SDK destination exists; refusing to overwrite'}
Add-Type -AssemblyName System.IO.Compression
[IO.Compression.ZipFile]::ExtractToDirectory($zip,$destination)
$flutter=Join-Path $destination 'flutter/bin/flutter.bat'
if(!(Test-Path -LiteralPath $flutter)){throw 'SDK executable missing'}
# Process-only settings: no global PATH, registry or existing SDK changes.
$env:CI='true'
$env:FLUTTER_SUPPRESS_ANALYTICS='true'
$env:PUB_CACHE=Join-Path $prep 'pub-cache'
& $flutter --version --machine
if($LASTEXITCODE -ne 0){throw 'Flutter SDK version check failed'}
