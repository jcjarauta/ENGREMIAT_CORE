$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/dual-pc-development-workflow'
$reports='reports/dual-pc-development-workflow'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/dual-pc-role-model.json","$base/machine-authority-policy.json","$base/workspace-separation-policy.json","$base/forbidden-operations-policy.json")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$roles=Get-Content "$base/dual-pc-role-model.json" -Raw|ConvertFrom-Json
$authority=Get-Content "$base/machine-authority-policy.json" -Raw|ConvertFrom-Json
$workspace=Get-Content "$base/workspace-separation-policy.json" -Raw|ConvertFrom-Json
$forbidden=Get-Content "$base/forbidden-operations-policy.json" -Raw|ConvertFrom-Json
$errors=@()
$roleNames=@($roles.roles|ForEach-Object{$_.role})
foreach($r in @("CURRENT_PC","MAIN_PC","SHARED_WORKSPACE","GIT_SOURCE_OF_TRUTH")){if($r -notin $roleNames){$errors+=("missing_role:"+$r)}}
if($authority.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($authority.safety.writer_conflict -ne $false){$errors+="writer_conflict_not_false"}
if($authority.safety.main_pc_touched -ne $false){$errors+="main_pc_touched_not_false"}
if($workspace.code_source_of_truth -ne "GIT"){$errors+="git_not_source_of_truth"}
if($workspace.safety.shared_repo_edit -ne $false){$errors+="shared_repo_edit_not_false"}
if($workspace.safety.auto_execution_from_shared -ne $false){$errors+="auto_execution_from_shared_not_false"}
foreach($op in @("remote_execution","shared_repo_edit","auto_apply","git_remote_auto","two_pc_simultaneous_write")){if($op -notin @($forbidden.forbidden_operations)){$errors+=("missing_forbidden_operation:"+$op)}}
if($forbidden.safety.remote_execution -ne $false){$errors+="forbidden_remote_execution_not_false"}
if($forbidden.safety.git_write -ne $false){$errors+="forbidden_git_write_not_false"}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B";stage="E01";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;roles=$roleNames;single_active_writer=$authority.single_active_writer;writer_conflict=$false;main_pc_touched=$false;shared_repo_edit=$false;git_source_of_truth=($workspace.code_source_of_truth -eq "GIT");remote_execution=$false;auto_apply=$false;git_remote_auto=$false;git_write=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E01_DUAL_PC_MODEL_AUTHORITY_READY"}else{"NO_GO_E01_REPAIR_REQUIRED"}));next=($(if($ok){"E02_DUAL_PC_HANDOFF"}else{"REPAIR_E01_DUAL_PC_MODEL"}))}
J $report "$reports/e01-dual-pc-model-validation-report.json"
if(-not $ok){throw "Dual-PC model validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E01 readiness="+$report.readiness+" decision="+$report.decision+" single_active_writer="+$report.single_active_writer+" writer_conflict="+$report.writer_conflict+" main_pc_touched="+$report.main_pc_touched+" remote_execution="+$report.remote_execution+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
