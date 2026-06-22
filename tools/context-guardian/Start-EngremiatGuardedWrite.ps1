param([Parameter(Mandatory=$true)][string]$TargetPath,[string]$PackageId="ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002",[string]$Stage="GUARDED_WRITE_PREFLIGHT",[string]$Operation="guarded-write-preflight")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$guard="C:\ENGREMIAT_CORE\tools\context-guardian\Invoke-EngremiatContextGuardedPatch.ps1"
if(!(Test-Path -LiteralPath $guard)){throw "NO_GO missing_guarded_patch_wrapper"}
$targetFull=[System.IO.Path]::GetFullPath($TargetPath)
$guardOutput=& powershell -NoProfile -ExecutionPolicy Bypass -File $guard -TargetPath $targetFull -Operation $Operation -AllowWrite
$guardExit=$LASTEXITCODE
$latest="C:\ENGREMIAT_CORE\reports\context-guardian-enforcement\guarded-target.latest.json"
if(!(Test-Path -LiteralPath $latest)){throw "NO_GO missing_guarded_target_latest"}
$g=Get-Content -LiteralPath $latest -Raw -Encoding UTF8|ConvertFrom-Json
if($guardExit -ne 0 -or $g.decision -ne "GO_CONTEXT_GUARDED_TARGET"){Write-Host "ENGREMIAT_GUARDED_WRITE_PREFLIGHT" -ForegroundColor Cyan;Write-Host ("decision=NO_GO_GUARDED_WRITE_BLOCKED") -ForegroundColor Red;Write-Host ("guard_decision="+[string]$g.decision) -ForegroundColor Yellow;Write-Host ("target="+$targetFull) -ForegroundColor DarkCyan;Write-Host ("next=STOP_AND_RESELECT_TARGET") -ForegroundColor Cyan;exit 11}
if(!(Test-Path -LiteralPath $targetFull)){throw "NO_GO target_does_not_exist"}
$backupDir=Join-Path ([string]$g.active_root) "backups\guarded-write"
New-Item -ItemType Directory -Force -Path $backupDir|Out-Null
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$safeName=(([System.IO.Path]::GetFileName($targetFull)) -replace "[^a-zA-Z0-9._-]","_")
$backup=Join-Path $backupDir ($safeName+".before-"+$Stage+"-"+$stamp+".bak")
Copy-Item -LiteralPath $targetFull -Destination $backup -Force
$outDir="C:\ENGREMIAT_CORE\reports\context-guardian-enforcement";New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$report=[ordered]@{created_at=(Get-Date).ToString("s");package_id=$PackageId;stage=$Stage;operation=$Operation;decision="GO_GUARDED_WRITE_PREFLIGHT";target=$targetFull;backup=$backup;active_root=[string]$g.active_root;active_registry=[string]$g.active_registry;active_engine=[string]$g.active_engine;guard_report=[string]$latest;next="SAFE_TO_PATCH_TARGET_AFTER_THIS_PREFLIGHT"}
$reportPath=Join-Path $outDir ("guarded-write-preflight-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reportPath -Encoding UTF8
Write-Host "ENGREMIAT_GUARDED_WRITE_PREFLIGHT" -ForegroundColor Cyan
Write-Host "decision=GO_GUARDED_WRITE_PREFLIGHT" -ForegroundColor Green
Write-Host ("target="+$targetFull) -ForegroundColor DarkCyan
Write-Host ("backup="+$backup) -ForegroundColor DarkGray
Write-Host ("report="+$reportPath) -ForegroundColor DarkGray
Write-Host "next=SAFE_TO_PATCH_TARGET_AFTER_THIS_PREFLIGHT" -ForegroundColor Cyan
exit 0
