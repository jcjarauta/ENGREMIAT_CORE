param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_v1_projects_git_out.txt";$err="$env:TEMP\eng_v1_projects_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$ProjectDirs=@(); foreach($d in @("projects","data","documents","modules")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "project|PROJECT|ENGREMIAT_PROJECT|proyecto|projects" } | Sort-Object LastWriteTime -Descending | Select-Object -First 40 | ForEach-Object { $kind="UNKNOWN"; if($_.Name -match "active|ACTIVO|latest|current"){$kind="ACTIVE_HINT"} elseif($_.Name -match "historic|HISTORICO|archive|old"){$kind="HISTORIC_HINT"}; $ProjectDirs += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");kind=$kind} } } }
$ProjectFiles=@(); foreach($d in @("data","documents","reports")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "project|PROJECT|proyecto" -and $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 40 | ForEach-Object { $ProjectFiles += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } } }
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 8 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$ActiveCount=($ProjectDirs | Where-Object { $_.kind -eq "ACTIVE_HINT" }).Count
$HistoricCount=($ProjectDirs | Where-Object { $_.kind -eq "HISTORIC_HINT" }).Count
$UnknownCount=($ProjectDirs | Where-Object { $_.kind -eq "UNKNOWN" }).Count
$View=[ordered]@{screen="OPERATOR_V1_PROJECTS";updated_at=(Get-Date).ToString("s");purpose="Pantalla V1 para operar proyectos detectados bajo gobierno V2.";git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=$TreeClean;status_short=$Status.Stdout};summary=[ordered]@{project_dirs_count=$ProjectDirs.Count;project_files_count=$ProjectFiles.Count;active_hint_count=$ActiveCount;historic_hint_count=$HistoricCount;unknown_count=$UnknownCount;reports_recent_count=$Reports.Count;next_human_action="VALIDAR_PANTALLA_PROYECTOS_V1_Y_PREPARAR_GATE_LAUNCHER"};project_dirs=$ProjectDirs;project_files=$ProjectFiles;reports_recent=$Reports;v2_governance=@("6 Estado vivo V2","7 Siguiente accion V2","8 Panel control V2","9 Close & Sync V2");blocked_actions=@("worker_real","api_externa","navegador","clipboard","delete_files","push_auto","fetch_auto","merge_auto","modificar_proyectos_sin_gate");next="E04_GATE_LAUNCHER_INTEGRATION_PROJECTS"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / PROYECTOS ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "RESUMEN" Cyan
W ("Directorios proyecto: "+$View.summary.project_dirs_count) Green
W ("Archivos relacionados: "+$View.summary.project_files_count) Green
W ("Active hint: "+$View.summary.active_hint_count+" | Historic hint: "+$View.summary.historic_hint_count+" | Unknown: "+$View.summary.unknown_count) Gray
W ("Reports recientes: "+$View.summary.reports_recent_count) Gray
W ""
W "GIT" Cyan
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "PROYECTOS DETECTADOS" Cyan
if($View.project_dirs.Count -eq 0){W " - sin directorios candidatos" DarkYellow}else{$View.project_dirs | Select-Object -First 12 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
W ""
W "ARCHIVOS RELACIONADOS" Cyan
if($View.project_files.Count -eq 0){W " - sin archivos candidatos" DarkYellow}else{$View.project_files | Select-Object -First 8 | ForEach-Object { W (" - "+$_.path) Gray }}
W ""
W "REPORTS RECIENTES" Cyan
if($View.reports_recent.Count -eq 0){W " - sin reports detectados" DarkYellow}else{$View.reports_recent | Select-Object -First 6 | ForEach-Object { W (" - "+$_.path) Gray }}
W ""
W "GOBIERNO V2 DISPONIBLE" Cyan
$View.v2_governance | ForEach-Object { W (" - "+$_) Gray }
W ""
W "SIGUIENTE ACCION HUMANA" Magenta
W $View.summary.next_human_action Magenta
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
