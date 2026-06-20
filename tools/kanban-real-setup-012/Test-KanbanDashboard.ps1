$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/kanban-real-setup-012'
$reports='reports/kanban-real-setup-012'
$dash='dashboard/kanban-real-setup-012'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$html=Get-Content "$dash/index.html" -Raw
$guide=Get-Content "docs/KANBAN_DASHBOARD_GUIDE.md" -Raw
$board=Get-Content "$base/kanban-board.json" -Raw | ConvertFrom-Json
$errors=@()
if($html -notmatch 'ENGREMIAT Kanban Real Setup 012'){$errors+='html_title_missing'}
if($html -notmatch 'Dashboard humano local'){$errors+='html_summary_missing'}
if($html -notmatch 'BACKLOG'){$errors+='html_columns_missing'}
if($guide -notmatch 'Kanban es una vista'){$errors+='guide_missing_core_rule'}
if($guide -notmatch 'No apply'){$errors+='guide_missing_no_apply'}
if($board.cards.Count -lt 1){$errors+='board_cards_missing'}
$ok=($errors.Count -eq 0)
$readiness=70
$decision='NO_GO_KANBAN_DASHBOARD_REPAIR_REQUIRED'
$next='REPAIR_KANBAN_DASHBOARD'
if($ok){$readiness=100;$decision='GO_KANBAN_DASHBOARD_READY';$next='E05_LAUNCHER_AND_HUMAN_CONTROL'}
$report=[ordered]@{objective='ENGREMIAT_KANBAN_REAL_SETUP_012';stage='E04';dashboard='dashboard/kanban-real-setup-012/index.html';guide='docs/KANBAN_DASHBOARD_GUIDE.md';errors=$errors;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next;browser_opened=$false;remote_execution=$false;git_write=$false;auto_apply=$false;shared_repo_edit=$false}
J $report "$reports/e04-kanban-dashboard-validation-report.json"
Write-Host ('RESULT objective=ENGREMIAT_KANBAN_REAL_SETUP_012 stage=E04 readiness=' + $readiness + ' decision=' + $decision + ' next=' + $next) -ForegroundColor Green
