param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_panel_git_out.txt";$err="$env:TEMP\eng_panel_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$StatePath=Join-Path $Root "data/operator-v2-self-state-sync/v2-state.latest.json"
$NextPath=Join-Path $Root "data/operator-v2-next-action-engine/next-action.latest.json"
$EventsPath=Join-Path $Root "data/operator-v2-self-state-sync/v2-state.events.jsonl"
if(!(Test-Path $StatePath)){throw "state_latest_missing"}
if(!(Test-Path $NextPath)){throw "next_action_latest_missing"}
$State=Get-Content $StatePath -Raw | ConvertFrom-Json
$Next=Get-Content $NextPath -Raw | ConvertFrom-Json
$Head=G "rev-parse --short HEAD"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$GitStatus=G "status --short"
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 12 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$EventsCount=0; if(Test-Path $EventsPath){$EventsCount=(Get-Content $EventsPath -ErrorAction SilentlyContinue | Measure-Object).Count}
$Risk=$Next.risk; if([string]::IsNullOrWhiteSpace($Risk)){$Risk="LOW"}; if(-not [string]::IsNullOrWhiteSpace($GitStatus.Stdout)){$Risk="MEDIUM"}
$View=[ordered]@{screen="OPERATOR_V2_CONTROL_PANEL";updated_at=(Get-Date).ToString("s");state=[ordered]@{objective=$State.active_objective.id;stage=$State.last_stage;step=$State.last_step;status=$State.last_status;readiness=$State.readiness;next_action=$State.next_action;summary=$State.human_summary};next_action=[ordered]@{recommendation=$Next.recommendation;risk=$Next.risk;allowed_actions=$Next.allowed_actions;blocked_actions=$Next.blocked_actions;human_prompt=$Next.human_prompt};git=[ordered]@{head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=[string]::IsNullOrWhiteSpace($GitStatus.Stdout);status_short=$GitStatus.Stdout};reports_recent=$Reports;reports_recent_count=$Reports.Count;events_count=$EventsCount;panel_risk=$Risk;next_objective="VALORAR_SIGUIENTE_OBJETIVO_OPERADOR_V2"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V2 / PANEL DE CONTROL ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "ESTADO VIVO" Cyan
W ("Objetivo:  "+$View.state.objective) Green
W ("Stage:     "+$View.state.stage) Green
W ("Paso:      "+$View.state.step) Green
W ("Estado:    "+$View.state.status) Green
W ("Readiness: "+$View.state.readiness+"%") Yellow
W ("NEXT:      "+$View.state.next_action) Magenta
W ""
W "SIGUIENTE ACCION" Cyan
W ("Riesgo:        "+$View.next_action.risk) Yellow
W ("Recomendacion: "+$View.next_action.recommendation) White
W ""
W "GIT" Cyan
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "REPORTS RECIENTES" Cyan
if($View.reports_recent_count -eq 0){ W " - sin reports detectados" DarkYellow } else { $View.reports_recent | Select-Object -First 8 | ForEach-Object { W (" - "+$_.path) Gray } }
W ""
W ("EVENTOS V2: "+$View.events_count) Gray
W ("RIESGO PANEL: "+$View.panel_risk) Yellow
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.next_action.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "PROXIMO OBJETIVO" Magenta
W ($View.next_objective) Magenta
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
