$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
function TS($v){if($null -eq $v){return ''};return [string]$v}
$base='data/main-pc-linking'
$tools='tools/main-pc-linking'
$reports='reports/main-pc-linking'
$docs='docs'
$dash='dashboard/main-pc-linking'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/main-pc-link-dashboard-data.json","$dash/index.html","$tools/Open-MainPcLinkDashboard.ps1","$docs/MAIN_PC_LINKING_GUIDE.md")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$data=Get-Content "$base/main-pc-link-dashboard-data.json" -Raw|ConvertFrom-Json
$html=Get-Content "$dash/index.html" -Raw
$launcher=Get-Content "$tools/Open-MainPcLinkDashboard.ps1" -Raw
$guide=Get-Content "$docs/MAIN_PC_LINKING_GUIDE.md" -Raw
$errors=@()
if($data.safety.browser_opened -ne $false){$errors+="browser_opened_not_false"}
if($data.safety.git_write -ne $false){$errors+="git_write_not_false"}
if($data.safety.remote_execution -ne $false){$errors+="remote_execution_not_false"}
if($data.writer_lock.single_active_writer -ne $true){$errors+="single_active_writer_not_true"}
if($html -notmatch "ENGREMIAT Main-PC Linking 010"){$errors+="html_title_missing"}
if($launcher -notmatch "preview"){$errors+="launcher_preview_missing"}
if($launcher -notmatch "Read-Host"){$errors+="launcher_open_gate_missing"}
foreach($bad in @("BEGIN RSA PRIVATE KEY","BEGIN OPENSSH PRIVATE KEY","ghp_","xoxb-","api_key=","password=","token=")){if($guide -match [regex]::Escape($bad)){$errors+=("secret_marker_found:"+$bad)}}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective="ENGREMIAT_MAIN_PC_REAL_LINKING_010";stage="E05";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;dashboard_data="$base/main-pc-link-dashboard-data.json";dashboard_html="$dash/index.html";launcher="$tools/Open-MainPcLinkDashboard.ps1";guide="$docs/MAIN_PC_LINKING_GUIDE.md";dashboard_ready=$ok;browser_opened=$false;main_pc_touched=$false;remote_execution=$false;git_write=$false;git_remote_auto=$false;secret_values_read=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E05_MAIN_PC_DASHBOARD_READY"}else{"NO_GO_E05_REPAIR_REQUIRED"}));next=($(if($ok){"E06_CLOSE_AND_NEXT_OBJECTIVE"}else{"REPAIR_E05_DASHBOARD"}))}
J $report "$reports/e05-main-pc-link-dashboard-report.json"
if(-not $ok){throw "MAIN-PC link dashboard validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E05 readiness="+$report.readiness+" decision="+$report.decision+" dashboard_ready="+$report.dashboard_ready+" browser_opened="+$report.browser_opened+" main_pc_touched="+$report.main_pc_touched+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
