$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/dual-pc-development-workflow'
$reports='reports/dual-pc-development-workflow'
$docs='docs'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/dual-pc-handoff-schema.json","$base/current-to-main-pc-handoff-template.json","$base/current-pc-state-snapshot.json","$docs/HANDOFF_CURRENT_PC_TO_MAIN_PC.md")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$schema=Get-Content "$base/dual-pc-handoff-schema.json" -Raw|ConvertFrom-Json
$template=Get-Content "$base/current-to-main-pc-handoff-template.json" -Raw|ConvertFrom-Json
$snapshot=Get-Content "$base/current-pc-state-snapshot.json" -Raw|ConvertFrom-Json
$md=Get-Content "$docs/HANDOFF_CURRENT_PC_TO_MAIN_PC.md" -Raw
$errors=@()
foreach($f in @("handoff_id","objective","active_stage","current_pc","target_pc","git_status_summary","next_action","evidence")){if($f -notin @($schema.required_fields)){$errors+=("schema_missing_field:"+$f)}}
if($template.target_pc -ne "MAIN_PC"){$errors+="template_target_not_main_pc"}
if($template.writer_authority.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($template.limits.remote_execution -ne $false){$errors+="template_remote_execution_not_false"}
if($template.limits.git_write -ne $false){$errors+="template_git_write_not_false"}
if($snapshot.limits.secret_values_read -ne $false){$errors+="snapshot_secret_values_read_not_false"}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","sk-","xoxb-","ghp_","api_key=","password=","token=")){if($md -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B";stage="E02";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;handoff_schema="$base/dual-pc-handoff-schema.json";handoff_template="$base/current-to-main-pc-handoff-template.json";snapshot="$base/current-pc-state-snapshot.json";handoff_markdown="$docs/HANDOFF_CURRENT_PC_TO_MAIN_PC.md";handoff_ready=$ok;main_pc_touched=$false;remote_execution=$false;secret_values_read=$false;git_write=$false;git_push=$false;git_fetch=$false;git_merge=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E02_DUAL_PC_HANDOFF_READY"}else{"NO_GO_E02_REPAIR_REQUIRED"}));next=($(if($ok){"E03_REPO_READINESS_PER_PC"}else{"REPAIR_E02_HANDOFF"}))}
J $report "$reports/e02-dual-pc-handoff-validation-report.json"
if(-not $ok){throw "Dual-PC handoff validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E02 readiness="+$report.readiness+" decision="+$report.decision+" handoff_ready="+$report.handoff_ready+" main_pc_touched="+$report.main_pc_touched+" remote_execution="+$report.remote_execution+" secret_values_read="+$report.secret_values_read+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
