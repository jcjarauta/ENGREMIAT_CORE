$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([string]$Core="C:\ENGREMIAT_CORE")
$Heartbeat=Join-Path $Core "documents\worker-sync\worker-heartbeat.example.json"
$OutDir=Join-Path $Core "documents\obsidian-sync\demo"
New-Item -ItemType Directory -Force -Path $OutDir|Out-Null
$h=Get-Content $Heartbeat -Raw|ConvertFrom-Json
$md=Join-Path $OutDir ($h.project_id+".md")
$lines=@("---","type: project","project_id: "+$h.project_id,"worker_id: "+$h.worker_id,"task_id: "+$h.task_id,"state: "+$h.state,"progress_pct: "+$h.progress_pct,"heartbeat_at: "+$h.heartbeat_at,"---","","# "+$h.project_id,"","Estado: **"+$h.state+"**","","Progreso: "+$h.progress_pct+"%","","Worker: [["+$h.worker_id+"]]","","Task: [["+$h.task_id+"]]","","Next: "+$h.next_action)
$lines|Set-Content $md -Encoding UTF8
Write-Host "OK obsidian_heartbeat_sync_demo=$md" -ForegroundColor Green
