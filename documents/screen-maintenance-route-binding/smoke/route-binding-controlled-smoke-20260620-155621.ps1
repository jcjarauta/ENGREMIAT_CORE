$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
function Invoke-EngremiatHumanMaintenanceCard {
  param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede."
}
# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
# Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
$cmd="m"
while($true){
# ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  
if($cmd -in @("m","mant","mantenimiento")){
    Invoke-EngremiatHumanMaintenanceCard -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
    continue
  }
  # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
break
}
