param([string]$RollbackPackPath='data\rollback-pack-103\rollback-pack.json')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective='ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111'
$stage='E103'
if(-not(Test-Path $RollbackPackPath)){throw ('Rollback pack not found: '+$RollbackPackPath)}
$pack=Get-Content $RollbackPackPath -Raw|ConvertFrom-Json
$required=@('rollback_pack_id','target_path','rollback_action','rollback_ready','validation_required')
$missing=@();foreach($r in $required){if(-not($pack.PSObject.Properties.Name -contains $r)){$missing+=$r}}
$ok=($missing.Count -eq 0 -and $pack.rollback_ready -eq $true -and $pack.validation_required -eq $true)
$outDir='reports\rollback-pack-103';New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$report=[ordered]@{objective=$objective;stage=$stage;validation='ROLLBACK_PACK_VALIDATION';rollback_pack_path=$RollbackPackPath;valid=$ok;missing_fields=$missing;rollback_ready=$pack.rollback_ready;validation_required=$pack.validation_required;rollback_executes=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;worker_executed=$false;kanban_real_write=$false;checked_utc=(Get-Date).ToUniversalTime().ToString('o')}
$reportPath=Join-Path $outDir 'rollback-pack-validation-report.json'
$report|ConvertTo-Json -Depth 30|Set-Content $reportPath -Encoding UTF8
if($ok){Write-Host 'OK objective=ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111 stage=E103 rollback_pack_validation=passed rollback_executes=false apply_executed=false git_write=false kanban_real_write=false'}else{Write-Host ('NO_GO objective=ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111 stage=E103 rollback_pack_validation=failed missing_fields='+$missing.Count+' apply_executed=false git_write=false kanban_real_write=false')}
