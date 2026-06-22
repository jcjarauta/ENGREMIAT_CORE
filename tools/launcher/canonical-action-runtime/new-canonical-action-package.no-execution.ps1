param([string]$ActionId='DEMO-ACTION-001',[string]$ActionType='MODULE_CARD_ACTION',[string]$ProjectRef='ENGREMIAT_PROJECT/demo',[string]$ModuleRef='ENGREMIAT_PROJECT/demo/MODULE_demo/START-001')
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_LAUNCHER_CANONICAL_ACTION_RUNTIME_001'
$stage='FACTORY_CREATE_CANONICAL_ACTION_PACKAGE_NO_EXECUTION'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $safeId=($ActionId -replace '[^A-Za-z0-9_\-]','_')
  $baseDir=Join-Path $root 'documents\launcher-canonical-action-runtime'
  $pkgDir=Join-Path $baseDir ("actions\$safeId")
  $reportsDir=Join-Path $root 'reports\launcher-canonical-action-runtime'
  New-Item -ItemType Directory -Force -Path $pkgDir,$reportsDir | Out-Null
  $gateId="GATE-$safeId"
  $decisionId="DECISION-$safeId"
  $mutationEnv='ENGREMIAT_CANONICAL_ACTION_MUTATION_AUTH'
  $actionEnv='ENGREMIAT_CANONICAL_ACTION_RUN_AUTH'
  $mutationValue="AUTORIZO_$safeId`_GATE_MUTATION"
  $actionValue="AUTORIZO_$safeId`_RUN_ACTION"
  $action=[ordered]@{schema='engremiat.canonical_action_package.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='CREATED_NO_EXECUTION';action_id=$ActionId;action_type=$ActionType;project_ref=$ProjectRef;module_ref=$ModuleRef;gate_id=$gateId;decision_id=$decisionId;requested_transition=[ordered]@{from='PENDING';to='APPROVED'};authorization=[ordered]@{mutation_env=$mutationEnv;mutation_value=$mutationValue;action_env=$actionEnv;action_value=$actionValue};allowed_operations=@('local_file_write','local_json_markdown_evidence','readonly_validation','pending_auth_script_creation');blocked_operations=@('worker_real_execution','browser','network','git_commit','git_push','external_write');state=[ordered]@{gate_status='PENDING';unlock_status='LOCKED';execution_status='NOT_EXECUTED'};safety=[ordered]@{factory_only=$true;real_execution=$false;gate_mutated=$false;action_executed=$false;worker=$false;browser=$false;network=$false;git=$false};next='VALIDATE_CANONICAL_ACTION_PACKAGE_NO_EXECUTION'}
  $actionPath=Join-Path $pkgDir ("canonical-action-package-$ts.json")
  $actionLatest=Join-Path $pkgDir 'canonical-action-package.latest.json'
  $reportPath=Join-Path $reportsDir ("factory-create-canonical-action-package-no-execution-$safeId-$ts.json")
  $action | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $actionPath -Encoding UTF8
  $action | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $actionLatest -Encoding UTF8
  $action | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK canonical_action_package_created action_id=$ActionId package=$actionPath" Green
  W "OK package_id=$package stage=$stage status=PASS real_execution=False gate_mutated=False action_executed=False report=$reportPath next=VALIDATE_CANONICAL_ACTION_PACKAGE_NO_EXECUTION" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
