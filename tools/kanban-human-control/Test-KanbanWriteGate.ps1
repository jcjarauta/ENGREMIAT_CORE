$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$objective="ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007"
$base="data/kanban-human-control"
$reportPath="reports/kanban-human-control/e05-kanban-write-gate-validation-report.json"
$gatePath="$base/kanban-write-gate.json"
$requestPath="$base/kanban-write-request-preview.json"
$guidePath="docs/KANBAN_WRITE_GATE_GUIDE.md"
if(-not(Test-Path $gatePath)){throw "Falta gate: $gatePath"}
if(-not(Test-Path $requestPath)){throw "Falta request preview: $requestPath"}
$gate=Get-Content $gatePath -Raw|ConvertFrom-Json
$request=Get-Content $requestPath -Raw|ConvertFrom-Json
$flags=@("kanban_write","real_kanban_sync","launch_cline_task","cline_task_created","worker_real_execution","auto_apply","git_write","remote_inference","ui_automation")
$bad=@()
foreach($f in $flags){if($gate.safety.$f -ne $false){$bad+=("gate:"+$f)};if($request.safety.$f -ne $false){$bad+=("request:"+$f)}}
$ok=($gate.decision -eq "DEFER" -and $gate.authorization_required -eq $true -and $request.execution_now -eq $false -and $request.decision -eq "DEFER" -and $bad.Count -eq 0 -and (Test-Path $guidePath))
$report=[ordered]@{objective=$objective;stage="E05";blocks="B05.1-B05.3";steps=6;gate_file=$gatePath;guide_file=$guidePath;request_preview_file=$requestPath;gate_decision=$gate.decision;authorization_required=$gate.authorization_required;request_execution_now=$request.execution_now;request_decision=$request.decision;bad_safety_flags=$bad;kanban_write=$false;real_kanban_sync=$false;launch_cline_task=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false;ui_automation=$false;no_go_real_write=$true;no_go_reason="E05 prepara gate y request preview; no sincroniza tarjeta real.";readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E05_KANBAN_WRITE_GATE_DEFER_VALIDATED"}else{"NO_GO_E05_REPAIR_REQUIRED"}));next=($(if($ok){"E06_CLOSE_AND_NEXT_OBJECTIVE"}else{"REPAIR_E05_KANBAN_WRITE_GATE"}))}
J $report $reportPath
if(-not $ok){throw "E05 validation failed"}
Write-Host ("OK objective="+$objective+" stage=E05 readiness="+$report.readiness+" decision="+$report.decision+" gate_decision="+$report.gate_decision+" kanban_write="+$report.kanban_write+" no_go_real_write="+$report.no_go_real_write+" report="+$reportPath+" next="+$report.next) -ForegroundColor Green
