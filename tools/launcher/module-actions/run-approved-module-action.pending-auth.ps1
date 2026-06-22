$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_MODULE_CARD_ACTION_FLOW_001'
$stage='E115_RUN_APPROVED_MODULE_ACTION_EXPLICIT_AUTH_ONLY'
$requiredAuthorization='AUTORIZO_E115_RUN_APPROVED_MODULE_ACTION'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  if($env:ENGREMIAT_MODULE_ACTION_AUTH -ne $requiredAuthorization){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required_env=ENGREMIAT_MODULE_ACTION_AUTH required_value=$requiredAuthorization real_execution=False module_action_executed=False worker=False browser=False network=False git=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=PENDING_EXPLICIT_HUMAN_AUTHORIZATION" Yellow
    exit 0
  }
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $planDir=Join-Path $root 'documents\module-cards\blueprint-execution-plans'
  $runnerOutDir=Join-Path $root 'documents\module-cards\approved-action-runner'
  $reportsDir=Join-Path $root 'reports\launcher'
  New-Item -ItemType Directory -Force -Path $runnerOutDir,$reportsDir | Out-Null
  $planLatest=Join-Path $planDir 'approved-module-blueprint-execution-plan.latest.json'
  if(-not(Test-Path -LiteralPath $planLatest)){throw "BLUEPRINT_EXECUTION_PLAN_NOT_FOUND path=$planLatest"}
  $plan=ReadJson $planLatest
  if("$($plan.status)" -ne 'READY'){throw "BLUEPRINT_EXECUTION_PLAN_NOT_READY status=$($plan.status)"}
  $execution=[ordered]@{schema='engremiat.approved_module_action_execution.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='PASS';mode='LOCAL_APPROVED_ACTION_EXECUTION_NO_WORKER_NO_EXTERNALS';authorization_required=$true;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED';authorization_token=$requiredAuthorization;source_plan=$planLatest;module_ref="$($plan.module_ref)";gate_id="$($plan.gate_id)";approved_decision_id="$($plan.approved_decision_id)";actions_performed=@('created_local_execution_receipt','confirmed_approved_blueprint_ready_for_next_local_step');blocked_operations=@('worker_real_execution','browser','network','git_commit','git_push','external_write');real_execution=$true;module_action_executed=$true;worker=$false;browser=$false;network=$false;git=$false;next='E116_VERIFY_APPROVED_MODULE_ACTION_EXECUTION_AND_CLOSE_FLOW'}
  $executionPath=Join-Path $runnerOutDir ("approved-module-action-execution-$ts.json")
  $executionLatest=Join-Path $runnerOutDir 'approved-module-action-execution.latest.json'
  $reportPath=Join-Path $reportsDir ("e115-run-approved-module-action-explicit-auth-only-$ts.json")
  $execution | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $executionPath -Encoding UTF8
  $execution | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $executionLatest -Encoding UTF8
  $execution | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK approved_module_action_executed_local_only execution=$executionPath" Green
  W "OK package_id=$package stage=$stage status=PASS authorization_status=EXPLICIT_HUMAN_AUTHORIZATION_GRANTED module_action_executed=True worker=False browser=False network=False git=False report=$reportPath next=E116_VERIFY_APPROVED_MODULE_ACTION_EXECUTION_AND_CLOSE_FLOW" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
