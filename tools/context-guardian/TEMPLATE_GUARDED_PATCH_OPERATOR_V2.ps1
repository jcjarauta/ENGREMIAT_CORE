$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=<PACKAGE_ID> stage=<STAGE_ID>" Cyan
  $target="<TARGET_PATH>"
  $preflight="C:\ENGREMIAT_CORE\tools\context-guardian\Start-EngremiatGuardedWrite.ps1"
  $pf=& powershell -NoProfile -ExecutionPolicy Bypass -File $preflight -TargetPath $target -PackageId "<PACKAGE_ID>" -Stage "<STAGE_ID>" -Operation "<OPERATION>"
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
  W "ENGREMIAT_PACKAGE_END package=<PACKAGE_ID> status=PASS" Cyan
}catch{
  W "ERR $($_.Exception.Message)" Red
  W "ENGREMIAT_PACKAGE_END package=<PACKAGE_ID> status=FAIL" Red
  throw
}
