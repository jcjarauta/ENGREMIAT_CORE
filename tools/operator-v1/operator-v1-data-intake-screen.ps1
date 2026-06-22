param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_v1_data_intake_git_out.txt";$err="$env:TEMP\eng_v1_data_intake_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$IntakeDirs=@(); foreach($d in @("data","documents","reports","intake","inbox","imports","staging")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 80 | ForEach-Object { if($_.Name -match "intake|data|input|inbox|import|staging|source|raw|sheet|csv|tsv|open|api|collector|ingest"){ $kind="DATA_HINT"; if($_.Name -match "source|raw|input|inbox|fuente"){$kind="SOURCE_HINT"} elseif($_.Name -match "staging|STG|stage"){$kind="STAGING_HINT"} elseif($_.Name -match "import|importacion|ingest"){$kind="IMPORT_HINT"} elseif($_.Name -match "sheet|sheets|csv|tsv"){$kind="SHEET_HINT"} elseif($_.Name -match "api|open|collector"){$kind="API_HINT"}; $IntakeDirs += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");kind=$kind} } } } }
$IntakeFiles=@(); foreach($d in @("data","documents","reports")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt",".csv",".tsv",".ps1") -and $_.Name -match "intake|data|input|inbox|import|staging|source|raw|sheet|csv|tsv|open|api|collector|ingest" } | Sort-Object LastWriteTime -Descending | Select-Object -First 120 | ForEach-Object { $kind="DATA_FILE"; if($_.Name -match "source|raw|input|inbox|fuente"){$kind="SOURCE"} elseif($_.Name -match "staging|STG|stage"){$kind="STAGING"} elseif($_.Name -match "import|importacion|ingest"){$kind="IMPORT"} elseif($_.Name -match "sheet|sheets|csv|tsv"){$kind="SHEET"} elseif($_.Name -match "api|open|collector"){$kind="API"}; $IntakeFiles += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length;kind=$kind} } } }
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 10 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$SourceCount=($IntakeFiles | Where-Object { $_.kind -eq "SOURCE" }).Count
$StagingCount=($IntakeFiles | Where-Object { $_.kind -eq "STAGING" }).Count
$ImportCount=($IntakeFiles | Where-Object { $_.kind -eq "IMPORT" }).Count
$SheetCount=($IntakeFiles | Where-Object { $_.kind -eq "SHEET" }).Count
$ApiCount=($IntakeFiles | Where-Object { $_.kind -eq "API" }).Count
$View=[ordered]@{screen="OPERATOR_V1_DATA_INTAKE";updated_at=(Get-Date).ToString("s");purpose="Pantalla V1 para operar entrada de datos bajo gobierno V2.";git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=$TreeClean;status_short=$Status.Stdout};summary=[ordered]@{intake_dirs_count=$IntakeDirs.Count;intake_files_count=$IntakeFiles.Count;source_count=$SourceCount;staging_count=$StagingCount;import_count=$ImportCount;sheet_count=$SheetCount;api_count=$ApiCount;reports_recent_count=$Reports.Count;next_human_action="VALIDAR_PANTALLA_DATA_INTAKE_V1_Y_PREPARAR_GATE_LAUNCHER"};intake_dirs=$IntakeDirs;intake_files=$IntakeFiles;reports_recent=$Reports;v2_governance=@("6 Estado vivo V2","7 Siguiente accion V2","8 Panel control V2","9 Close & Sync V2");blocked_actions=@("worker_real","api_externa","navegador","clipboard","delete_files","push_auto","fetch_auto","merge_auto","importar_datos_sin_gate","modificar_staging_sin_gate","transformar_datos_sin_gate");next="E04_GATE_LAUNCHER_INTEGRATION_DATA_INTAKE"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / DATA INTAKE ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "RESUMEN DE ENTRADA" Cyan
W ("Directorios intake: "+$View.summary.intake_dirs_count) Green
W ("Archivos intake: "+$View.summary.intake_files_count) Green
W ("Fuentes: "+$View.summary.source_count+" | Staging: "+$View.summary.staging_count+" | Imports: "+$View.summary.import_count) Gray
W ("Sheets/CSV/TSV: "+$View.summary.sheet_count+" | API/Open: "+$View.summary.api_count+" | Reports recientes: "+$View.summary.reports_recent_count) Gray
W ""
W "GIT" Cyan
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "DIRECTORIOS DATA INTAKE" Cyan
if($View.intake_dirs.Count -eq 0){W " - sin directorios candidatos" DarkYellow}else{$View.intake_dirs | Select-Object -First 14 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
W ""
W "ARCHIVOS DE DATOS" Cyan
if($View.intake_files.Count -eq 0){W " - sin archivos candidatos" DarkYellow}else{$View.intake_files | Select-Object -First 10 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
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
