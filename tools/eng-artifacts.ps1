$ErrorActionPreference='Stop'
param([string]$Mode='latest',[string]$Query='')
$registry='data/registry/artifact-registry.jsonl'
if(-not (Test-Path $registry)){throw 'ARTIFACT_REGISTRY_NOT_FOUND'}
$items=Get-Content $registry -Encoding UTF8|Where-Object{$_}|ForEach-Object{$_|ConvertFrom-Json}
if($Mode -eq 'latest'){$items|Select-Object -Last 20|Format-Table artifact_id,stage,path,exists,status -AutoSize;return}
if($Mode -eq 'missing'){$items|Where-Object{-not $_.exists}|Format-Table artifact_id,stage,path,status -AutoSize;return}
if($Mode -eq 'stage'){$items|Where-Object{$_.stage -eq $Query}|Format-Table artifact_id,stage,path,exists,status -AutoSize;return}
$items|Format-Table artifact_id,stage,path,exists,status -AutoSize
