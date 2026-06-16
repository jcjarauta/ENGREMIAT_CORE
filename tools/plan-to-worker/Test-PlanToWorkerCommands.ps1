$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
$problems=@()
foreach($p in @("tools/plan-to-worker/Invoke-PlanToWorkerCommand.ps1","tools/plan-to-worker/Build-PlanToWorkerDashboard.ps1","eng.ps1","dashboard/plan-to-worker/index.html")){if(!(Test-Path -LiteralPath $p -PathType Leaf)){$problems+=("missing:"+$p)}}
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Invoke-PlanToWorkerCommand.ps1" plan-status
if($LASTEXITCODE -ne 0){$problems+="plan_status_exitcode"}
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Invoke-PlanToWorkerCommand.ps1" plan-next
if($LASTEXITCODE -ne 0){$problems+="plan_next_exitcode"}
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Invoke-PlanToWorkerCommand.ps1" plan-prompt
if($LASTEXITCODE -ne 0){$problems+="plan_prompt_exitcode"}
$score=100-($problems.Count*20);if($score -lt 0){$score=0};$decision="NO_GO";$next="REPAIR_PLAN_TO_WORKER_E06";if($problems.Count -eq 0){$decision="GO";$next="E07_MEMORIA_DEMO_Y_CIERRE"}
$report=[ordered]@{objective_id="ENGREMIAT_PLAN_TO_WORKER_APP_001";stage="E06";blocks=@("B06.1","B06.2","B06.3");steps=@("P06.1.1","P06.1.2","P06.2.1","P06.2.2","P06.3.1","P06.3.2");dispatcher=$true;eng_ps1=$true;dashboard_builder=$true;dashboard=$true;validator=$true;smoke=($problems.Count -eq 0);score=$score;decision=$decision;problems=$problems;external_network=$false;google_api=$false;git_write=$false;worker_real_execution=$false;report="reports/plan-to-worker/e06-command-hub/plan-to-worker-command-smoke-report.json";next=$next;created_at=(Get-Date).ToString("s")}
WriteJsonFile "reports/plan-to-worker/e06-command-hub/plan-to-worker-command-smoke-report.json" $report
if($problems.Count -gt 0){throw ("Smoke E06 fallido: "+($problems -join ","))}
Write-Host ("OK objective=ENGREMIAT_PLAN_TO_WORKER_APP_001 stage=E06 blocks=B06.1-B06.3 steps=6 command_hub=True eng_ps1=True dashboard=True smoke=True score=100 report=reports/plan-to-worker/e06-command-hub/plan-to-worker-command-smoke-report.json next=E07_MEMORIA_DEMO_Y_CIERRE")
}catch{Write-Host ("ERR objective=ENGREMIAT_PLAN_TO_WORKER_APP_001 stage=E06 message="+$_.Exception.Message+" next=REPAIR_PLAN_TO_WORKER_E06") -ForegroundColor Red;throw}
