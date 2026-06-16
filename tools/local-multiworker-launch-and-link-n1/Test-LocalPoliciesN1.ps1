$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/local-multiworker-launch-and-link-n1'
$reports='reports/local-multiworker-launch-and-link-n1'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$required=@("$base/human-surfaces-policy.json","$base/human-surfaces-index.json","$base/cline-safe-use-policy.json","$base/ollama-safe-use-policy.json","$base/nodes-registry.json")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$surface=Get-Content "$base/human-surfaces-policy.json" -Raw|ConvertFrom-Json
$index=Get-Content "$base/human-surfaces-index.json" -Raw|ConvertFrom-Json
$cline=Get-Content "$base/cline-safe-use-policy.json" -Raw|ConvertFrom-Json
$ollama=Get-Content "$base/ollama-safe-use-policy.json" -Raw|ConvertFrom-Json
$registry=Get-Content "$base/nodes-registry.json" -Raw|ConvertFrom-Json
$errors=@()
if($surface.browser_open -ne $false){$errors+="surface_browser_open_not_false"}
if($surface.preview_only -ne $true){$errors+="surface_preview_only_not_true"}
if($surface.safety.remote_execution -ne $false){$errors+="surface_remote_execution_not_false"}
if($cline.task_creation -ne $false){$errors+="cline_task_creation_not_false"}
if($cline.prompt_sent -ne $false){$errors+="cline_prompt_sent_not_false"}
if($cline.safety.auto_apply -ne $false){$errors+="cline_auto_apply_not_false"}
if($cline.safety.git_write -ne $false){$errors+="cline_git_write_not_false"}
if($ollama.ollama_required -ne $false){$errors+="ollama_required_not_false"}
if($ollama.inference_executed -ne $false){$errors+="ollama_inference_executed_not_false"}
if($ollama.remote_inference -ne $false){$errors+="ollama_remote_inference_not_false"}
if($registry.safety.remote_execution -ne $false){$errors+="registry_remote_execution_not_false"}
if($registry.safety.git_write -ne $false){$errors+="registry_git_write_not_false"}
$forbiddenOk=($surface.forbidden_actions -contains 'remote_execution' -and $cline.forbidden_actions -contains 'auto_apply' -and $cline.forbidden_actions -contains 'git_write' -and $ollama.forbidden_actions -contains 'remote_inference')
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0 -and $forbiddenOk)
$report=[ordered]@{objective='ENGREMIAT_LOCAL_MULTIWORKER_LAUNCH_AND_LINK_009A_N1';stage='E02';required_artifacts=$required;missing_artifacts=$missing;errors=$errors;forbidden_actions_present=$forbiddenOk;surfaces_total=@($index.surfaces).Count;surfaces_existing=$index.summary.existing;browser_opened=$false;preview_only=$true;cline_task_creation=$false;cline_prompt_sent=$false;cline_worker_real_execution=$false;cline_auto_apply=$false;ollama_required=$false;ollama_inference_executed=$false;remote_inference=$false;remote_execution=$false;ssh=$false;network_write=$false;git_write=$false;apply_executed=$false;source_write_by_worker=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){'GO_E02_LOCAL_POLICIES_N1_READY'}else{'NO_GO_E02_REPAIR_REQUIRED'}));next=($(if($ok){'E03_DASHBOARD_AND_LAUNCHER_PREVIEW'}else{'REPAIR_E02_LOCAL_POLICIES'}))}
J $report "$reports/e02-local-policies-validation-report.json"
if(-not $ok){throw "Local policies validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E02 readiness="+$report.readiness+" decision="+$report.decision+" surfaces_total="+$report.surfaces_total+" browser_opened="+$report.browser_opened+" cline_task_creation="+$report.cline_task_creation+" ollama_required="+$report.ollama_required+" remote_execution="+$report.remote_execution+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
