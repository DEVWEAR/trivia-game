$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$entries=@(Get-Content (Join-Path $root 'content/release_protected_hashes.json') -Raw | ConvertFrom-Json)
if($entries.Count -ne 667){throw 'Protected release manifest coverage changed'}
foreach($entry in $entries){
  $file=Join-Path $root $entry.path
  if(!(Test-Path -LiteralPath $file) -or (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash -ne $entry.sha256){
    throw "Protected release file missing or changed: $($entry.path)"
  }
}
Write-Output 'PASS: all 667 protected release entries unchanged.'
