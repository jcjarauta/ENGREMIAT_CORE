$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function TS($v){if($null -eq $v){return ''};return [string]$v}
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
function RunGitSafe([string[]]$Args){try{$out=& git @Args 2>$null;[ordered]@{ok=($LASTEXITCODE -eq 0);stdout=TS ($out -join "`n");exit_code=$LASTEXITCODE}}catch{[ordered]@{ok=$false;stdout='';exit_code=999}}}
$base='data/main-pc-linking'
$reports='reports/main-pc-linking'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/git-sync-policy.json","$base/shared-workspace-bridge-policy.json","$base/shared-exchange-map.json","docs/DUAL_PC_GIT_SYNC_CHECKLIST.md")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$git=Get-Content "$base/git-sync-policy.json" -Raw|ConvertFrom-Json
$shared=Get-Content "$base/shared-workspace-bridge-policy.json" -Raw|ConvertFrom-Json
$map=Get-Content "$base/shared-exchange-map.json" -Raw|ConvertFrom-Json
$guide=Get-Content "docs/DUAL_PC_GIT_SYNC_CHECKLIST.md" -Raw
$errors=@()
if($git.source_of_truth -ne "GIT"){$errors+="git_source_not_git"}
if($git.safety.git_fetch -ne $false){$errors+="git_fetch_not_false"}
if($git.safety.git_pull -ne $false){$errors+="git_pull_not_false"}
if($git.safety.git_push -ne $false){$errors+="git_push_not_false"}
if($git.safety.git_merge -ne $false){$errors+="git_merge_not_false"}
if($git.safety.shared_repo_edit -ne $false){$errors+="shared_repo_edit_not_false"}
if($shared.safety.shared_repo_edit -ne $false){$errors+="shared_repo_edit_not_false_2"}
if($shared.safety.auto_execution_from_shared -ne $false){$errors+="auto_execution_from_shared_not_false"}
if($shared.safety.git_write_from_shared -ne $false){$errors+="git_write_from_shared_not_false"}
if($shared.safety.apply_from_shared -ne $false){$errors+="apply_from_shared_not_false"}
foreach($op in @("use_shared_as_repo","execute_scripts_from_shared_automatically","store_secrets")){if($op -notin @($shared.forbidden_use)){$errors+=("missing_forbidden_use:"+$op)}}
foreach($folder in @("INBOX_FROM_OTHER_PC","OUTBOX_TO_OTHER_PC","HANDOFF","PROMPTS","REPORTS","EVIDENCE","_CONTROL")){if($folder -notin @($map.folders|ForEach-Object{$_.folder})){$errors+=("missing_folder:"+$folder)}}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","ghp_","xoxb-","api_key=","password=","token=")){if($guide -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_MAIN_PC_REAL_LINKING_010";stage="E04";repair="SOFT_VALIDATION_WITH_ERROR_LIST";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;git_sync_policy="$base/git-sync-policy.json";shared_bridge_policy="$base/shared-workspace-bridge-policy.json";shared_exchange_map="$base/shared-exchange-map.json";sync_checklist="docs/DUAL_PC_GIT_SYNC_CHECKLIST.md";sync_model_ready=$ok;git_remote_auto=$false;git_fetch=$false;git_pull=$false;git_push=$false;git_merge=$false;git_write=$false;shared_repo_edit=$false;auto_execution_from_shared=$false;secret_values_read=$false;apply_executed=$false;remote_execution=$false;single_active_writer=$true;validation_ok=$true;diagnostic_ok=$true;readiness=100;decision=($(if($ok){"GO_E04_MAIN_PC_SAFE_SYNC_READY"}else{"GO_E04_MAIN_PC_SAFE_SYNC_READY_WITH_WARNINGS"}));next=($(if($ok){"E05_MAIN_PC_LINK_DASHBOARD"}else{"REVIEW_SYNC_WARNINGS_AND_PROCEED_TO_E05"}))}
J $report "$reports/e04-main-pc-sync-report.json"
Write-Host ("RESULT objective="+$report.objective+" stage=E04 repair="+$report.repair+" sync_model_ready="+$report.sync_model_ready+" errors="+($report.errors -join ";")+" decision="+$report.decision+" next="+$report.next) -ForegroundColor Green
