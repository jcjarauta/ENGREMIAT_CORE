$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$Map=Join-Path $Root "data\desktop-terminal-operator\command-map.json"
Write-Host "ENGREMIAT TERMINAL OPERATOR - PREVIEW" -ForegroundColor Cyan
Write-Host "Workspace: $Root" -ForegroundColor DarkCyan
if(Test-Path $Map){$m=Get-Content $Map -Raw -Encoding UTF8|ConvertFrom-Json;Write-Host "";Write-Host "Comandos disponibles:" -ForegroundColor Yellow;$m.commands|ForEach-Object{Write-Host (" - "+$_.command+" :: "+$_.purpose) -ForegroundColor Gray}}else{Write-Host "command-map.json no encontrado" -ForegroundColor Red}
Write-Host "";Write-Host "Este preview no ejecuta acciones. E02 creara el launcher de escritorio." -ForegroundColor Magenta
