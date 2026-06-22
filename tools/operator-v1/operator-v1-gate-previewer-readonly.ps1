param([string]$GateId="sample_gate",[string]$Screen="OPERATOR_V1_PROJECTS",[string]$ActionId="abrir_carpeta_proyecto",[string]$Title="Gate preview readonly",[string]$Risk="MEDIUM",[string]$TargetPath="PENDING_SELECTION",[string]$CommandPreview="NO_COMMAND_YET_PREVIEW_ONLY",[string]$AuthorizationPhrase="",[switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
if([string]::IsNullOrWhiteSpace($AuthorizationPhrase)){ $AuthorizationPhrase=("AUTORIZO_"+$GateId.ToUpper()+"_SINGLE_EXECUTION") }
$Root=(Get-Location).Path
$SafePath=""
$Exists=$false
$InsideRoot=$false
if(-not [string]::IsNullOrWhiteSpace($TargetPath) -and $TargetPath -ne "PENDING_SELECTION"){ $candidate=$TargetPath; if(-not [System.IO.Path]::IsPathRooted($candidate)){ $candidate=Join-Path $Root $candidate }; $full=[System.IO.Path]::GetFullPath($candidate); $SafePath=$full; $Exists=Test-Path $full; $InsideRoot=$full.StartsWith($Root,[System.StringComparison]::OrdinalIgnoreCase) } else { $SafePath=$TargetPath }
$Gate=[ordered]@{screen="OPERATOR_V1_GATE_PREVIEWER_READONLY";updated_at=(Get-Date).ToString("s");gate=[ordered]@{gate_id=$GateId;source_screen=$Screen;action_id=$ActionId;title=$Title;risk=$Risk;scope="PREPARE_ONLY_NO_EXECUTION";target_path=$SafePath;target_exists=$Exists;target_inside_root=$InsideRoot;command_preview=$CommandPreview;requires_human_authorization=$true;authorization_phrase=$AuthorizationPhrase;rollback="No aplica en preview; rollback especifico obligatorio antes de ejecucion real.";validation="Preview generado sin ejecutar accion real.";blocked_by_default=$true;status="PENDING_HUMAN_AUTHORIZATION";expires_at=(Get-Date).AddHours(2).ToString("s")};policy=[ordered]@{mode="PREPARE_ONLY";real_execution=$false;external_open=$false;write=$false;delete=$false;clipboard=$false;browser=$false;network=$false;single_execution_only=$true};blocked_actions=@("execute_command","open_external","modify_file","delete_files","clipboard","browser","network","worker_real","api_external","push","fetch","merge");next="RETURN_TO_CALLER"}
if($Json){$Gate|ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / GATE PREVIEW READONLY ====" Cyan
W ("Gate:   "+$Gate.gate.gate_id) Gray
W ("Screen: "+$Gate.gate.source_screen) Gray
W ("Action: "+$Gate.gate.action_id) Gray
W ("Risk:   "+$Gate.gate.risk) Yellow
W ""
W "ALCANCE" Cyan
W ("Target: "+$Gate.gate.target_path) Gray
W ("Existe: "+$Gate.gate.target_exists) Gray
W ("Dentro de root: "+$Gate.gate.target_inside_root) Gray
W ""
W "COMANDO PREVIEW" Cyan
W $Gate.gate.command_preview DarkYellow
W ""
W "AUTORIZACION REQUERIDA" Cyan
W $Gate.gate.authorization_phrase Magenta
W ""
W "POLITICA" Cyan
W "Mode: PREPARE_ONLY | Real execution: False | Write: False | Delete: False" Green
W ""
W "ACCIONES BLOQUEADAS" Cyan
$Gate.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
