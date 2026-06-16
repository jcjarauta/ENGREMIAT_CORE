$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$objective='ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008'
$base='data/cline-real-proposal-no-apply'
$reportPath='reports/cline-real-proposal-no-apply/e03-task-creation-gate-report.json'
$gatePath="$base/cline-task-creation-gate.json"
$requestPath="$base/cline-task-creation-request-preview.json"
$guidePath='docs/CLINE_TASK_CREATION_GATE_GUIDE.md'
$candidatePath="$base/cline-proposal-task-candidate.json"
$promptPath="$base/cline-proposal-prompt-preview.md"
foreach($p in @($gatePath,$requestPath,$guidePath,$candidatePath,$promptPath)){if(-not(Test-Path $p)){throw "Falta artefacto requerido: $p"}}
$gate=Get-Content $gatePath -Raw|ConvertFrom-Json
$request=Get-Content $requestPath -Raw|ConvertFrom-Json
$prompt=Get-Content $promptPath -Raw
$falseFlags=@("cline_task_created","launch_cline_task","prompt_sent","worker_real_execution","auto_apply","apply_executed","source_write_by_worker","git_write","git_commit","git_push","remote_inference","ui_automation")
$bad=@()
foreach($f in $falseFlags){if($gate.safety.$f -ne $false){$bad+=("gate:"+$f)};if($request.safety.$f -ne $false){$bad+=("request:"+$f)}}
if($gate.safety.proposal_only -ne $true){$bad+="gate:proposal_only"}
if($request.safety.proposal_only -ne $true){$bad+="request:proposal_only"}
if($gate.authorization_required -ne $true){$bad+="gate:authorization_required"}
if($gate.decision -ne "DEFER"){$bad+="gate:decision"}
if($request.execution_now -ne $false){$bad+="request:execution_now"}
if($request.decision -ne "DEFER"){$bad+="request:decision"}
$promptOk=($prompt -match 'No apliques cambios' -and $prompt -match 'No edites archivos' -and $prompt -match 'No ejecutes comandos')
$ok=($bad.Count -eq 0 -and $promptOk -and (Test-Path $guidePath))
$report=[ordered]@{objective=$objective;stage="E03";blocks="B03.1-B03.3";steps=6;gate_file=$gatePath;guide_file=$guidePath;request_preview_file=$requestPath;candidate_file=$candidatePath;prompt_preview_file=$promptPath;gate_decision=$gate.decision;authorization_required=$gate.authorization_required;required_human_phrase=$gate.required_human_phrase;request_execution_now=$request.execution_now;request_decision=$request.decision;prompt_preview_contains_no_apply=($prompt -match 'No apliques cambios');prompt_preview_contains_no_edit=($prompt -match 'No edites archivos');prompt_preview_contains_no_commands=($prompt -match 'No ejecutes comandos');bad_safety_flags=$bad;proposal_only=$true;human_review_required=$true;cline_task_created=$false;launch_cline_task=$false;prompt_sent=$false;worker_real_execution=$false;auto_apply=$false;apply_executed=$false;source_write_by_worker=$false;git_write=$false;git_commit=$false;git_push=$false;remote_inference=$false;ui_automation=$false;no_go_real_task_creation=$true;no_go_reason="E03 prepara gate y request preview; no crea tarea Cline real.";readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E03_CLINE_TASK_CREATION_GATE_DEFER_VALIDATED"}else{"NO_GO_E03_REPAIR_REQUIRED"}));next=($(if($ok){"E04_CONTROLLED_CLINE_TASK_CREATION_PREFLIGHT_OR_NO_GO"}else{"REPAIR_E03_TASK_CREATION_GATE"}))}
J $report $reportPath
if(-not $ok){throw "E03 validation failed"}
Write-Host ("OK objective="+$objective+" stage=E03 readiness="+$report.readiness+" decision="+$report.decision+" gate_decision="+$report.gate_decision+" launch_cline_task="+$report.launch_cline_task+" cline_task_created="+$report.cline_task_created+" prompt_sent="+$report.prompt_sent+" report="+$reportPath+" next="+$report.next) -ForegroundColor Green
