param()
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_LAUNCHER_CANONICAL_ACTION_RUNTIME_001'
$stage='CANONICAL_ACTION_APPLY_GATE_MUTATION_EXPLICIT_AUTH_ONLY'
$actionId='DEMO-CANONICAL-MODULE-ACTION-001'
$safeId='DEMO-CANONICAL-MODULE-ACTION-001'
$requiredAuthorization='AUTORIZO_DEMO-CANONICAL-MODULE-ACTION-001_GATE_MUTATION'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage action_id=$actionId" Cyan
  if($env:ENGREMIAT_CANONICAL_ACTION_MUTATION_AUTH -ne $requiredAuthorization){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required_env=ENGREMIAT_CANONICAL_ACTION_MUTATION_AUTH required_value=$requiredAuthorization real_execution=False gate_mutated=False action_executed=False worker=False browser=False network=False git=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=PENDING_EXPLICIT_HUMAN_AUTHORIZATION" Yellow
    exit 0
  }
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $statePath=Join-Path $root ("documents\launcher-canonical-action-runtime\state\$safeId\canonical-action-state.latest.json")
  $reportsDir=Join-Path $root 'reports\launcher-canonical-action-runtime'
  $contractsDir=Join-Path $root ("documents\launcher-canonical-action-runtime\contracts\$safeId")
  New-Item -ItemType Directory -Force -Path $reportsDir,$contractsDir | Out-Null
  if(-not(Test-Path -LiteralPath $statePath)){throw "CANONICAL_ACTION_STATE_NOT_FOUND path=$statePath"}
  $state=ReadJson $statePath
  if("$($state.state_file_role)" -ne 'CANONICAL_MUTABLE_ACTION_STATE'){throw "INVALID_STATE_ROLE role=$($state.state_file_role)"}
  if("$($state.gate_status)" -ne 'PENDING'){throw "GATE_NOT_PENDING status=$($state.gate_status)"}
  $backup=Join-Path (Split-Path -Parent $statePath) ("canonical-action-state.before-mutation-$ts.json")
  Copy-Item -LiteralPath $statePath -Destination $backup -Force
  $history=@();if($state.history){$history=@($state.history)}
  $history += [ordered]@{event='CANONICAL_GATE_MUTATION_APPLIED';at=(Get-Date).ToString('s');from='PENDING';to='APPROVED';authorization=$requiredAuthorization;backup=$backup}
  $state.gate_status='APPROVED'
  $state.unlock_status='UNLOCKED_AFTER_APPROVAL'
  $state.approved_decision_id="DECISION-$safeId"
  $state.last_transition=[ordered]@{event='APPROVE_CANONICAL_ACTION';at=(Get-Date).ToString('s');from='PENDING';to='APPROVED';authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED'}
  $state.history=$history
  $state.safety.real_execution=$true
  $state.safety.gate_mutated=$true
  $state | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $statePath -Encoding UTF8
  $receipt=[ordered]@{schema='engremiat.canonical_action_gate_mutation_receipt.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='PASS';action_id=$actionId;canonical_state=$statePath;backup=$backup;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED';gate_status='APPROVED';real_execution=$true;gate_mutated=$true;action_executed=$false;worker=$false;browser=$false;network=$false;git=$false;next='E10_VERIFY_CANONICAL_ACTION_GATE_MUTATION_AND_CREATE_UNLOCK'}
  $receiptPath=Join-Path $contractsDir ("gate-mutation-receipt-$ts.json")
  $receiptLatest=Join-Path $contractsDir 'gate-mutation-receipt.latest.json'
  $reportPath=Join-Path $reportsDir ("canonical-action-gate-mutation-$safeId-$ts.json")
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $receiptPath -Encoding UTF8
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $receiptLatest -Encoding UTF8
  $receipt | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK canonical_action_gate_mutation_applied action_id=$actionId state=$statePath" Green
  W "OK package_id=$package stage=$stage status=PASS action_id=$actionId gate_mutated=True action_executed=False worker=False browser=False network=False git=False report=$reportPath next=E10_VERIFY_CANONICAL_ACTION_GATE_MUTATION_AND_CREATE_UNLOCK" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
