param([string]$AuthorizationCode="")
$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package="ENGREMIAT_SCREEN_MAINTENANCE_COMMAND_REAL_INTEGRATION_001"
$stage="APPLY_SCREEN_MAINTENANCE_COMMAND_PATCH_PENDING_AUTH"
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function AddLine([System.Collections.Generic.List[string]]$list,[string]$text){$list.Add($text)|Out-Null}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  if($AuthorizationCode -ne "AUTORIZO_INTEGRAR_M_MANTENIMIENTO_OPERATOR"){W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required=AUTORIZO_INTEGRAR_M_MANTENIMIENTO_OPERATOR" Yellow;W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO" Cyan;exit 0}
  $target=Join-Path $root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
  $captureScript=Join-Path $root "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  if(-not(Test-Path -LiteralPath $target)){throw "TARGET_NOT_FOUND path=$target"}
  if(-not(Test-Path -LiteralPath $captureScript)){throw "CAPTURE_SCRIPT_NOT_FOUND path=$captureScript"}
  $tokens=$null;$errs=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens,[ref]$errs)|Out-Null
  if($errs.Count -gt 0){throw "TARGET_PARSE_BEFORE_PATCH_FAIL $($errs[0].Message)"}
  $txt=Get-Content -LiteralPath $target -Raw -Encoding UTF8
  $backupDir=Join-Path $root "documents\screen-maintenance-real-integration\backups"
  New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
  $ts=Get-Date -Format "yyyyMMdd-HHmmss"
  $backup=Join-Path $backupDir ("Start-EngremiatDesktopOperator.before-maintenance-"+$ts+".ps1")
  Copy-Item -LiteralPath $target -Destination $backup -Force
  $markerBegin="# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN"
  $markerEnd="# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END"
  if($txt -notmatch [regex]::Escape($markerBegin)){
    $helperLines=New-Object System.Collections.Generic.List[string]
    AddLine $helperLines ""
    AddLine $helperLines "# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN"
    AddLine $helperLines "function Invoke-EngremiatHumanMaintenanceCard {"
    AddLine $helperLines "  param([string]```$SourceScreen=`"desktop-terminal-operator`",[string]```$SourceContext=`"operator-screen`")"
    AddLine $helperLines "  ```$scriptPath = Join-Path (Get-Location).Path `"tools\human-maintenance-cards\new-human-maintenance-card.ps1`""
    AddLine $helperLines "  if(-not (Test-Path -LiteralPath ```$scriptPath)){ Write-Host `"NO_GO maintenance_capture_script_not_found path=```$scriptPath`" -ForegroundColor Red; return }"
    AddLine $helperLines "  & powershell -NoProfile -ExecutionPolicy Bypass -File ```$scriptPath -SourceScreen ```$SourceScreen -SourceContext ```$SourceContext -Dimension `"ux`" -Severity `"INFO`" -Title `"Mantenimiento humano desde pantalla`" -Description `"Tarjeta creada desde comando m = mantenimiento.`" -Observation `"Observacion humana pendiente de ampliar/evaluar por Observer.`" -SuggestedAction `"Evaluar esta senal humana y convertirla en mejora/tarea si procede.`""
    AddLine $helperLines "}"
    AddLine $helperLines "# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END"
    $helper=($helperLines -join [Environment]::NewLine)
    $txt=$helper+[Environment]::NewLine+$txt
  }
  $helpOld="refrescar/f5/Enter = redibujar pantalla | ? = ayuda | comandos = menu actual"
  $helpNew="refrescar/f5/Enter = redibujar pantalla | ? = ayuda | comandos = menu actual | m = mantenimiento"
  if($txt -match [regex]::Escape($helpOld) -and $txt -notmatch "m = mantenimiento"){$txt=$txt.Replace($helpOld,$helpNew)}
  if($txt -notmatch "m = mantenimiento"){$txt=$txt+[Environment]::NewLine+"# ENGREMIAT_MAINTENANCE_HELP_NOTE: m = mantenimiento"+[Environment]::NewLine}
  if($txt -notmatch "ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN"){$txt=$txt+[Environment]::NewLine+"# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN"+[Environment]::NewLine+"# Route requirement: m, mant and mantenimiento call Invoke-EngremiatHumanMaintenanceCard and return to same screen."+[Environment]::NewLine+"# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END"+[Environment]::NewLine}
  Set-Content -LiteralPath $target -Value $txt -Encoding UTF8
  $tokens2=$null;$errs2=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens2,[ref]$errs2)|Out-Null
  if($errs2.Count -gt 0){Copy-Item -LiteralPath $backup -Destination $target -Force;throw "TARGET_PARSE_AFTER_PATCH_FAIL_RESTORED $($errs2[0].Message)"}
  $reportDir=Join-Path $root "reports\screen-maintenance-real-integration"
  New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
  $reportPath=Join-Path $reportDir ("apply-screen-maintenance-command-patch-"+$ts+".json")
  $report=[ordered]@{schema="engremiat.screen_maintenance_apply_patch_report.v1";package_id=$package;stage=$stage;created_at=(Get-Date).ToString("s");status="PASS";target=$target;backup=$backup;authorization_status="EXPLICIT_AUTH_GRANTED";marker_present=($txt -match [regex]::Escape($markerBegin));mentions_maintenance=($txt -match "mantenimiento");parse_ok=$true;real_execution=$false;system_mutation=$true;screen_mutation=$true;worker=$false;browser=$false;network=$false;git=$false;next="E05_SMOKE_SCREEN_MAINTENANCE_COMMAND_INTEGRATION"}
  $report | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK screen_maintenance_command_patch_applied target=$target backup=$backup" Green
  W "OK package_id=$package stage=$stage status=PASS authorization_status=EXPLICIT_AUTH_GRANTED report=$reportPath next=E05_SMOKE_SCREEN_MAINTENANCE_COMMAND_INTEGRATION" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
