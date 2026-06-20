$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$bridge=Join-Path $root "tools/obsidian-to-worker-real-exercise/Start-ObsidianToWorkerRealExerciseBridge.ps1"
$html=Join-Path $root "dashboard/obsidian-to-worker-real-exercise/index.html"
$cards=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
Start-Process powershell -ArgumentList @("-NoProfile","-ExecutionPolicy","Bypass","-File",$bridge,"-Port","8771") -WindowStyle Minimized
Start-Sleep -Milliseconds 900
Invoke-Item $cards
Invoke-Item $html
Write-Host "OK real_exercise_dashboard_open=True bridge=http://127.0.0.1:8771 cards=$cards html=$html" -ForegroundColor Green
