param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
$Root=(Get-Location).Path
$LatestPath=Join-Path $Root "data/operator-v2-self-state-sync/v2-state.latest.json"
$EventsPath=Join-Path $Root "data/operator-v2-self-state-sync/v2-state.events.jsonl"
if(!(Test-Path $LatestPath)){throw "latest_missing"}
$Latest=Get-Content $LatestPath -Raw | ConvertFrom-Json
$EventsCount=0;if(Test-Path $EventsPath){$EventsCount=(Get-Content $EventsPath -ErrorAction SilentlyContinue | Measure-Object).Count}
$Risk="LOW"
if(($Latest.readiness -as [int]) -lt 50){$Risk="MEDIUM"}
if(($Latest.next_action+"") -match "PUSH|FETCH|MERGE|WORKER|API|BROWSER|CLIPBOARD|DELETE"){ $Risk="HIGH" }
$Recommendation="Seguir con el siguiente bloque seguro indicado por next_action."
if(($Latest.next_action+"") -match "VALORAR|PAUSAR"){ $Recommendation="Pausar desarrollo tecnico y valorar siguiente objetivo antes de tocar V1." }
if(($Latest.next_action+"") -match "E0[0-9]|E[0-9]+"){ $Recommendation="Continuar con el siguiente bloque del objetivo activo manteniendo validacion y cierre scoped." }
$Why="El estado vivo V2 contiene next_action, readiness, ultimo estado y resumen; esta pantalla los convierte en decision operativa visible."
$Allowed=@("mostrar_estado_v2","abrir_reporte","pausar","seguir_con_siguiente_bloque","preparar_gate")
$Blocked=@("push","fetch","merge","borrar_archivos","worker_real","api_externa","navegador","clipboard")
$View=[ordered]@{screen="OPERATOR_V2_NEXT_ACTION";updated_at=(Get-Date).ToString("s");current_objective=$Latest.active_objective.id;current_stage=$Latest.last_stage;current_step=$Latest.last_step;current_status=$Latest.last_status;readiness=$Latest.readiness;next_action=$Latest.next_action;recommendation=$Recommendation;why=$Why;risk=$Risk;allowed_actions=$Allowed;blocked_actions=$Blocked;summary=$Latest.human_summary;events_count=$EventsCount;git_state=$Latest.git_state;human_prompt="Decidir: seguir, pausar, preparar gate o cerrar objetivo."}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V2 / SIGUIENTE ACCION ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W ("Objetivo:   "+$View.current_objective) Green
W ("Stage:      "+$View.current_stage) Green
W ("Paso:       "+$View.current_step) Green
W ("Estado:     "+$View.current_status) Green
W ("Readiness:  "+$View.readiness+"%") Yellow
W ""
W "NEXT" Magenta
W ($View.next_action) Magenta
W ""
W "RECOMENDACION" Cyan
W ($View.recommendation) White
W ""
W "POR QUE" Cyan
W ($View.why) Gray
W ""
W ("RIESGO: "+$View.risk) Yellow
W ""
W "ACCIONES PERMITIDAS" Cyan
$View.allowed_actions | ForEach-Object { W (" - "+$_) Gray }
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "PROMPT HUMANO" Cyan
W ($View.human_prompt) White
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
