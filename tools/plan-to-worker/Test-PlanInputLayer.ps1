$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function ReadJsonFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw ("Falta JSON: "+$Path)};return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
$problems=@();foreach($p in @("data/plan-to-worker/input/manual-intake.schema.json","data/plan-to-worker/input/form-submission.schema.json","tools/plan-to-worker/Import-PlanInput.ps1","data/plan-to-worker/input/samples/plan-input.sample.tsv","data/plan-to-worker/input/samples/manual-intake.sample.json")){if(!(Test-Path -LiteralPath $p -PathType Leaf)){$problems+=("missing:"+$p)}}
& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Import-PlanInput.ps1" "data/plan-to-worker/input/samples/plan-input.sample.tsv" "data/plan-to-worker/input/imported-input.json"
if($LASTEXITCODE -ne 0){$problems+="import_tsv_exitcode"}
$imp=ReadJsonFile "data/plan-to-worker/input/imported-input.json";if($imp.records_count -lt 1){$problems+="imported_records_empty"};if($imp.source_format -ne "TSV"){$problems+="source_format_not_tsv"}
$score=100-($problems.Count*20);if($score -lt 0){$score=0};$decision="NO_GO";$next="REPAIR_PLAN_TO_WORKER_CONSOLIDATION_E02";if($problems.Count -eq 0){$decision="GO";$next="E03_SALIDA_CANONICA_NORMALIZADA"}
$report=[ordered]@{objective_id="ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002";stage="E02";blocks=@("B02.1","B02.2","B02.3");steps=@("P02.1.1","P02.1.2","P02.2.1","P02.2.2","P02.3.1","P02.3.2");manual_intake_schema=$true;form_submission_schema=$true;importer=$true;imported_input=$true;validator=$true;smoke=($problems.Count -eq 0);score=$score;decision=$decision;problems=$problems;external_network=$false;git_write=$false;worker_real_execution=$false;report="reports/plan-to-worker/consolidation/e02-input-layer-smoke-report.json";next=$next;created_at=(Get-Date).ToString("s")}
WriteJsonFile "reports/plan-to-worker/consolidation/e02-input-layer-smoke-report.json" $report
if($problems.Count -gt 0){throw ("Smoke E02 fallido: "+($problems -join ","))}
Write-Host ("OK objective=ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002 stage=E02 blocks=B02.1-B02.3 steps=6 input_layer=True importer=True smoke=True score=100 report=reports/plan-to-worker/consolidation/e02-input-layer-smoke-report.json next=E03_SALIDA_CANONICA_NORMALIZADA")
}catch{Write-Host ("ERR objective=ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002 stage=E02 message="+$_.Exception.Message+" next=REPAIR_PLAN_TO_WORKER_CONSOLIDATION_E02") -ForegroundColor Red;throw}
