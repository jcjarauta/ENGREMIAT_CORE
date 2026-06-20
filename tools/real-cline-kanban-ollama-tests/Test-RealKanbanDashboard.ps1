$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/real-cline-kanban-ollama-tests'
$reports='reports/real-cline-kanban-ollama-tests'
$dash='dashboard/real-cline-kanban-ollama-tests'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$schema=Get-Content "$base/real-kanban-state-schema.json" -Raw | ConvertFrom-Json
$snapshot=Get-Content "$base/real-kanban-state-snapshot.json" -Raw | ConvertFrom-Json
$data=Get-Content "$base/kanban-dashboard-data.json" -Raw | ConvertFrom-Json
$html=Get-Content "$dash/index.html" -Raw
$errors=@()
if($schema.columns.Count -lt 6){$errors+="columns_missing"}
if($snapshot.browser_opened -ne $false){$errors+="browser_opened_not_false"}
if($snapshot.remote_execution -ne $false){$errors+="remote_execution_not_false"}
if($data.forbidden_actions -notcontains "git_write"){$errors+="git_write_forbidden_missing"}
if($html -notmatch "ENGREMIAT Real Kanban 011"){$errors+="html_title_missing"}
if($html -notmatch "BACKLOG"){$errors+="html_columns_missing"}
$ok=($errors.Count -eq 0)
$readiness=70
$decision="NO_GO_E02_REPAIR_REQUIRED"
$next="REPAIR_E02_KANBAN"
if($ok){$readiness=100;$decision="GO_E02_KANBAN_READY";$next="E03_OLLAMA_REAL_PREFLIGHT"}
$report=[ordered]@{objective="ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011";stage="E02";errors=$errors;browser_opened=$false;remote_execution=$false;git_write=$false;auto_apply=$false;shared_repo_edit=$false;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next}
J $report "$reports/e02-real-kanban-dashboard-report.json"
Write-Host ("RESULT objective=ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011 stage=E02 readiness="+$readiness+" decision="+$decision+" next="+$next) -ForegroundColor Green
