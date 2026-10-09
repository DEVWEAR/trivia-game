$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$baseline = @(Get-Content (Join-Path $root 'deployment-preparation/source-before.json') -Raw | ConvertFrom-Json)
$allowed = @('.github\workflows\deploy-pages.yml', '.gitignore', 'pubspec.yaml',
  'lib\data\questions\space_questions_013_102.dart',
  'lib\data\questions\two_pics_questions_069_102.dart')
$unexpected = @($baseline | Where-Object {
  $_.path -notin $allowed -and
  (!(Test-Path -LiteralPath (Join-Path $root $_.path)) -or
   (Get-FileHash -LiteralPath (Join-Path $root $_.path)).Hash -ne $_.sha256)
})
if ($unexpected.Count) { throw "Unexpected original-file changes: $($unexpected.path -join ', ')" }
$protected = @(Get-Content (Join-Path $root 'BATCH_4_13_COMPLETED.json') -Raw | ConvertFrom-Json) +
             @(Get-Content (Join-Path $root 'BATCH_14_23_COMPLETED.json') -Raw | ConvertFrom-Json)
foreach ($p in $protected) {
  if ((Get-FileHash -LiteralPath $p.Path).Hash -ne $p.Hash) { throw "Protected file changed: $($p.Path)" }
}
$images = 0
for ($i=1; $i -le 68; $i++) {
  foreach ($side in @(1,2)) {
    $path = Join-Path $root ('assets/two_pics/{0:000}_{1}.jpg' -f $i,$side)
    if (!(Test-Path -LiteralPath $path) -or (Get-Item -LiteralPath $path).Length -eq 0) { throw "Missing image: $path" }
    $images++
  }
}
Get-Content (Join-Path $root 'web/manifest.json') -Raw | ConvertFrom-Json | Out-Null
$psCount = 0
foreach ($file in Get-ChildItem (Join-Path $root 'tool') -Filter '*.ps1') {
  $tokens=$null; $errors=$null
  [Management.Automation.Language.Parser]::ParseFile($file.FullName,[ref]$tokens,[ref]$errors) | Out-Null
  if ($errors.Count) { throw "PowerShell syntax errors: $($file.Name): $errors" }
  $psCount++
}
$jsCount = 0
foreach ($file in Get-ChildItem (Join-Path $root 'tool') -Filter '*.js') {
  & node --check $file.FullName
  if ($LASTEXITCODE -ne 0) { throw "JavaScript syntax failed: $($file.Name)" }
  $jsCount++
}
# Verify the actual ZIP contents against the pre-edit inventory, not just its presence.
Add-Type -AssemblyName System.IO.Compression
$archive = [IO.Compression.ZipFile]::OpenRead((Join-Path $root 'deployment-preparation/source-before.zip'))
try {
  if ($archive.Entries.Count -ne $baseline.Count) { throw 'Backup entry count mismatch' }
  foreach ($entry in $baseline) {
    $item=$archive.GetEntry($entry.path.Replace('\','/'))
    if (!$item) { throw "Backup entry missing: $($entry.path)" }
    $stream=$item.Open(); $sha=[Security.Cryptography.SHA256]::Create()
    try { $digest=[Convert]::ToHexString($sha.ComputeHash($stream)) }
    finally { $stream.Dispose(); $sha.Dispose() }
    if ($digest -ne $entry.sha256) { throw "Backup hash mismatch: $($entry.path)" }
  }
} finally { $archive.Dispose() }
[ordered]@{
  status='PASS'; protected_entries=$protected.Count; changed_protected_files=0
  unexpected_original_file_changes=0; verified_backup_files=$baseline.Count
  required_clue_images=$images; powershell_scripts_parsed=$psCount; javascript_scripts_parsed=$jsCount
  backup_sha256=(Get-FileHash (Join-Path $root 'deployment-preparation/source-before.zip')).Hash
  flutter_available=[bool](Get-Command flutter -ErrorAction SilentlyContinue)
  dart_available=[bool](Get-Command dart -ErrorAction SilentlyContinue)
  dependency_lock_present=(Test-Path (Join-Path $root 'pubspec.lock'))
  git_metadata_present=(Test-Path (Join-Path $root '.git'))
} | ConvertTo-Json
