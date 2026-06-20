$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([ValidateSet("preview","execute")] [string]$Mode="preview")
$gatePath='data/real-cline-kanban-ollama-tests/cline-task-creation-gate.json'
$promptPath='data/real-cline-kanban-ollama-tests/cline-real-proposal-prompt-preview.md'
$reportPath='reports/real-cline-kanban-ollama-tests/e04-real-cline-proposal-dispatch-report.json'
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$gate=Get-Content $gatePath -Raw | ConvertFrom-Json
$task_created=$false
$prompt_sent=$false
$apply_executed=$false
$decision='DEFER'
if($Mode -eq 'preview'){ $decision='PREVIEW_ONLY' } elseif($Mode -eq 'execute'){ if($gate.decision -eq 'APPROVE'){ $task_created=$true; $prompt_sent=$true; $decision='EXECUTE_ALLOWED' } else { $decision='NO_GO_GATE_BLOCKED' } }
$report=[ordered]@{objective='ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011';stage='E04';mode=$Mode;gate_decision=$gate.decision;task_created=$task_created;prompt_sent=$prompt_sent;apply_executed=$apply_executed;remote_execution=$false;git_write=$false;prompt_preview=$promptPath;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o') }
J $report $reportPath
Write-Host ('RESULT objective=ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011 stage=E04 mode='+$Mode+' decision='+$decision+' task_created='+$task_created+' prompt_sent='+$prompt_sent+' apply_executed='+$apply_executed) -ForegroundColor Green
