$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$bridge=Join-Path $root "tools/obsidian-to-worker-real-exercise/Start-ObsidianToWorkerRealExerciseBridge.ps1"
$panel=Join-Path $root "dashboard/real-card-lifecycle-panel/index.html"
$cards=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
$ok=$false
try{
  $h=Invoke-RestMethod -Uri "http://127.0.0.1:8771/health" -TimeoutSec 2
  $ok=($h.status -eq "OK")
}catch{$ok=$false}
if(-not $ok){
  Start-Process powershell -ArgumentList @("-NoProfile","-ExecutionPolicy","Bypass","-File",$bridge,"-Port","8771") -WindowStyle Minimized
  Start-Sleep -Milliseconds 900
}
Invoke-Item $panel
Write-Host "OK lifecycle_panel_open=True bridge=http://127.0.0.1:8771 panel=$panel cards=$cards" -ForegroundColor Green
