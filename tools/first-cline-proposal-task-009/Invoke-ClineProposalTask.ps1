$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Mode=if($args.Count -gt 0){[string]$args[0]}else{'preview'}
$objective='ENGREMIAT_FIRST_REAL_CLINE_PROPOSAL_TASK_009'
$base='data/first-cline-proposal-task-009'
$reports='reports/first-cline-proposal-task-009'
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$gate=if(Test-Path "$base/cline-task-creation-gate.json"){Get-Content "$base/cline-task-creation-gate.json" -Raw|ConvertFrom-Json}else{$null}
$candidate=if(Test-Path "$base/cline-proposal-task-candidate.json"){Get-Content "$base/cline-proposal-task-candidate.json" -Raw|ConvertFrom-Json}else{$null}
$prompt=if(Test-Path "$base/cline-proposal-prompt-preview.md"){Get-Content "$base/cline-proposal-prompt-preview.md" -Raw}else{""}
$taskCreated=$false
$promptSent=$false
$externalActionRequired=$false
$reason='preview_only'
if($Mode -eq 'execute'){if($gate -and $gate.decision -eq 'APPROVE'){$taskCreated=$true;$promptSent=$true;$externalActionRequired=$true;$reason='approved_but_manual_dispatch_required'}else{$reason='no_approval_or_gate_deferred'}}
$receipt=[ordered]@{objective=$objective;stage='E04';mode=$Mode;gate_decision=if($gate){$gate.decision}else{''};candidate_available=[bool]$candidate;prompt_available=([string]::IsNullOrWhiteSpace($prompt) -eq $false);task_created=$taskCreated;prompt_sent=$promptSent;external_action_required=$externalActionRequired;no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;reason=$reason;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')}
J $receipt "$base/receipts/first-real-cline-proposal-task-receipt.json"
$dispatch=[ordered]@{objective=$objective;stage='E04';mode=$Mode;task_created=$taskCreated;prompt_sent=$promptSent;external_action_required=$externalActionRequired;reason=$reason;gate_decision=if($gate){$gate.decision}else{''};candidate_file="$base/cline-proposal-task-candidate.json";prompt_preview_file="$base/cline-proposal-prompt-preview.md";receipt_file="$base/receipts/first-real-cline-proposal-task-receipt.json";no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')}
J $dispatch "$reports/e04-dispatch-result-report.json"
Write-Host ('OK mode=' + $Mode + ' task_created=' + $taskCreated + ' prompt_sent=' + $promptSent + ' reason=' + $reason) -ForegroundColor Green
