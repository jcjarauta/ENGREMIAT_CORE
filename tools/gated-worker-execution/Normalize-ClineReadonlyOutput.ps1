$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$base="data/gated-worker-execution"
$outPath=Join-Path $base "cline-readonly-output.json"
$runPath="reports/gated-worker-execution/first-cline-readonly-run.json"
if(!(Test-Path $outPath)){throw "cline_readonly_output_missing"}
if(!(Test-Path $runPath)){throw "first_cline_readonly_run_missing"}
$o=Get-Content $outPath -Raw|ConvertFrom-Json
$r=Get-Content $runPath -Raw|ConvertFrom-Json
$proposal=[ordered]@{proposal_id="WORKER-PROPOSAL-READONLY-001";objective_id="ENGREMIAT_GATED_WORKER_EXECUTION_006";stage="E05";source_output=$outPath;source_run=$runPath;request_id=$o.request_id;worker_id=$o.worker_id;execution_kind=$r.execution_kind;summary="Cline CLI fue validado en modo readonly/version-only. No se envio prompt, no se creo tarea y no hubo apply.";observations=@("CLI disponible y ejecutable","Gate humano readonly existia antes de la ejecucion","La ejecucion fue informativa, no de tarea Cline completa","No hay propuesta tecnica de codigo porque no se envio prompt real");risks=@("Aun no se ha probado una tarea Cline real","cline --help puede bloquear o tardar","Cualquier tarea real debe seguir bloqueada por gate y sin auto-apply");suggested_files=@();recommended_next_step="Cerrar objetivo 006 o preparar siguiente objetivo con una tarea Cline real de solo propuesta, no apply.";apply_recommended=$false;requires_new_human_gate=$true;write_files=$false;auto_apply=$false;git_write=$false;remote_inference=$false;created_at=(Get-Date).ToString("s")}
WriteJson (Join-Path $base "worker-proposal.json") $proposal
Write-Host "OK worker_proposal_created=True apply_recommended=False write_files=False auto_apply=False git_write=False" -ForegroundColor Green
