$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002 stage=E04_TEMPLATE_DRY_RUN_NO_CHANGE_EXPECTED" Cyan
  $target="C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1"
  $preflight="C:\ENGREMIAT_CORE\tools\context-guardian\Start-EngremiatGuardedWrite.ps1"
  $pf=& powershell -NoProfile -ExecutionPolicy Bypass -File $preflight -TargetPath $target -PackageId "ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002" -Stage "E04_TEMPLATE_DRY_RUN_NO_CHANGE_EXPECTED" -Operation "template-dry-run-no-change"
  $pfExit=$LASTEXITCODE
  W ($pf -join "`r`n") Gray
  if($pfExit -ne 0){throw "NO_GO_GUARDED_PREFLIGHT_EXIT=$pfExit"}
  $latest="C:\ENGREMIAT_CORE\reports\context-guardian-enforcement\guarded-write-preflight.latest.json"
  $guardReport=Get-ChildItem "C:\ENGREMIAT_CORE\reports\context-guardian-enforcement" -Filter "guarded-write-preflight-*.json"|Sort-Object LastWriteTime -Descending|Select-Object -First 1
  if(!$guardReport){throw "missing_guarded_write_report"}
  $g=Get-Content -LiteralPath $guardReport.FullName -Raw -Encoding UTF8|ConvertFrom-Json
  $backup=[string]$g.backup
  if(!(Test-Path -LiteralPath $backup)){throw "missing_backup_from_preflight"}
  $before=Get-Content -LiteralPath $target -Raw -Encoding UTF8
  # PATCH_BEGIN: sustituir este bloque por el cambio real
  $after=$before
  # PATCH_END
  if($after -eq $before){throw "PATCH_NO_CHANGE"}
  Set-Content -LiteralPath $target -Value $after -Encoding UTF8
  try{$null=[scriptblock]::Create((Get-Content -LiteralPath $target -Raw -Encoding UTF8))}catch{Copy-Item -LiteralPath $backup -Destination $target -Force;throw "PARSE_FAIL_RESTORED_BACKUP $($_.Exception.Message)"}
  W "OK guarded_patch_applied=True" Green
  W "OK target=$target" Green
  W "OK backup=$backup" DarkGray
  W "ENGREMIAT_PACKAGE_END package=ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002 status=PASS" Cyan
}catch{
  W "ERR $($_.Exception.Message)" Red
  W "ENGREMIAT_PACKAGE_END package=ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002 status=FAIL" Red
  throw
}

