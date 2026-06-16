$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/dual-pc-development-workflow'
$reports='reports/dual-pc-development-workflow'
$docs='docs'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/git-sync-policy.json","$docs/DUAL_PC_GIT_SYNC_CHECKLIST.md","$base/shared-workspace-bridge-policy.json","$base/shared-exchange-map.json")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$git=Get-Content "$base/git-sync-policy.json" -Raw|ConvertFrom-Json
$shared=Get-Content "$base/shared-workspace-bridge-policy.json" -Raw|ConvertFrom-Json
$map=Get-Content "$base/shared-exchange-map.json" -Raw|ConvertFrom-Json
$checklist=Get-Content "$docs/DUAL_PC_GIT_SYNC_CHECKLIST.md" -Raw
$errors=@()
if($git.safety.git_fetch -ne $false){$errors+="git_fetch_not_false"}
if($git.safety.git_push -ne $false){$errors+="git_push_not_false"}
if($git.safety.git_merge -ne $false){$errors+="git_merge_not_false"}
if($git.safety.git_remote_auto -ne $false){$errors+="git_remote_auto_not_false"}
if($git.safety.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($shared.safety.shared_repo_edit -ne $false){$errors+="shared_repo_edit_not_false"}
if($shared.safety.auto_execution_from_shared -ne $false){$errors+="auto_execution_from_shared_not_false"}
if($shared.safety.secret_storage_allowed -ne $false){$errors+="secret_storage_allowed_not_false"}
if($shared.safety.git_write_from_shared -ne $false){$errors+="git_write_from_shared_not_false"}
if($shared.safety.apply_from_shared -ne $false){$errors+="apply_from_shared_not_false"}
foreach($op in @("use_shared_as_repo","execute_scripts_from_shared_automatically","store_secrets")){if($op -notin @($shared.forbidden_operations)){$errors+=("missing_shared_forbidden:"+$op)}}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","ghp_","xoxb-","api_key=","password=","token=")){if($checklist -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B";stage="E04";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;git_sync_policy="$base/git-sync-policy.json";sync_checklist="$docs/DUAL_PC_GIT_SYNC_CHECKLIST.md";shared_workspace_bridge_policy="$base/shared-workspace-bridge-policy.json";shared_exchange_map="$base/shared-exchange-map.json";sync_model_ready=$ok;git_remote_auto=$false;git_fetch=$false;git_pull=$false;git_push=$false;git_merge=$false;git_write=$false;shared_repo_edit=$false;auto_execution_from_shared=$false;secret_storage_allowed=$false;apply_executed=$false;remote_execution=$false;single_active_writer=$true;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E04_DUAL_PC_SAFE_SYNC_MODEL_READY"}else{"NO_GO_E04_REPAIR_REQUIRED"}));next=($(if($ok){"E05_DUAL_PC_STATUS_DASHBOARD"}else{"REPAIR_E04_SAFE_SYNC"}))}
J $report "$reports/e04-dual-pc-sync-validation-report.json"
if(-not $ok){throw "Dual-PC sync policies validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E04 readiness="+$report.readiness+" decision="+$report.decision+" sync_model_ready="+$report.sync_model_ready+" git_remote_auto="+$report.git_remote_auto+" git_write="+$report.git_write+" shared_repo_edit="+$report.shared_repo_edit+" secret_storage_allowed="+$report.secret_storage_allowed+" next="+$report.next) -ForegroundColor Green
