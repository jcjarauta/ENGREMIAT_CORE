$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/local-multiworker-launch-and-link-n1'
$tools='tools/local-multiworker-launch-and-link-n1'
$reports='reports/local-multiworker-launch-and-link-n1'
$dash='dashboard/local-multiworker-launch-and-link-n1/index.html'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$required=@("$base/dashboard-data.json","$dash","$tools/Open-LocalMultiworkerSurfacesN1.ps1","$base/local-launch-plan.json","$reports/e03-launcher-preview-result.json")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$data=Get-Content "$base/dashboard-data.json" -Raw|ConvertFrom-Json
$plan=Get-Content "$base/local-launch-plan.json" -Raw|ConvertFrom-Json
$launcherResult=Get-Content "$reports/e03-launcher-preview-result.json" -Raw|ConvertFrom-Json
$htmlSize=0;if(Test-Path $dash){$htmlSize=(Get-Item $dash).Length}
$errors=@()
if($data.summary.browser_opened -ne $false){$errors+="dashboard_data_browser_opened_not_false"}
if($data.summary.remote_execution -ne $false){$errors+="dashboard_data_remote_execution_not_false"}
if($data.summary.git_write -ne $false){$errors+="dashboard_data_git_write_not_false"}
if($plan.safety.browser_opened -ne $false){$errors+="launch_plan_browser_opened_not_false"}
if($launcherResult.browser_opened -ne $false){$errors+="launcher_preview_opened_browser"}
if($launcherResult.cline_executed -ne $false){$errors+="launcher_cline_executed"}
if($launcherResult.ollama_executed -ne $false){$errors+="launcher_ollama_executed"}
if($htmlSize -lt 1000){$errors+="dashboard_html_too_small"}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$report=[ordered]@{objective='ENGREMIAT_LOCAL_MULTIWORKER_LAUNCH_AND_LINK_009A_N1';stage='E03';dashboard_data="$base/dashboard-data.json";dashboard_html=$dash;launcher="$tools/Open-LocalMultiworkerSurfacesN1.ps1";launch_plan="$base/local-launch-plan.json";launcher_preview_result="$reports/e03-launcher-preview-result.json";missing_artifacts=$missing;errors=$errors;dashboard_html_size_bytes=$htmlSize;nodes_total=$data.summary.nodes_total;surfaces_total=$data.summary.surfaces_total;browser_opened=$false;cline_executed=$false;ollama_executed=$false;remote_execution=$false;git_write=$false;apply_executed=$false;ready_for_partial_readiness=$ok;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){'GO_E03_DASHBOARD_AND_LAUNCHER_PREVIEW_READY'}else{'NO_GO_E03_REPAIR_REQUIRED'}));next=($(if($ok){'E04_PARTIAL_READINESS_AND_CONTINUITY'}else{'REPAIR_E03_DASHBOARD_LAUNCHER'}))}
J $report "$reports/e03-dashboard-launcher-validation-report.json"
if(-not $ok){throw "Dashboard/launcher validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E03 readiness="+$report.readiness+" decision="+$report.decision+" dashboard="+$report.dashboard_html+" browser_opened="+$report.browser_opened+" remote_execution="+$report.remote_execution+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
