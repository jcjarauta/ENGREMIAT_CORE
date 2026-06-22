$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_MODULE_CARD_ACTION_FLOW_001'
$stage='E110_APPLY_REAL_GATE_APPROVAL_MUTATION_EXPLICIT_AUTH_ONLY'
$requiredAuthorization='AUTORIZO_E110_APPLY_REAL_GATE_APPROVAL_MUTATION'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  if($env:ENGREMIAT_GATE_MUTATION_AUTH -ne $requiredAuthorization){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required_env=ENGREMIAT_GATE_MUTATION_AUTH required_value=$requiredAuthorization real_execution=False gate_mutated=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=PENDING_EXPLICIT_HUMAN_AUTHORIZATION" Yellow
    exit 0
  }
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $gateStateDir=Join-Path $root 'documents\module-cards\gate-state'
  $contractsDir=Join-Path $root 'documents\module-cards\gate-mutation-contracts'
  $reportsDir=Join-Path $root 'reports\launcher'
  New-Item -ItemType Directory -Force -Path $gateStateDir,$contractsDir,$reportsDir | Out-Null
  $gateStatePath=Join-Path $gateStateDir 'human-gate-cab-cap-card-state.json'
  if(-not(Test-Path -LiteralPath $gateStatePath)){throw "CANONICAL_GATE_STATE_NOT_FOUND path=$gateStatePath"}
  $state=ReadJson $gateStatePath
  if("$($state.state_file_role)" -ne 'CANONICAL_MUTABLE_GATE_STATE'){throw "NOT_CANONICAL_MUTABLE_GATE_STATE role=$($state.state_file_role)"}
  if("$($state.status)" -ne 'PENDING'){throw "GATE_NOT_PENDING status=$($state.status)"}
  $targetStatus="$($state.next_allowed_transition.to)"
  if([string]::IsNullOrWhiteSpace($targetStatus)){ $targetStatus='APPROVED' }
  $backupPath=Join-Path $gateStateDir ("human-gate-cab-cap-card-state.before-e110-$ts.json")
  Copy-Item -LiteralPath $gateStatePath -Destination $backupPath -Force
  $history=@()
  if($state.history){$history=@($state.history)}
  $history += [ordered]@{event='REAL_GATE_APPROVAL_APPLIED';at=(Get-Date).ToString('s');from_status="$($state.status)";to_status=$targetStatus;decision_id="$($state.pending_decision_id)";authorization=$requiredAuthorization;backup=$backupPath}
  $state.status=$targetStatus
  $state.approved_decision_id="$($state.pending_decision_id)"
  $state.last_transition=[ordered]@{event='APPROVE_BLUEPRINT';at=(Get-Date).ToString('s');from='PENDING';to=$targetStatus;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED'}
  $state.history=$history
  $state.safety.approval_applied=$true
  $state.safety.real_execution=$true
  $state.safety.gate_mutated=$true
  $state | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $gateStatePath -Encoding UTF8
  $receipt=[ordered]@{package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');status='PASS';authorization_required=$true;authorization_status='EXPLICIT_HUMAN_AUTHORIZATION_GRANTED';canonical_gate_state=$gateStatePath;backup=$backupPath;gate_id="$($state.gate_id)";decision_id="$($state.approved_decision_id)";from_status='PENDING';to_status=$targetStatus;real_execution=$true;gate_mutated=$true;next='E111_VERIFY_GATE_APPROVAL_MUTATION'}
  $receiptPath=Join-Path $contractsDir ("gate-approval-real-mutation-receipt-$ts.json")
  $reportPath=Join-Path $reportsDir ("e110-apply-real-gate-approval-mutation-explicit-auth-only-$ts.json")
  $receipt | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $receiptPath -Encoding UTF8
  $receipt | ConvertTo-Json -Depth 80 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK real_gate_approval_mutation_applied canonical_gate_state=$gateStatePath backup=$backupPath" Green
  W "OK package_id=$package stage=$stage status=PASS authorization_status=EXPLICIT_HUMAN_AUTHORIZATION_GRANTED gate_mutated=True report=$reportPath next=E111_VERIFY_GATE_APPROVAL_MUTATION" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
