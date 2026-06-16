$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective='ENGREMIAT_PLAN_TO_WORKER_APP_001'
$stage='E02'
function AssertFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw ('Falta archivo requerido: '+$Path)}}
function ReadJsonFile([string]$Path){AssertFile $Path;return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
AssertFile 'tools/plan-to-worker/Detect-PlanFormat.ps1'
AssertFile 'tools/plan-to-worker/Import-PlanTable.ps1'
AssertFile 'data/plan-to-worker/samples/plan-to-worker-sample.tsv'
& powershell -NoProfile -ExecutionPolicy Bypass -File 'tools/plan-to-worker/Detect-PlanFormat.ps1' 'data/plan-to-worker/samples/plan-to-worker-sample.tsv'
if($LASTEXITCODE -ne 0){throw ('Detect-PlanFormat fallo con exitcode '+$LASTEXITCODE)}
& powershell -NoProfile -ExecutionPolicy Bypass -File 'tools/plan-to-worker/Import-PlanTable.ps1' 'data/plan-to-worker/samples/plan-to-worker-sample.tsv' 'data/plan-to-worker/imported-plan-raw.json'
if($LASTEXITCODE -ne 0){throw ('Import-PlanTable fallo con exitcode '+$LASTEXITCODE)}
$detected=ReadJsonFile 'data/plan-to-worker/detected-plan-format.json'
$raw=ReadJsonFile 'data/plan-to-worker/imported-plan-raw.json'
$problems=@()
if($detected.format -ne 'TSV'){$problems+='detector_format_not_tsv'}
if($detected.importable -ne $true){$problems+='detector_not_importable'}
if($raw.row_count -lt 3){$problems+='raw_rows_less_than_3'}
foreach($col in @('objective_id','stage_id','block_id','step_id','status')){if(-not($raw.columns -contains $col)){$problems+=('missing_'+$col)}}
$score=100-($problems.Count*10);if($score -lt 0){$score=0}
$decision='NO_GO';$next='REPAIR_PLAN_TO_WORKER_E02';if($problems.Count -eq 0){$decision='GO';$next='E03_NORMALIZADOR_Y_VALIDADOR_DE_PLAN'}
$report=[ordered]@{objective_id=$objective;stage=$stage;repair='R3_STRONG_SAMPLE_AND_READER';blocks=@('B02.1','B02.2','B02.3');steps=@('P02.1.1','P02.1.2','P02.2.1','P02.2.2','P02.3.1','P02.3.2');input_structure=$true;detector=$true;importer=$true;raw_plan=$true;validator=$true;smoke=($problems.Count -eq 0);format=$detected.format;rows=$raw.row_count;score=$score;decision=$decision;problems=$problems;external_network=$false;google_api=$false;git_write=$false;report='reports/plan-to-worker/e02-importador-plan/plan-import-smoke-report.json';next=$next;created_at=(Get-Date).ToString('s')}
WriteJsonFile 'reports/plan-to-worker/e02-importador-plan/plan-import-smoke-report.json' $report
if($problems.Count -gt 0){throw ('Validacion E02 fallida: '+($problems -join ','))}
Write-Host ('OK objective='+$objective+' stage=E02 repair=R3_STRONG_SAMPLE_AND_READER blocks=B02.1-B02.3 steps=6 input=True detector=True importer=True raw=True validator=True smoke=True rows='+$raw.row_count+' score=100 report=reports/plan-to-worker/e02-importador-plan/plan-import-smoke-report.json next=E03_NORMALIZADOR_Y_VALIDADOR_DE_PLAN')
}catch{Write-Host ('ERR objective='+$objective+' stage=E02 repair=R3_STRONG_SAMPLE_AND_READER message='+$_.Exception.Message+' next=REPAIR_PLAN_TO_WORKER_E02') -ForegroundColor Red;throw}