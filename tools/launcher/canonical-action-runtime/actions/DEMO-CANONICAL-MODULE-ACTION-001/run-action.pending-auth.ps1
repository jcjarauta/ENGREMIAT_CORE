param()
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_LAUNCHER_CANONICAL_ACTION_RUNTIME_001'
$stage='CANONICAL_ACTION_RUN_APPROVED_ACTION_EXPLICIT_AUTH_ONLY'
$actionId='DEMO-CANONICAL-MODULE-ACTION-001'
$safeId='DEMO-CANONICAL-MODULE-ACTION-001'
$requiredAuthorization='AUTORIZO_DEMO-CANONICAL-MODULE-ACTION-001_RUN_ACTION'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage action_id=$actionId" Cyan
  if($env:ENGREMIAT_CANONICAL_ACTION_RUN_AUTH -ne $requiredAuthorization){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required_env=ENGREMIAT_CANONICAL_ACTION_RUN_AUTH required_value=$requiredAuthorization real_execution=False action_executed=False worker=False browser=False network=False git=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=PENDING_EXPLICIT_HUMAN_AUTHORIZATION" Yellow
    exit 0
  }
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $baseDir=Join-Path $root 'documents\launcher-canonical-action-runtime'
  $planPath=Join-Path $baseDir ("plans\$safeId\approved-action-plan.latest.json")
  $statePath=Join-Path $baseDir ("state\$safeId\canonical-action-state.latest.json")
  $execDir=Join-Path $baseDir ("executions\$safeId")
  $reportsDir=Join-Path $root 'reports\launcher-canonical-action-runtime'
  New-Item -ItemType Directory -Force -Path $execDir,$reportsDir | Out-Null
  if(-not(Test-Path -LiteralPath $planPath)){throw "APPROVED_ACTION_PLAN_NOT_FOUND path=$planPath"}
  if(-not(Test-Path -LiteralPath $statePath)){throw "CANONICAL_ACTION_STATE_NOT_FOUND path=$statePath"}
  $plan=ReadJson $planPath
$state=ReadJson $statePath
  if("$($plan.status)" -ne 'READY'){throw "PLAN_NOT_READY status=$($plan.status)"}
  if("$($state.gate_status)" -ne 'APPROVED'){throw "GATE_NOT_APPROVED status=$($state.gate_status)"}
  $state.execution_status='EXECUTED_LOCAL'
$state.safety.action_executed=$true
$state | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $statePath -Encoding UTF8
  $execution=[ordered]@{schema='engremiat.canonical_action_execution_receipt.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='PASS';action_id=$actionId;source_plan=$planPath;canonical_state=$statePath;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED';operation='CREATE_LOCAL_APPROVED_ACTION_RECEIPT';real_execution=$true;action_executed=$true;worker=$false;browser=$false;network=$false;git=$false;next='E12_VERIFY_CANONICAL_ACTION_EXECUTION_AND_CLOSE_RUNTIME'}
  $executionPath=Join-Path $execDir ("action-execution-$ts.json")
$executionLatest=Join-Path $execDir 'action-execution.latest.json'
$reportPath=Join-Path $reportsDir ("canonical-action-execution-$safeId-$ts.json")
$execution | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $executionPath -Encoding UTF8
$execution | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $executionLatest -Encoding UTF8
$execution | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK canonical_action_executed_local_only action_id=$actionId execution=$executionPath" Green
  W "OK package_id=$package stage=$stage status=PASS action_executed=True worker=False browser=False network=False git=False report=$reportPath next=E12_VERIFY_CANONICAL_ACTION_EXECUTION_AND_CLOSE_RUNTIME" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
