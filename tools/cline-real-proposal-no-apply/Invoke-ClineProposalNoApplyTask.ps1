$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$Mode='preview'
if($args.Count -ge 2 -and $args[0] -eq '-Mode'){$Mode=[string]$args[1]}elseif($args.Count -ge 1){$Mode=[string]$args[0]}
if($Mode -notin @('preview','execute')){throw "Modo no valido: $Mode"}
$objective='ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008'
$base='data/cline-real-proposal-no-apply'
$reports='reports/cline-real-proposal-no-apply'
$receipts="$base/receipts"
New-Item -ItemType Directory -Force -Path $reports,$receipts | Out-Null
$gate=Get-Content "$base/cline-task-creation-gate.json" -Raw|ConvertFrom-Json
$prompt=Get-Content "$base/cline-proposal-prompt-preview.md" -Raw
$candidate=Get-Content "$base/cline-proposal-task-candidate.json" -Raw|ConvertFrom-Json
$requiredPhrase='AUTORIZO_CLINE_REAL_PROPOSAL_TASK_NO_APPLY_FOR_SPECIFIC_REQUEST'
$approved=($gate.decision -eq 'APPROVE' -and $gate.authorization_required -eq $true -and (($gate.PSObject.Properties.Name -contains 'human_authorization_phrase') -and $gate.human_authorization_phrase -eq $requiredPhrase))
$executeAllowed=($Mode -eq 'execute' -and $approved)
$taskCreated=$false;$promptSent=$false;$workerRealExecution=$false;$dispatchDecision='NO_GO_PREVIEW_OR_NOT_AUTHORIZED';$dispatchReason='No explicit human authorization for real Cline task creation.'
if($executeAllowed){$dispatchDecision='SIMULATED_EXECUTE_GATE_PASSED_BUT_REAL_CLINE_INVOCATION_NOT_IMPLEMENTED_IN_SAFE_SCRIPT';$dispatchReason='Gate approved, but this dispatcher intentionally records approval without invoking Cline UI/CLI automatically.'}
$receipt=[ordered]@{objective=$objective;stage='E04';repair='PARAM_POSITION_FIXED';receipt_id='FIRST-CLINE-PROPOSAL-TASK-RECEIPT-008-E04-001';mode=$Mode;approved=$approved;execute_allowed=$executeAllowed;task_created=$taskCreated;prompt_sent=$promptSent;worker_real_execution=$workerRealExecution;candidate_id=$candidate.candidate_id;prompt_size_chars=$prompt.Length;limits=[ordered]@{proposal_only=$true;auto_apply=$false;apply_executed=$false;source_write_by_worker=$false;git_write=$false;git_commit=$false;git_push=$false;remote_inference=$false;ui_automation=$false};decision=$dispatchDecision;reason=$dispatchReason;evidence=@("$base/cline-task-creation-gate.json","$base/cline-proposal-task-candidate.json","$base/cline-proposal-prompt-preview.md","reports/cline-real-proposal-no-apply/e04-gate-approval-check-report.json")}
J $receipt "$receipts/first-cline-proposal-task-receipt.json"
$dispatch=[ordered]@{objective=$objective;stage='E04';repair='PARAM_POSITION_FIXED';mode=$Mode;approved=$approved;execute_allowed=$executeAllowed;task_created=$taskCreated;prompt_sent=$promptSent;worker_real_execution=$workerRealExecution;auto_apply=$false;git_write=$false;decision=$dispatchDecision;reason=$dispatchReason;receipt="$receipts/first-cline-proposal-task-receipt.json";next=($(if($taskCreated){'E05_CAPTURE_CLINE_PROPOSAL_OUTPUT'}else{'E04_NO_GO_OR_WAIT_FOR_EXPLICIT_AUTHORIZATION'}))}
J $dispatch "$reports/e04-dispatch-result-report.json"
Write-Host ("OK objective="+$objective+" stage=E04 mode="+$Mode+" approved="+$approved+" task_created="+$taskCreated+" prompt_sent="+$promptSent+" decision="+$dispatchDecision+" receipt="+$receipts+"/first-cline-proposal-task-receipt.json") -ForegroundColor Green
