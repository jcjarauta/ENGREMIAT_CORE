$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/dual-pc-development-workflow'
$tools='tools/dual-pc-development-workflow'
$reports='reports/dual-pc-development-workflow'
$docs='docs'
$dash='dashboard/dual-pc-development-workflow'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/dual-pc-dashboard-data.json","$dash/index.html","$tools/Open-DualPcWorkflowDashboard.ps1","$docs/DUAL_PC_DEVELOPMENT_WORKFLOW_GUIDE.md")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$data=Get-Content "$base/dual-pc-dashboard-data.json" -Raw|ConvertFrom-Json
$html=Get-Content "$dash/index.html" -Raw
$launcher=Get-Content "$tools/Open-DualPcWorkflowDashboard.ps1" -Raw
$guide=Get-Content "$docs/DUAL_PC_DEVELOPMENT_WORKFLOW_GUIDE.md" -Raw
$errors=@()
if($data.safety.browser_opened -ne $false){$errors+="data_browser_opened_not_false"}
if($data.safety.main_pc_touched -ne $false){$errors+="main_pc_touched_not_false"}
if($data.safety.git_write -ne $false){$errors+="git_write_not_false"}
if($data.writer_lock.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($html -notmatch "ENGREMIAT Dual-PC Workflow 009B"){$errors+="html_title_missing"}
if($launcher -notmatch "preview"){$errors+="launcher_preview_missing"}
if($launcher -notmatch "Read-Host"){$errors+="launcher_open_gate_missing"}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","ghp_","xoxb-","api_key=","password=","token=")){if($guide -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B";stage="E05";repair="ALIAS_H_TO_HTMLESC";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;dashboard_data="$base/dual-pc-dashboard-data.json";dashboard_html="$dash/index.html";launcher="$tools/Open-DualPcWorkflowDashboard.ps1";guide="$docs/DUAL_PC_DEVELOPMENT_WORKFLOW_GUIDE.md";dashboard_ready=$ok;browser_opened=$false;main_pc_touched=$false;remote_execution=$false;git_write=$false;git_remote_auto=$false;secret_values_read=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E05_DUAL_PC_DASHBOARD_READY"}else{"NO_GO_E05_REPAIR_REQUIRED"}));next=($(if($ok){"E06_CLOSE_AND_CONTINUITY_TO_MAIN_PC_LINKING"}else{"REPAIR_E05_DASHBOARD"}))}
J $report "$reports/e05-dual-pc-dashboard-validation-report.json"
if(-not $ok){throw "Dual-PC dashboard validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E05 repair="+$report.repair+" readiness="+$report.readiness+" decision="+$report.decision+" dashboard_ready="+$report.dashboard_ready+" browser_opened="+$report.browser_opened+" main_pc_touched="+$report.main_pc_touched+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
