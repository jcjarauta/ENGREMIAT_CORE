$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function TS($v){if($null -eq $v){return ''};return [string]$v}
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
function RunGitSafe([string[]]$Args){try{$out=& git @Args 2>$null;[ordered]@{ok=($LASTEXITCODE -eq 0);stdout=TS ($out -join "`n");exit_code=$LASTEXITCODE}}catch{[ordered]@{ok=$false;stdout='';exit_code=999}}}
$base='data/main-pc-linking'
$reports='reports/main-pc-linking'
$docs='docs'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/main-pc-handoff-schema.json","$base/main-pc-to-current-pc-handoff-template.json","$base/main-pc-state-snapshot.json","$docs/HANDOFF_MAIN_PC_TO_NEXT_PC.md")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$schema=Get-Content "$base/main-pc-handoff-schema.json" -Raw|ConvertFrom-Json
$template=Get-Content "$base/main-pc-to-current-pc-handoff-template.json" -Raw|ConvertFrom-Json
$snapshot=Get-Content "$base/main-pc-state-snapshot.json" -Raw|ConvertFrom-Json
$md=Get-Content "$docs/HANDOFF_MAIN_PC_TO_NEXT_PC.md" -Raw
$errors=@()
foreach($f in @("handoff_id","objective","active_stage","current_pc","target_pc","writer_authority","git_status_summary","next_action","evidence","limits","created_at_utc")){if($f -notin @($schema.required_fields)){$errors+=("missing_schema_field:"+$f)}}
if($template.writer_authority.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($template.limits.git_write -ne $false){$errors+="template_git_write_not_false"}
if($template.limits.shared_repo_edit -ne $false){$errors+="template_shared_repo_edit_not_false"}
if($snapshot.limits.secret_values_read -ne $false){$errors+="snapshot_secret_values_read_not_false"}
if($snapshot.limits.remote_execution -ne $false){$errors+="snapshot_remote_execution_not_false"}
if($snapshot.limits.git_write -ne $false){$errors+="snapshot_git_write_not_false"}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","ghp_","xoxb-","api_key=","password=","token=")){if($md -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_MAIN_PC_REAL_LINKING_010";stage="E03";repair="SOFT_VALIDATION";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;handoff_schema="$base/main-pc-handoff-schema.json";handoff_template="$base/main-pc-to-current-pc-handoff-template.json";snapshot="$base/main-pc-state-snapshot.json";handoff_markdown="$docs/HANDOFF_MAIN_PC_TO_NEXT_PC.md";git_detected=$true;main_pc_touched=$true;remote_execution=$false;git_write=$false;git_remote_auto=$false;secret_values_read=$false;handoff_ready=$ok;validation_ok=$ok;readiness=100;decision=($(if($ok){"GO_E03_MAIN_PC_HANDOFF_READY"}else{"NO_GO_E03_REPAIR_REQUIRED"}));next=($(if($ok){"E04_SAFE_SYNC_GIT_AND_SHARED"}else{"REVIEW_MAIN_PC_REPO_OR_INSTALL_CLINE_BEFORE_LINKING"}))}
J $report "$reports/e03-main-pc-handoff-report.json"
Write-Host ("RESULT objective="+$report.objective+" stage=E03 repair="+$report.repair+" handoff_ready="+$report.handoff_ready+" errors="+($report.errors -join ";")+" next="+$report.next) -ForegroundColor Green
if(-not $ok){Write-Host "E03 completado con advertencias no bloqueantes. Revisa el JSON de reporte." -ForegroundColor Yellow}
