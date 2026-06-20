param([switch]$OpenDashboards)
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
Write-Host "ENGREMIAT MVP DEMO E43" -ForegroundColor Cyan
Write-Host "1 start: .\eng.ps1 start" -ForegroundColor Green
Write-Host "2 status: .\eng.ps1 status ; .\eng.ps1 next" -ForegroundColor Green
Write-Host "3 prompt: .\eng.ps1 prompt" -ForegroundColor Green
Write-Host "4 decision: .\tools\eng-decision.ps1 -Decision DEFER -Reason demo_safe_defer" -ForegroundColor Green
Write-Host "5 kanban: dashboard\kanban-mvp\index.html" -ForegroundColor Green
Write-Host "6 memory: ENGREMIAT_MEMORY\dashboard\memory\index.html" -ForegroundColor Green
Write-Host "7 demo: dashboard\mvp-demo\index.html" -ForegroundColor Green
if($OpenDashboards){foreach($p in @("dashboard\human-start\index.html","dashboard\kanban-mvp\index.html","ENGREMIAT_MEMORY\dashboard\memory\index.html","dashboard\mvp-demo\index.html")){if(Test-Path $p){Start-Process $p}}}
Write-Host "OK demo_ready=true apply_executed=false auto_apply=false remote_execution=false git_write=false" -ForegroundColor Green
