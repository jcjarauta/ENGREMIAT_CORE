$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective="ENGREMIAT_PLAN_TO_WORKER_APP_001"
$stage="E04"
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function ReadJsonFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw ("Falta JSON: "+$Path)};return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Select-WorkerNextStep.ps1" "data/plan-to-worker/plan-normalized.json" "data/plan-to-worker/selected-step.json"
if($LASTEXITCODE -ne 0){throw ("Select-WorkerNextStep fallo con exitcode "+$LASTEXITCODE)}
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Select-RepairOrNext.ps1" "data/plan-to-worker/selected-step.json" "data/plan-to-worker/plan-validation-report.json" "data/plan-to-worker/worker-decision.json"
if($LASTEXITCODE -ne 0){throw ("Select-RepairOrNext fallo con exitcode "+$LASTEXITCODE)}
$selected=ReadJsonFile "data/plan-to-worker/selected-step.json";$workerDecision=ReadJsonFile "data/plan-to-worker/worker-decision.json";$problems=@()
if($selected.selected -ne $true){$problems+="selected_step_false"}
if([string]::IsNullOrWhiteSpace([string]$selected.step_id)){$problems+="selected_step_id_empty"}
if($workerDecision.decision -ne "NEXT" -and $workerDecision.decision -ne "REPAIR"){$problems+="decision_invalid"}
if($workerDecision.decision -eq "NEXT" -and [string]::IsNullOrWhiteSpace([string]$workerDecision.selected_step_id)){$problems+="next_without_step"}
$score=100-($problems.Count*25);if($score -lt 0){$score=0};$statusDecision="NO_GO";$next="REPAIR_PLAN_TO_WORKER_E04";if($problems.Count -eq 0){$statusDecision="GO";$next="E05_GENERADOR_DE_PAQUETES_WORKER"}
$report=[ordered]@{objective_id=$objective;stage=$stage;repair="R1_DUPLICATE_KEY";blocks=@("B04.1","B04.2","B04.3");steps=@("P04.1.1","P04.1.2","P04.2.1","P04.2.2","P04.3.1","P04.3.2");selector_next=$true;selected_step_created=$true;selector_repair=$true;worker_decision_created=$true;validator=$true;smoke=($problems.Count -eq 0);selected_step_id=$selected.step_id;worker_decision_value=$workerDecision.decision;prompt_type=$workerDecision.prompt_type;score=$score;decision=$statusDecision;problems=$problems;external_network=$false;google_api=$false;git_write=$false;worker_real_execution=$false;report="reports/plan-to-worker/e04-selector-operativo/worker-step-selector-smoke-report.json";next=$next;created_at=(Get-Date).ToString("s")}
WriteJsonFile "reports/plan-to-worker/e04-selector-operativo/worker-step-selector-smoke-report.json" $report
if($problems.Count -gt 0){throw ("Smoke E04 fallido: "+($problems -join ","))}
Write-Host ("OK objective="+$objective+" stage=E04 repair=R1_DUPLICATE_KEY blocks=B04.1-B04.3 steps=6 selector=True decision=True smoke=True selected="+$selected.step_id+" score=100 report=reports/plan-to-worker/e04-selector-operativo/worker-step-selector-smoke-report.json next=E05_GENERADOR_DE_PAQUETES_WORKER")
}catch{Write-Host ("ERR objective="+$objective+" stage=E04 repair=R1_DUPLICATE_KEY message="+$_.Exception.Message+" next=REPAIR_PLAN_TO_WORKER_E04") -ForegroundColor Red;throw}
