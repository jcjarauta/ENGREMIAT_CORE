param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_v1_health_git_out.txt";$err="$env:TEMP\eng_v1_health_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$HealthDirs=@(); foreach($d in @("tools","reports","documents","data","backups")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName.Split("\").Count -le ($Root.Split("\").Count+4) -and $_.Name -match "health|launcher|doctor|smoke|validate|validation|check|repair|status" } | Sort-Object LastWriteTime -Descending | Select-Object -First 100 | ForEach-Object { $kind="HEALTH_HINT"; if($_.Name -match "launcher|launch|inicio"){$kind="LAUNCHER_HINT"} elseif($_.Name -match "health|healthcheck|doctor"){$kind="HEALTH_HINT"} elseif($_.Name -match "smoke|test|validate|validation|check"){$kind="SMOKE_HINT"} elseif($_.Name -match "repair|fix|restore"){$kind="REPAIR_HINT"} elseif($_.Name -match "status|state|report"){$kind="STATUS_HINT"}; $HealthDirs += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");kind=$kind} } } }
$HealthFiles=@(); foreach($d in @("tools","reports","documents","data")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".ps1",".json",".md",".txt") -and $_.Name -match "health|launcher|doctor|smoke|validate|validation|check|repair|status" } | Sort-Object LastWriteTime -Descending | Select-Object -First 140 | ForEach-Object { $kind="HEALTH_FILE"; if($_.Name -match "launcher|launch|inicio"){$kind="LAUNCHER"} elseif($_.Name -match "health|healthcheck|doctor"){$kind="HEALTH"} elseif($_.Name -match "smoke|test|validate|validation|check"){$kind="SMOKE"} elseif($_.Name -match "repair|fix|restore"){$kind="REPAIR"} elseif($_.Name -match "status|state|report"){$kind="STATUS"}; $HealthFiles += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length;kind=$kind} } } }
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 10 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$LauncherCount=($HealthFiles | Where-Object { $_.kind -eq "LAUNCHER" }).Count
$HealthCount=($HealthFiles | Where-Object { $_.kind -eq "HEALTH" }).Count
$SmokeCount=($HealthFiles | Where-Object { $_.kind -eq "SMOKE" }).Count
$RepairCount=($HealthFiles | Where-Object { $_.kind -eq "REPAIR" }).Count
$StatusCount=($HealthFiles | Where-Object { $_.kind -eq "STATUS" }).Count
$View=[ordered]@{screen="OPERATOR_V1_HEALTH_LAUNCHERS";updated_at=(Get-Date).ToString("s");purpose="Pantalla V1 para operar salud de launchers bajo gobierno V2.";git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=$TreeClean;status_short=$Status.Stdout};summary=[ordered]@{health_dirs_count=$HealthDirs.Count;health_files_count=$HealthFiles.Count;launcher_count=$LauncherCount;health_count=$HealthCount;smoke_count=$SmokeCount;repair_count=$RepairCount;status_count=$StatusCount;reports_recent_count=$Reports.Count;next_human_action="VALIDAR_PANTALLA_HEALTH_LAUNCHERS_V1_Y_PREPARAR_GATE_LAUNCHER"};health_dirs=$HealthDirs;health_files=$HealthFiles;reports_recent=$Reports;v1_operational=@("1 Inicio operador","2 Proyectos","3 Memoria y documentacion","4 Data Intake");v2_governance=@("6 Estado vivo V2","7 Siguiente accion V2","8 Panel control V2","9 Close & Sync V2");blocked_actions=@("worker_real","api_externa","navegador","clipboard","delete_files","push_auto","fetch_auto","merge_auto","ejecutar_reparaciones_sin_gate","ejecutar_smokes_sensibles_sin_gate","modificar_launchers_sin_gate");next="E04_GATE_LAUNCHER_INTEGRATION_HEALTH_LAUNCHERS"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / HEALTH LAUNCHERS ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "RESUMEN DE SALUD" Cyan
W ("Directorios health: "+$View.summary.health_dirs_count) Green
W ("Archivos health: "+$View.summary.health_files_count) Green
W ("Launchers: "+$View.summary.launcher_count+" | Health: "+$View.summary.health_count+" | Smokes/checks: "+$View.summary.smoke_count) Gray
W ("Repairs: "+$View.summary.repair_count+" | Status/reports: "+$View.summary.status_count+" | Reports recientes: "+$View.summary.reports_recent_count) Gray
W ""
W "GIT" Cyan
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "DIRECTORIOS HEALTH / LAUNCHERS" Cyan
if($View.health_dirs.Count -eq 0){W " - sin directorios candidatos" DarkYellow}else{$View.health_dirs | Select-Object -First 14 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
W ""
W "ARCHIVOS HEALTH / LAUNCHERS" Cyan
if($View.health_files.Count -eq 0){W " - sin archivos candidatos" DarkYellow}else{$View.health_files | Select-Object -First 10 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
W ""
W "REPORTS RECIENTES" Cyan
if($View.reports_recent.Count -eq 0){W " - sin reports detectados" DarkYellow}else{$View.reports_recent | Select-Object -First 6 | ForEach-Object { W (" - "+$_.path) Gray }}
W ""
W "V1 OPERATIVO" Cyan
$View.v1_operational | ForEach-Object { W (" - "+$_) Gray }
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
