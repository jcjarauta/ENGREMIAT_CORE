$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$bridge=Join-Path $root "tools/local-kanban-worker-loop/Start-LocalKanbanWorkerBridge.ps1"
$dashboard=Join-Path $root "dashboard/obsidian-local-kanban/index.html"
$url="http://127.0.0.1:8766/health"
$alive=$false
try{$r=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 2;if($r.StatusCode -eq 200){$alive=$true}}catch{$alive=$false}
if($alive){Write-Host "Bridge 8766 ya activo; no se relanza." -ForegroundColor Green}else{Start-Process powershell -ArgumentList @("-NoProfile","-ExecutionPolicy","Bypass","-NoExit","-File",$bridge,"-Port","8766");Start-Sleep -Seconds 1;Write-Host "Bridge lanzado en http://127.0.0.1:8766" -ForegroundColor Green}
Invoke-Item $dashboard
Write-Host "Dashboard abierto. Prueba primero mock; luego Ollama real con gate si procede." -ForegroundColor Magenta
