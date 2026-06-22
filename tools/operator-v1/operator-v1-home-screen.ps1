param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_v1_home_git_out.txt";$err="$env:TEMP\eng_v1_home_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$ProjectsDir=Join-Path $Root "projects"
$ModulesDir=Join-Path $Root "modules"
$ReportsDir=Join-Path $Root "reports"
$ProjectCandidates=@(); foreach($d in @("projects","data","documents")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "project|PROJECT|ENGREMIAT_PROJECT" } | Select-Object -First 12 | ForEach-Object { $ProjectCandidates += $_.FullName.Replace($Root+"\","") } } }
$ModuleCandidates=@(); foreach($d in @("modules","tools","documents")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "module|operator|v1|v2|project|control" } | Select-Object -First 12 | ForEach-Object { $ModuleCandidates += $_.FullName.Replace($Root+"\","") } } }
$Reports=@(); if(Test-Path $ReportsDir){ Get-ChildItem $ReportsDir -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 8 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$View=[ordered]@{screen="OPERATOR_V1_HOME";updated_at=(Get-Date).ToString("s");purpose="Entrada diaria del Operador V1: operar proyectos, modulos, pendientes y estado esencial bajo gobierno V2.";git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=$TreeClean;status_short=$Status.Stdout};sections=[ordered]@{estado_operativo="READY_READONLY";proyectos_count=$ProjectCandidates.Count;modulos_count=$ModuleCandidates.Count;reports_recent_count=$Reports.Count;next_human_action="VALIDAR_PANTALLA_V1_HOME_Y_PREPARAR_GATE_LAUNCHER";v2_governance=@("6 Estado vivo V2","7 Siguiente accion V2","8 Panel control V2","9 Close & Sync V2")};projects=$ProjectCandidates;modules=$ModuleCandidates;reports_recent=$Reports;blocked_actions=@("worker_real","api_externa","navegador","clipboard","delete_files","push_auto","fetch_auto","merge_auto");next="E04_GATE_LAUNCHER_INTEGRATION_V1_HOME"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / INICIO ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "ESTADO OPERATIVO" Cyan
W ("Estado:     "+$View.sections.estado_operativo) Green
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "PROYECTOS" Cyan
if($View.projects.Count -eq 0){W " - sin proyectos detectados por esta pantalla inicial" DarkYellow}else{$View.projects | Select-Object -First 8 | ForEach-Object { W (" - "+$_) Gray }}
W ""
W "MODULOS / AREAS" Cyan
if($View.modules.Count -eq 0){W " - sin modulos detectados por esta pantalla inicial" DarkYellow}else{$View.modules | Select-Object -First 8 | ForEach-Object { W (" - "+$_) Gray }}
W ""
W "REPORTS RECIENTES" Cyan
if($View.reports_recent.Count -eq 0){W " - sin reports detectados" DarkYellow}else{$View.reports_recent | Select-Object -First 6 | ForEach-Object { W (" - "+$_.path) Gray }}
W ""
W "GOBIERNO V2 DISPONIBLE" Cyan
$View.sections.v2_governance | ForEach-Object { W (" - "+$_) Gray }
W ""
W "SIGUIENTE ACCION HUMANA" Magenta
W $View.sections.next_human_action Magenta
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
