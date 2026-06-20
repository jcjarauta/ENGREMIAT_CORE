$ErrorActionPreference='Stop'
param([string]$Mode='current')
$p='reports/readiness/current-readiness.json'
if(-not (Test-Path $p)){throw 'CURRENT_READINESS_NOT_FOUND'}
$r=Get-Content $p -Raw -Encoding UTF8|ConvertFrom-Json
if($Mode -eq 'json'){$r|ConvertTo-Json -Depth 30;return}
if($Mode -eq 'blockers'){$r.blockers|Format-Table -AutoSize;return}
Write-Host ('OK tool=readiness objective='+$r.objective+' stage='+$r.stage+' readiness='+$r.readiness+' decision='+$r.decision+' pending_gates='+$r.pending_gates+' next='+$r.next)
