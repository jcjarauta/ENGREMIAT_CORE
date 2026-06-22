param()
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001'
$stage='APPLY_LAUNCHER_RUNTIME_UI_PATCH_EXPLICIT_AUTH_ONLY'
$requiredAuthorization='AUTORIZO_LAUNCHER_RUNTIME_UI_PATCH'
$targetPath='C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1'
$adapterScript='C:\ENGREMIAT_CORE\tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  if($env:ENGREMIAT_LAUNCHER_RUNTIME_UI_PATCH_AUTH -ne $requiredAuthorization){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required_env=ENGREMIAT_LAUNCHER_RUNTIME_UI_PATCH_AUTH required_value=$requiredAuthorization real_execution=False ui_mutated=False worker=False browser=False network=False git=False target=$targetPath" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=PENDING_EXPLICIT_HUMAN_AUTHORIZATION" Yellow
    exit 0
  }
  if([string]::IsNullOrWhiteSpace($targetPath)){throw "TARGET_LAUNCHER_FILE_NOT_RESOLVED"}
  if($targetPath -match '\.bak$|\.backup$|\.old$|\.tmp$|\.pre-|\.e\d+[a-z]?-pre-'){throw "REFUSE_TO_PATCH_BACKUP_TARGET path=$targetPath"}
  if(-not(Test-Path -LiteralPath $targetPath)){throw "TARGET_LAUNCHER_FILE_NOT_FOUND path=$targetPath"}
  if(-not(Test-Path -LiteralPath $adapterScript)){throw "ADAPTER_SCRIPT_NOT_FOUND path=$adapterScript"}
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $reportsDir=Join-Path $root 'reports\launcher-runtime-ui-integration'
  $evidenceDir=Join-Path $root 'documents\launcher-runtime-ui-integration\patch-application'
  New-Item -ItemType Directory -Force -Path $reportsDir,$evidenceDir | Out-Null
  $backup=Join-Path $evidenceDir ("launcher-target-backup-$ts"+[IO.Path]::GetExtension($targetPath))
  Copy-Item -LiteralPath $targetPath -Destination $backup -Force
  $content=Get-Content -LiteralPath $targetPath -Raw -Encoding UTF8
  $markerBegin='# ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN'
  $markerEnd='# ENGREMIAT_RUNTIME_UI_INTEGRATION_END'
  if($content -notmatch [regex]::Escape($markerBegin)){
    $snippet=@($markerBegin,'# Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001','# Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado','# Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.',$markerEnd) -join [Environment]::NewLine
    Add-Content -LiteralPath $targetPath -Encoding UTF8 -Value ([Environment]::NewLine+$snippet+[Environment]::NewLine)
  }
  $receipt=[ordered]@{schema='engremiat.launcher_runtime_ui_patch_application.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='PASS';target=$targetPath;backup=$backup;adapter=$adapterScript;marker=$markerBegin;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED';real_execution=$true;ui_mutated=$true;worker=$false;browser=$false;network=$false;git=$false;next='E09_SMOKE_REAL_LAUNCHER_RUNTIME_MENU'}
  $receiptPath=Join-Path $evidenceDir ("launcher-runtime-ui-patch-application-$ts.json")
  $receiptLatest=Join-Path $evidenceDir 'launcher-runtime-ui-patch-application.latest.json'
  $reportPath=Join-Path $reportsDir ("launcher-runtime-ui-patch-application-$ts.json")
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $receiptPath -Encoding UTF8
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $receiptLatest -Encoding UTF8
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK launcher_runtime_ui_patch_applied target=$targetPath backup=$backup" Green
  W "OK package_id=$package stage=$stage status=PASS ui_mutated=True worker=False browser=False network=False git=False report=$reportPath next=E09_SMOKE_REAL_LAUNCHER_RUNTIME_MENU" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
