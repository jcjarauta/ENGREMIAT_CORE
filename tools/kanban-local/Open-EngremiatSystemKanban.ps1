$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root="C:\ENGREMIAT_CORE"
$view=Join-Path $root "docs\kanban-backlog\system-view\ENGREMIAT_SYSTEM_KANBAN.html"
if(!(Test-Path $view)){throw "SYSTEM_KANBAN_VIEW_MISSING"}
Start-Process $view
Write-Host "OK opened=$view" -ForegroundColor Green
