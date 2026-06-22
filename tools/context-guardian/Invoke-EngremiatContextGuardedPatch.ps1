param([Parameter(Mandatory=$true)][string]$TargetPath,[string]$Operation="validate-target",[switch]$AllowWrite)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$resolver="C:\ENGREMIAT_CORE\tools\context-guardian\Resolve-EngremiatActiveContext.ps1"
if(!(Test-Path -LiteralPath $resolver)){throw "NO_GO missing_context_guardian_resolver"}
& powershell -NoProfile -ExecutionPolicy Bypass -File $resolver | Out-Null
$ctxPath="C:\ENGREMIAT_CORE\reports\context-guardian\active-context.latest.json"
if(!(Test-Path -LiteralPath $ctxPath)){throw "NO_GO missing_active_context_latest"}
$ctx=Get-Content -LiteralPath $ctxPath -Raw -Encoding UTF8|ConvertFrom-Json
$activeRoot=[string]$ctx.active_root
$activeRegistry=[string]$ctx.active_registry
$activeEngine=[string]$ctx.active_engine
$targetFull=[System.IO.Path]::GetFullPath($TargetPath)
$protected=@("C:\ENGREMIAT_CORE\ENGREMIAT.ps1","C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1")
$isProtected=$false
foreach($p in $protected){if($targetFull -ieq ([System.IO.Path]::GetFullPath($p))){$isProtected=$true}}
$insideActive=$false
if($activeRoot -and $targetFull.StartsWith(([System.IO.Path]::GetFullPath($activeRoot)),[System.StringComparison]::OrdinalIgnoreCase)){$insideActive=$true}
$decision="GO_CONTEXT_GUARDED_TARGET"
$reasons=@()
if($ctx.decision -ne "GO_ACTIVE_CONTEXT_RESOLVED"){$decision="NO_GO_CONTEXT_UNCLEAR";$reasons+="context decision is "+[string]$ctx.decision}
if(!$insideActive){$decision="NO_GO_CONTEXT_MISMATCH";$reasons+="target is outside active_root"}
if($isProtected){$decision="NO_GO_PROTECTED_TARGET";$reasons+="target is protected"}
if($AllowWrite -and $decision -ne "GO_CONTEXT_GUARDED_TARGET"){throw ($decision+" :: "+($reasons -join "; "))}
$outDir="C:\ENGREMIAT_CORE\reports\context-guardian-enforcement";New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$report=[ordered]@{created_at=(Get-Date).ToString("s");package_id="ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002";operation=$Operation;allow_write=[bool]$AllowWrite;decision=$decision;reasons=$reasons;target=$targetFull;active_root=$activeRoot;active_registry=$activeRegistry;active_engine=$activeEngine;protected_do_not_patch=$protected;next=if($decision -eq "GO_CONTEXT_GUARDED_TARGET"){"ALLOW_PATCH_ON_ACTIVE_ROOT"}else{"STOP_AND_RESELECT_TARGET"}}
$reportPath=Join-Path $outDir ("guarded-target-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$latest=Join-Path $outDir "guarded-target.latest.json"
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reportPath -Encoding UTF8
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $latest -Encoding UTF8
Write-Host "ENGREMIAT_CONTEXT_GUARDED_PATCH" -ForegroundColor Cyan
Write-Host ("decision="+$decision) -ForegroundColor $(if($decision -eq "GO_CONTEXT_GUARDED_TARGET"){"Green"}else{"Red"})
Write-Host ("target="+$targetFull) -ForegroundColor DarkCyan
Write-Host ("active_root="+$activeRoot) -ForegroundColor DarkCyan
if($reasons.Count -gt 0){foreach($r in $reasons){Write-Host ("reason="+$r) -ForegroundColor Yellow}}
Write-Host ("report="+$reportPath) -ForegroundColor DarkGray
Write-Host ("next="+$report.next) -ForegroundColor Cyan
