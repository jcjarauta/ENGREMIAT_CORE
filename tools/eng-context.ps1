$ErrorActionPreference='Stop'
param([string]$Mode='short')
$p='data/dev/context-snapshot.json'
if(-not (Test-Path $p)){throw 'CONTEXT_SNAPSHOT_NOT_FOUND'}
$c=Get-Content $p -Raw -Encoding UTF8|ConvertFrom-Json
if($Mode -eq 'full'){$c|ConvertTo-Json -Depth 30;return}
if($Mode -eq 'chat'){Get-Content 'reports/context/last-context.txt' -Raw -Encoding UTF8;return}
Write-Host ('OK context objective='+$c.active_objective+' stage='+$c.active_stage+' last='+$c.last_validated_stage+' next='+$c.next_stage+' readiness='+$c.readiness.current+' decision='+$c.readiness.decision)
