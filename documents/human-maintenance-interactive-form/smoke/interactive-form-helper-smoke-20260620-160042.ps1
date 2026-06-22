$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
# ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  Write-Host ""
  Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  $title=Read-Host "Titulo breve"
  if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  if($dimension -notin $allowedDimensions){$dimension="other"}
  $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  $severity=$severity.ToUpperInvariant()
  if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  $observation=Read-Host "Observacion"
  if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  $suggested=Read-Host "Accion sugerida"
  if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  if($title.Length -gt 120){$title=$title.Substring(0,120)}
  if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
}
# ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator-smoke-form" -SourceContext "E05 simulated interactive form smoke"
