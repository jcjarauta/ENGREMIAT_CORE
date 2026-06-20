param([switch]$OpenDashboards)
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$items=@("eng.ps1","docs\DAILY_OPERATIONAL_MANUAL.md","docs\DAILY_LOOP_CHECKLIST.md","dashboard\operational\index.html","dashboard\operational-inbox\index.html","dashboard\decision-history\index.html","data\daily-production-052\production-output.json","data\receipts-rollback-053\daily-receipt-standard.json")
$missing=@();foreach($i in $items){if(!(Test-Path $i)){$missing+=$i}}
Write-Host "ENGREMIAT OPERATIONAL DAILY LOOP DEMO E54" -ForegroundColor Cyan
Write-Host "1 daily: .\eng.ps1 daily" -ForegroundColor Green
Write-Host "2 dashboard: dashboard\operational\index.html" -ForegroundColor Green
Write-Host "3 inbox: dashboard\operational-inbox\index.html" -ForegroundColor Green
Write-Host "4 decisions: dashboard\decision-history\index.html" -ForegroundColor Green
Write-Host "5 production output: data\daily-production-052\production-output.json" -ForegroundColor Green
Write-Host "6 safety standards: data\receipts-rollback-053" -ForegroundColor Green
if($OpenDashboards){foreach($p in @("dashboard\operational\index.html","dashboard\operational-inbox\index.html","dashboard\decision-history\index.html","dashboard\kanban-mvp\index.html")){if(Test-Path $p){Start-Process $p}}}
if($missing.Count -gt 0){throw ("NO_GO E54 demo missing="+($missing -join ","))}
Write-Host "OK objective=ENGREMIAT_POST_MVP_OPERATIONAL_DAILY_LOOP_046_055 stage=E54 demo=ready apply_executed=false auto_apply=false remote_execution=false git_write=false" -ForegroundColor Green
