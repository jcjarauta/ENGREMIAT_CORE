param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_v1_memory_docs_git_out.txt";$err="$env:TEMP\eng_v1_memory_docs_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$DocDirs=@(); foreach($d in @("documents","data","reports","docs","memory","backups")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Directory -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 80 | ForEach-Object { if($_.Name -match "memory|memoria|doc|document|operator|state|knowledge|index|manual|evidence|audit|contract"){ $kind="DOC_HINT"; if($_.Name -match "index|INDEX"){$kind="INDEX_HINT"} elseif($_.Name -match "contract|CONTRACT|contrato"){$kind="CONTRACT_HINT"} elseif($_.Name -match "state|registry|latest|status"){$kind="STATE_HINT"} elseif($_.Name -match "manual|guide|docs|document"){$kind="MANUAL_HINT"} elseif($_.Name -match "evidence|audit|report|close"){$kind="EVIDENCE_HINT"}; $DocDirs += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");kind=$kind} } } } }
$DocFiles=@(); foreach($d in @("documents","data","reports")){ $full=Join-Path $Root $d; if(Test-Path $full){ Get-ChildItem $full -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".md",".json",".txt",".csv",".tsv") -and $_.Name -match "memory|memoria|doc|document|index|contract|state|manual|evidence|audit|close|next|latest|registry" } | Sort-Object LastWriteTime -Descending | Select-Object -First 120 | ForEach-Object { $kind="DOC_FILE"; if($_.Name -match "index|INDEX"){$kind="INDEX"} elseif($_.Name -match "contract|CONTRACT|contrato"){$kind="CONTRACT"} elseif($_.Name -match "state|registry|latest|status"){$kind="STATE"} elseif($_.Name -match "manual|guide|docs|document"){$kind="MANUAL"} elseif($_.Name -match "evidence|audit|report|close"){$kind="EVIDENCE"}; $DocFiles += [ordered]@{name=$_.Name;path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length;kind=$kind} } } }
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 10 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$IndexCount=($DocFiles | Where-Object { $_.kind -eq "INDEX" }).Count
$ContractCount=($DocFiles | Where-Object { $_.kind -eq "CONTRACT" }).Count
$EvidenceCount=($DocFiles | Where-Object { $_.kind -eq "EVIDENCE" }).Count
$StateCount=($DocFiles | Where-Object { $_.kind -eq "STATE" }).Count
$ManualCount=($DocFiles | Where-Object { $_.kind -eq "MANUAL" }).Count
$View=[ordered]@{screen="OPERATOR_V1_MEMORY_DOCS";updated_at=(Get-Date).ToString("s");purpose="Pantalla V1 para operar memoria y documentacion bajo gobierno V2.";git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;tree_clean=$TreeClean;status_short=$Status.Stdout};summary=[ordered]@{doc_dirs_count=$DocDirs.Count;doc_files_count=$DocFiles.Count;index_count=$IndexCount;contract_count=$ContractCount;evidence_count=$EvidenceCount;state_count=$StateCount;manual_count=$ManualCount;reports_recent_count=$Reports.Count;next_human_action="VALIDAR_PANTALLA_MEMORIA_DOCUMENTACION_V1_Y_PREPARAR_GATE_LAUNCHER"};doc_dirs=$DocDirs;doc_files=$DocFiles;reports_recent=$Reports;v2_governance=@("6 Estado vivo V2","7 Siguiente accion V2","8 Panel control V2","9 Close & Sync V2");blocked_actions=@("worker_real","api_externa","navegador","clipboard","delete_files","push_auto","fetch_auto","merge_auto","editar_memoria_sin_gate","reestructurar_documentos_sin_gate");next="E04_GATE_LAUNCHER_INTEGRATION_MEMORY_DOCS"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / MEMORIA Y DOCUMENTACION ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "RESUMEN DOCUMENTAL" Cyan
W ("Directorios documentales: "+$View.summary.doc_dirs_count) Green
W ("Archivos clave: "+$View.summary.doc_files_count) Green
W ("Indices: "+$View.summary.index_count+" | Contratos: "+$View.summary.contract_count+" | Evidencias: "+$View.summary.evidence_count) Gray
W ("Estado: "+$View.summary.state_count+" | Manuales/docs: "+$View.summary.manual_count+" | Reports recientes: "+$View.summary.reports_recent_count) Gray
W ""
W "GIT" Cyan
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W "DIRECTORIOS DOCUMENTALES" Cyan
if($View.doc_dirs.Count -eq 0){W " - sin directorios candidatos" DarkYellow}else{$View.doc_dirs | Select-Object -First 14 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
W ""
W "ARCHIVOS CLAVE" Cyan
if($View.doc_files.Count -eq 0){W " - sin archivos candidatos" DarkYellow}else{$View.doc_files | Select-Object -First 10 | ForEach-Object { W (" - ["+$_.kind+"] "+$_.path) Gray }}
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
