$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$objective="ENGREMIAT_KANBAN_VISIBLE_AND_OLLAMA_READY_013";$base="data/kanban-visible-ollama-ready-013";$docs="docs";$tools="tools/kanban-visible-ollama-ready-013";$dash="dashboard/kanban-visible-ollama-ready-013";$reports="reports/kanban-visible-ollama-ready-013"
New-Item -ItemType Directory -Force -Path $base,$docs,$tools,$dash,$reports|Out-Null
$launcher=Join-Path $tools "Open-ClineKanban.ps1"
$html=Join-Path $dash "index.html"
$guide=Join-Path $docs "KANBAN_VISIBLE_GUIDE.md"
$lt=if(Test-Path $launcher){Get-Content $launcher -Raw}else{""}
$ht=if(Test-Path $html){Get-Content $html -Raw}else{""}
$gt=if(Test-Path $guide){Get-Content $guide -Raw}else{""}
$errors=@()
if(-not(Test-Path $launcher)){$errors += "missing_launcher"}
if(-not(Test-Path $html)){$errors += "missing_dashboard"}
if(-not(Test-Path $guide)){$errors += "missing_guide"}
if($lt -notmatch "preview"){$errors += "launcher_preview_missing"}
if($ht -notmatch "ENGREMIAT Kanban Visible"){$errors += "dashboard_title_missing"}
if($ht -notmatch "No abre nada por defecto"){$errors += "dashboard_no_default_open_missing"}
if($gt -notmatch "No abre por defecto"){$errors += "guide_no_default_open_missing"}
$valid=($errors.Count -eq 0)
$rd=if($valid){100}else{70}
$dec=if($valid){"GO_E02_KANBAN_VALIDATED"}else{"NO_GO_REPAIR"}
$nx=if($valid){"E03_OLLAMA_READY"}else{"REPAIR_OR_COMPLETE_E02"}
J ([ordered]@{objective=$objective;stage="E02";readiness=$rd;decision=$dec;next=$nx;validation_ok=$valid;errors=$errors;launcher_file=$launcher;dashboard_file=$html;guide_file=$guide;no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}) (Join-Path $reports "e02-kanban-visible-report.json")
Write-Host ("OK objective="+$objective+" stage=E02 readiness="+$rd+" decision="+$dec+" next="+$nx) -ForegroundColor Green
