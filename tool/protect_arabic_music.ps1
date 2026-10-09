$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$manifest=Join-Path $root 'BATCH_14_23_COMPLETED.json'
$items=@(Get-Content $manifest -Raw | ConvertFrom-Json)
$files=@(Get-ChildItem (Join-Path $root 'content/arabic_music') -File)
$files+=@(Get-ChildItem (Join-Path $root 'lib/data/questions/arabic_music') -File)
$files+=Get-Item (Join-Path $root 'lib/data/questions/arabic_music_final.dart')
$files+=Get-Item (Join-Path $root 'ARABIC_MUSIC_AUDIT.md')
$files+=@(Get-ChildItem (Join-Path $root 'tool') -File | Where-Object Name -Match 'arabic_music')
foreach($file in $files){if($items.Path -contains $file.FullName){throw "Already protected: $($file.FullName)"};$items+=[pscustomobject]@{Path=$file.FullName;Hash=(Get-FileHash $file.FullName -Algorithm SHA256).Hash}}
[IO.File]::WriteAllText($manifest,($items|ConvertTo-Json -Depth 6)+"`n",[Text.UTF8Encoding]::new($false))
Write-Output "Protected $($files.Count) Arabic Music files."
