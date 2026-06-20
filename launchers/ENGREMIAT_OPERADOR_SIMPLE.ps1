$ErrorActionPreference="Continue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Host "";Write-Host "==== $t ====" -ForegroundColor $c;foreach($x in $l){Write-Host ([string]$x) -ForegroundColor $c}}
$root="C:\ENGREMIAT_CORE"
$reports=Join-Path $root "reports\desktop-launcher"
[System.IO.Directory]::CreateDirectory($reports)|Out-Null
Set-Location $root
B "ENGREMIAT OPERADOR" @("launcher=simple_robusto","root=$root","status=buscando_entrypoint") "Cyan"
$candidates=@("C:\ENGREMIAT_CORE\tools\operator-navigation-model\Start-OperatorNavigationModel.ps1","C:\ENGREMIAT_CORE\tools\operator-navigation-model\Start-Operator.ps1","C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-DesktopTerminalOperator.ps1","C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-TerminalOperator.ps1","C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-Operator.ps1","C:\ENGREMIAT_CORE\tools\terminal-operator\Start-TerminalOperator.ps1","C:\ENGREMIAT_CORE\up-engremiat.ps1")
$found=""
foreach($c in $candidates){if((Test-Path -LiteralPath $c) -and $found -eq ""){$found=$c}}
if($found -ne ""){B "OK" @("entrypoint=$found","accion=iniciando") "Green";powershell -NoProfile -ExecutionPolicy Bypass -File $found;exit}
B "NO_GO" @("No se encontro entrypoint por rutas fijas.","Se abrira diagnostico local.","No uses launcher antiguo para crear proyectos hasta reparar entrypoint.") "Yellow"
$out=Join-Path $reports ("operator-entrypoint-scan-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".txt")
$scan=Get-ChildItem -LiteralPath $root -Recurse -File -Include *.ps1,*.cmd,*.bat -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notlike "*\reports\*" -and $_.FullName -notlike "*\backups\*" -and $_.FullName -notlike "*\node_modules\*" -and $_.FullName -notlike "*\.git\*" -and ($_.Name -like "*operator*" -or $_.Name -like "*operador*" -or $_.FullName -like "*operator*") } | Select-Object -First 80
Set-Content -LiteralPath $out -Encoding UTF8 -Value ($scan | ForEach-Object { $_.FullName })
B "DIAGNOSTICO" @("Reporte=$out","Pega el contenido del reporte si no arranca.","Puedes probar manualmente el script correcto desde esa lista.") "Yellow"
Start-Process explorer.exe $reports
Read-Host "Enter para salir"
