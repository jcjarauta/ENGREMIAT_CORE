$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/kanban-real-setup-012'
$tools='tools/kanban-real-setup-012'
$reports='reports/kanban-real-setup-012'
$docs='docs'
$dash='dashboard/kanban-real-setup-012'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$html=Get-Content "$dash/index.html" -Raw
$launcher=Get-Content "$tools/Open-KanbanRealDashboard.ps1" -Raw
$guide=Get-Content "$docs/KANBAN_REAL_SETUP_GUIDE.md" -Raw
$checklist=Get-Content "$docs/KANBAN_STARTUP_CHECKLIST.md" -Raw
$errors=@()
if($html -notmatch 'ENGREMIAT Kanban Real Setup 012'){$errors+="html_title_missing"}
if($html -notmatch 'Dashboard humano local'){$errors+="html_summary_missing"}
if($launcher -notmatch 'preview'){$errors+="launcher_preview_missing"}
if($launcher -notmatch 'Read-Host'){$errors+="launcher_gate_missing"}
if($guide -notmatch 'Kanban es una vista'){$errors+="guide_missing_core_rule"}
if($checklist -notmatch 'Un solo escritor activo'){$errors+="checklist_missing_writer_rule"}
$ok=($errors.Count -eq 0)
$readiness=70
$decision='NO_GO_KANBAN_LAUNCHER_REPAIR_REQUIRED'
$next='REPAIR_KANBAN_LAUNCHER'
if($ok){$readiness=100;$decision='GO_KANBAN_LAUNCHER_READY';$next='E06_FINALIZE_AND_NEXT_OBJECTIVE'}
$report=[ordered]@{objective='ENGREMIAT_KANBAN_REAL_SETUP_012';stage='E05';dashboard='dashboard/kanban-real-setup-012/index.html';launcher='tools/kanban-real-setup-012/Open-KanbanRealDashboard.ps1';guide='docs/KANBAN_REAL_SETUP_GUIDE.md';checklist='docs/KANBAN_STARTUP_CHECKLIST.md';errors=$errors;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next;browser_opened=$false;remote_execution=$false;git_write=$false;auto_apply=$false;shared_repo_edit=$false}
J $report "$reports/e05-kanban-real-dashboard-validation-report.json"
Write-Host ('RESULT objective=ENGREMIAT_KANBAN_REAL_SETUP_012 stage=E05 readiness='+$readiness+' decision='+$decision+' next='+$next) -ForegroundColor Green
