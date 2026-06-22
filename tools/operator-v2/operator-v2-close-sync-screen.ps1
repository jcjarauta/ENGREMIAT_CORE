param([switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
function G($a){$out="$env:TEMP\eng_close_sync_git_out.txt";$err="$env:TEMP\eng_close_sync_git_err.txt";$p=Start-Process cmd.exe -ArgumentList ("/c git "+$a) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $out -RedirectStandardError $err;[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS (Get-Content $out -Raw -ErrorAction SilentlyContinue));Stderr=(TS (Get-Content $err -Raw -ErrorAction SilentlyContinue))}}
$Root=(Get-Location).Path
$Head=G "rev-parse --short HEAD"
$Branch=G "branch --show-current"
$Sync=G "rev-list --left-right --count origin/main...HEAD"
$Status=G "status --short"
$Log=G "log --oneline -8"
$Parts=($Sync.Stdout -split "\s+") | Where-Object { $_ -ne "" }
$Behind=0; $Ahead=0; if($Parts.Count -ge 2){$Behind=[int]$Parts[0];$Ahead=[int]$Parts[1]}
$TreeClean=[string]::IsNullOrWhiteSpace($Status.Stdout)
$Decision="PAUSE_NO_PUSH"
if($TreeClean -and $Ahead -gt 0 -and $Behind -eq 0){$Decision="READY_FOR_PUSH_GATE_IF_HUMAN_APPROVES"}
if(-not $TreeClean){$Decision="CLEAN_TREE_BEFORE_PUSH_GATE"}
if($Behind -gt 0){$Decision="NO_PUSH_REVIEW_REMOTE_DIVERGENCE"}
$Risk="LOW"; if($Ahead -gt 0){$Risk="MEDIUM"}; if($Behind -gt 0 -or -not $TreeClean){$Risk="MEDIUM"}
$Reports=@(); if(Test-Path (Join-Path $Root "reports")){ Get-ChildItem (Join-Path $Root "reports") -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -in @(".json",".md",".txt") } | Sort-Object LastWriteTime -Descending | Select-Object -First 10 | ForEach-Object { $Reports += [ordered]@{path=$_.FullName.Replace($Root+"\","");modified=$_.LastWriteTime.ToString("s");bytes=$_.Length} } }
$View=[ordered]@{screen="OPERATOR_V2_CLOSE_AND_SYNC";updated_at=(Get-Date).ToString("s");git=[ordered]@{branch=$Branch.Stdout;head=$Head.Stdout;rev_sync=$Sync.Stdout;behind=$Behind;ahead=$Ahead;tree_clean=$TreeClean;status_short=$Status.Stdout;last_commits=$Log.Stdout};decision=$Decision;risk=$Risk;reports_recent=$Reports;reports_recent_count=$Reports.Count;allowed_options=@("pausar_sin_push","preparar_gate_push","validar_arbol_limpio","ver_ultimos_commits");blocked_options=@("push_sin_gate","fetch_automatico","merge_automatico","pull_automatico","delete_files","worker_real","api_externa","navegador","clipboard");push_authorization_phrase="AUTORIZO_PUSH_FINAL_OPERADOR_V2_CLOSE_AND_SYNC_MAIN_A_ORIGIN_MAIN";push_executed=$false;fetch_executed=$false;merge_executed=$false;delete_files=$false;next="E04_GATE_LAUNCHER_INTEGRATION_CLOSE_SYNC_SCREEN"}
if($Json){$View | ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V2 / CLOSE & SYNC ====" Cyan
W ("Actualizado: "+$View.updated_at) DarkGray
W ""
W "GIT" Cyan
W ("Branch:     "+$View.git.branch) Gray
W ("Head:       "+$View.git.head) Gray
W ("Rev sync:   "+$View.git.rev_sync) Gray
W ("Behind:     "+$View.git.behind) Gray
W ("Ahead:      "+$View.git.ahead) Yellow
W ("Tree clean: "+$View.git.tree_clean) Gray
W ""
W ("DECISION: "+$View.decision) Magenta
W ("RIESGO:   "+$View.risk) Yellow
W ""
W "OPCIONES PERMITIDAS" Cyan
$View.allowed_options | ForEach-Object { W (" - "+$_) Gray }
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.blocked_options | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "REPORTS RECIENTES" Cyan
if($View.reports_recent_count -eq 0){ W " - sin reports detectados" DarkYellow } else { $View.reports_recent | Select-Object -First 6 | ForEach-Object { W (" - "+$_.path) Gray } }
W ""
W "AUTORIZACION PUSH" Cyan
W $View.push_authorization_phrase Yellow
W ""
W "SEGURIDAD" Cyan
W "push_executed=False | fetch_executed=False | merge_executed=False | delete_files=False" DarkYellow
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
