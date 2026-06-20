$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/real-cline-kanban-ollama-tests'
$reports='reports/real-cline-kanban-ollama-tests'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$schema=Get-Content "$base/ollama-detection-schema.json" -Raw | ConvertFrom-Json
$matrix=Get-Content "$base/ollama-readiness-matrix.json" -Raw | ConvertFrom-Json
$policy=Get-Content "$base/ollama-safe-policy.json" -Raw | ConvertFrom-Json
$errors=@()
if($schema.required_fields.Count -lt 6){$errors+="schema_fields_missing"}
if($policy.inference_executed -ne $false){$errors+="policy_inference_not_false"}
if($policy.remote_execution -ne $false){$errors+="policy_remote_execution_not_false"}
if($matrix.optional -ne $true){$errors+="matrix_optional_not_true"}
if(-not ($matrix.available -is [bool])){$errors+="matrix_available_not_bool"}
$ok = ($errors.Count -eq 0)
$readiness = 70
$decision = "NO_GO_OLLAMA_REPAIR_REQUIRED"
$next = "REPAIR_OR_INSTALL_OLLAMA"
if($ok){$readiness=100;$decision="GO_OLLAMA_READY";$next="E04_CLINE_PROPOSAL_ONLY_REAL"}
$report=[ordered]@{objective="ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011";stage="E03";errors=$errors;available=$matrix.available;optional=$matrix.optional;inference_executed=$policy.inference_executed;remote_execution=$policy.remote_execution;git_write=$policy.git_write;auto_apply=$policy.auto_apply;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next}
J $report "$reports/e03-real-ollama-report.json"
Write-Host ("RESULT objective=ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011 stage=E03 readiness="+$readiness+" decision="+$decision+" available="+$matrix.available+" optional="+$matrix.optional+" next="+$next) -ForegroundColor Green
