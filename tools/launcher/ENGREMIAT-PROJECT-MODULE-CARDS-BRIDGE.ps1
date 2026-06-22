param([string]$ProjectId="ENGREMIAT_CORE",[string]$ModuleId="MODULE_OPERATOR_NAVIGATION")
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core='C:\ENGREMIAT_CORE'
$CardsView=Join-Path $Core 'tools\launcher\ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1'
function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;Read-Host 'Enter';exit 1}
W '==== PROYECTO > MODULOS > TARJETAS ====' Cyan
W ('Proyecto: '+$ProjectId) DarkCyan
W ('Modulo:   '+$ModuleId) DarkCyan
W 'Principio: vista filtrada readonly | PROPOSED no ejecuta | human_gate=SI' DarkCyan
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
W ''
& powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId

