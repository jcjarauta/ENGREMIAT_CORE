param([string]$TargetPath='data/safe-apply-runtime-106/controlled-local-apply-target.json',[string]$RollbackPackPath='data\rollback-pack-103\rollback-pack.json',[string]$ApplyResultPath='data\controlled-apply-106\controlled-apply-result.json')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective='ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111'
$stage='E104'
$outDir='reports\postcheck-runner-104';New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$targetLocal=$TargetPath -replace '/','\'
$rollbackExists=Test-Path $RollbackPackPath
$targetExists=Test-Path $targetLocal
$applyResultExists=Test-Path $ApplyResultPath
$rollbackValid=$false;if($rollbackExists){try{$rb=Get-Content $RollbackPackPath -Raw|ConvertFrom-Json;$rollbackValid=($rb.rollback_ready -eq $true)}catch{$rollbackValid=$false}}
$ok=($rollbackExists -and $rollbackValid)
$report=[ordered]@{objective=$objective;stage=$stage;postcheck='SAFE_LOCAL_POSTCHECK';target_path=$TargetPath;target_exists=$targetExists;rollback_pack_exists=$rollbackExists;rollback_valid=$rollbackValid;apply_result_exists=$applyResultExists;postcheck_passed=$ok;postcheck_executes_safe_readonly=$true;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;worker_executed=$false;kanban_real_write=$false;checked_utc=(Get-Date).ToUniversalTime().ToString('o')}
$reportPath=Join-Path $outDir 'postcheck-runner-validation-report.json'
$report|ConvertTo-Json -Depth 30|Set-Content $reportPath -Encoding UTF8
if($ok){Write-Host 'OK objective=ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111 stage=E104 postcheck_runner=passed readonly=true apply_executed=false git_write=false kanban_real_write=false'}else{Write-Host 'NO_GO objective=ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111 stage=E104 postcheck_runner=failed readonly=true apply_executed=false git_write=false kanban_real_write=false'}
