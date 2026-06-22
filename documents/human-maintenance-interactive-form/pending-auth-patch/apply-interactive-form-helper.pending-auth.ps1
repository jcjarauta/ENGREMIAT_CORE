param([string]$AuthorizationCode="")
$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package="ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_001"
$stage="APPLY_INTERACTIVE_FORM_HELPER_PENDING_AUTH"
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
try{
W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
if($AuthorizationCode -ne "AUTORIZO_INTEGRAR_FORMULARIO_MANTENIMIENTO_OPERATOR"){W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required=AUTORIZO_INTEGRAR_FORMULARIO_MANTENIMIENTO_OPERATOR" Yellow;W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO" Cyan;exit 0}
$target=Join-Path $root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
if(-not(Test-Path -LiteralPath $target)){throw "TARGET_NOT_FOUND path=$target"}
$tokens=$null;$errs=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens,[ref]$errs)|Out-Null
if($errs.Count -gt 0){throw "TARGET_PARSE_BEFORE_FAIL line=$($errs[0].Extent.StartLineNumber) msg=$($errs[0].Message)"}
$raw=Get-Content -LiteralPath $target -Raw -Encoding UTF8
if($raw -match "ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN"){W "OK interactive_form_helper_already_present target=$target" Green;W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan;exit 0}
$helper=@'
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
'@
$candidate=$raw.TrimEnd()+[Environment]::NewLine+[Environment]::NewLine+$helper+[Environment]::NewLine
$tokens2=$null;$errs2=$null;[System.Management.Automation.Language.Parser]::ParseInput($candidate,[ref]$tokens2,[ref]$errs2)|Out-Null
if($errs2.Count -gt 0){throw "CANDIDATE_PARSE_FAIL_NO_WRITE line=$($errs2[0].Extent.StartLineNumber) msg=$($errs2[0].Message)"}
$backupDir=Join-Path $root "documents\human-maintenance-interactive-form\backups";New-Item -ItemType Directory -Force -Path $backupDir|Out-Null
$ts=Get-Date -Format "yyyyMMdd-HHmmss";$backup=Join-Path $backupDir ("Start-EngremiatDesktopOperator.before-interactive-form-"+$ts+".ps1")
Copy-Item -LiteralPath $target -Destination $backup -Force
Set-Content -LiteralPath $target -Value $candidate -Encoding UTF8
$tokens3=$null;$errs3=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens3,[ref]$errs3)|Out-Null
if($errs3.Count -gt 0){Copy-Item -LiteralPath $backup -Destination $target -Force;throw "TARGET_PARSE_AFTER_WRITE_FAIL_RESTORED line=$($errs3[0].Extent.StartLineNumber) msg=$($errs3[0].Message)"}
$after=Get-Content -LiteralPath $target -Raw -Encoding UTF8
if($after -notmatch "Invoke-EngremiatHumanMaintenanceInteractiveForm"){throw "INTERACTIVE_FORM_HELPER_NOT_FOUND_AFTER_WRITE"}
$reportDir=Join-Path $root "reports\human-maintenance-interactive-form";New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$reportPath=Join-Path $reportDir ("apply-interactive-form-helper-"+$ts+".json")
$report=[ordered]@{schema="engremiat.interactive_form_helper_apply.v1";package_id=$package;stage=$stage;created_at=(Get-Date).ToString("s");status="PASS";authorization_status="EXPLICIT_AUTH_GRANTED";target=$target;backup=$backup;helper_present=$true;target_parse_ok=$true;real_execution=$false;system_mutation=$true;screen_mutation=$true;worker=$false;browser=$false;network=$false;git=$false;next="E04_APPLY_INTERACTIVE_FORM_HELPER_WITH_EXPLICIT_AUTH"}
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reportPath -Encoding UTF8
W "OK interactive_form_helper_applied target=$target backup=$backup" Green
W "OK package_id=$package stage=$stage status=PASS authorization_status=EXPLICIT_AUTH_GRANTED report=$reportPath next=E04_APPLY_INTERACTIVE_FORM_HELPER_WITH_EXPLICIT_AUTH" Green
W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
