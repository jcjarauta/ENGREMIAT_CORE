$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective='ENGREMIAT_PLAN_TO_WORKER_APP_001'
$stage='E01'
function AssertFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw ('Falta archivo requerido: '+$Path)}}
function ReadJsonFile([string]$Path){AssertFile $Path;return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
AssertFile 'docs/PLAN_TO_WORKER_APP_CONTRACT.md'
AssertFile 'data/plan-to-worker/app-boundaries.json'
AssertFile 'data/plan-to-worker/plan-to-worker.schema.json'
AssertFile 'data/plan-to-worker/app-state.schema.json'
$contract=Get-Content -LiteralPath 'docs/PLAN_TO_WORKER_APP_CONTRACT.md' -Raw -Encoding UTF8
$boundaries=ReadJsonFile 'data/plan-to-worker/app-boundaries.json'
$schema=ReadJsonFile 'data/plan-to-worker/plan-to-worker.schema.json'
$state=ReadJsonFile 'data/plan-to-worker/app-state.schema.json'
$problems=@()
if($contract -notmatch 'PLAN_TO_WORKER_APP_CONTRACT'){$problems+='contract_title_missing'}
if($boundaries.external_network -ne $false){$problems+='external_network_not_false'}
if($boundaries.git_write -ne $false){$problems+='git_write_not_false'}
if($boundaries.worker_real_execution -ne $false){$problems+='worker_real_execution_not_false'}
if($boundaries.auto_apply -ne $false){$problems+='auto_apply_not_false'}
if(-not($boundaries.forbidden_actions -contains 'COMMIT')){$problems+='commit_not_forbidden'}
if(-not($boundaries.forbidden_actions -contains 'PUSH')){$problems+='push_not_forbidden'}
if(-not($schema.required -contains 'objective_id')){$problems+='schema_objective_required_missing'}
if(-not($schema.required -contains 'stages')){$problems+='schema_stages_required_missing'}
if(-not($schema.required -contains 'worker_package')){$problems+='schema_worker_package_required_missing'}
if(-not($state.required -contains 'readiness')){$problems+='state_readiness_required_missing'}
if(-not($state.required -contains 'inbox')){$problems+='state_inbox_required_missing'}
if(-not($state.required -contains 'outbox')){$problems+='state_outbox_required_missing'}
$score=100-($problems.Count*10);if($score -lt 0){$score=0}
$decision='NO_GO';$next='REPAIR_PLAN_TO_WORKER_E01';if($problems.Count -eq 0){$decision='GO';$next='E02_IMPORTADOR_PLAN_SHEETS'}
$report=[ordered]@{objective_id=$objective;stage=$stage;repair='R3_NO_ALIAS';blocks=@('B01.1','B01.2','B01.3');steps=@('P01.1.1','P01.1.2','P01.2.1','P01.2.2','P01.3.1','P01.3.2');contract=$true;boundaries=$true;schemas=$true;validator=$true;smoke=($problems.Count -eq 0);score=$score;decision=$decision;problems=$problems;external_network=$false;git_write=$false;worker_real_execution=$false;report='reports/plan-to-worker/e01-modelo-app/plan-to-worker-model-smoke-report.json';next=$next;created_at=(Get-Date).ToString('s')}
WriteJsonFile 'reports/plan-to-worker/e01-modelo-app/plan-to-worker-model-smoke-report.json' $report
if($problems.Count -gt 0){throw ('Validacion E01 fallida: '+($problems -join ','))}
Write-Host ('OK objective='+$objective+' stage=E01 repair=R3_NO_ALIAS blocks=B01.1-B01.3 steps=6 contract=True schemas=True validator=True smoke=True score=100 report=reports/plan-to-worker/e01-modelo-app/plan-to-worker-model-smoke-report.json next=E02_IMPORTADOR_PLAN_SHEETS')
}catch{Write-Host ('ERR objective='+$objective+' stage=E01 repair=R3_NO_ALIAS message='+$_.Exception.Message+' next=REPAIR_PLAN_TO_WORKER_E01') -ForegroundColor Red;throw}
