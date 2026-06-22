param([string]$Title="Detalle readonly",[string]$Kind="ITEM",[string]$Path="",[string]$JsonPath="",[switch]$Json)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W($m,$c="Gray"){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function TS($v){if($null -eq $v){return ""};return (($v|Out-String).Trim())}
$Root=(Get-Location).Path
$SafePath=""
$Exists=$false
$IsInsideRoot=$false
$Meta=[ordered]@{}
if(-not [string]::IsNullOrWhiteSpace($Path)){ $candidate=$Path; if(-not [System.IO.Path]::IsPathRooted($candidate)){ $candidate=Join-Path $Root $candidate }; $full=[System.IO.Path]::GetFullPath($candidate); $SafePath=$full; $Exists=Test-Path $full; $IsInsideRoot=$full.StartsWith($Root,[System.StringComparison]::OrdinalIgnoreCase); if($Exists){ $item=Get-Item $full -ErrorAction Stop; $Meta=[ordered]@{name=$item.Name;full_name=$item.FullName;relative_path=$item.FullName.Replace($Root+"\","");exists=$true;is_container=$item.PSIsContainer;length=if($item.PSIsContainer){0}else{$item.Length};last_write_time=$item.LastWriteTime.ToString("s");extension=if($item.PSIsContainer){""}else{$item.Extension}} } }
$JsonPreview=$null
if(-not [string]::IsNullOrWhiteSpace($JsonPath)){ $jp=$JsonPath; if(-not [System.IO.Path]::IsPathRooted($jp)){ $jp=Join-Path $Root $jp }; if((Test-Path $jp) -and ([System.IO.Path]::GetFullPath($jp)).StartsWith($Root,[System.StringComparison]::OrdinalIgnoreCase)){ try{ $JsonPreview=Get-Content $jp -Raw | ConvertFrom-Json }catch{ $JsonPreview=[ordered]@{json_error=$_.Exception.Message} } } }
$View=[ordered]@{screen="OPERATOR_V1_DETAIL_VIEWER_READONLY";updated_at=(Get-Date).ToString("s");title=$Title;kind=$Kind;path=$SafePath;path_exists=$Exists;path_inside_root=$IsInsideRoot;metadata=$Meta;json_preview_available=($null -ne $JsonPreview);json_preview=$JsonPreview;policy=[ordered]@{mode="READONLY";open_external=$false;execute=$false;modify=$false;delete=$false;clipboard=$false;network=$false;requires_gate_for_external_open=$true};blocked_actions=@("abrir_archivo_externo_sin_gate","ejecutar_script","modificar_archivo","delete_files","clipboard","navegador","worker_real","api_externa");next="RETURN_TO_CALLER"}
if($Json){$View|ConvertTo-Json -Depth 8; return}
W "==== OPERADOR V1 / DETALLE READONLY ====" Cyan
W ("Titulo: "+$View.title) Gray
W ("Tipo:   "+$View.kind) Gray
W ""
W "OBJETO" Cyan
W ("Path: "+$View.path) Gray
W ("Existe: "+$View.path_exists) Gray
W ("Dentro de root: "+$View.path_inside_root) Gray
if($View.metadata.Count -gt 0){ W ("Nombre: "+$View.metadata.name) Gray; W ("Relativo: "+$View.metadata.relative_path) Gray; W ("Modificado: "+$View.metadata.last_write_time) Gray; W ("Bytes: "+$View.metadata.length) Gray }
W ""
W "POLITICA" Cyan
W "Modo: READONLY" Green
W "Abrir externo: False | Ejecutar: False | Modificar: False | Delete: False" DarkYellow
W ""
W "ACCIONES BLOQUEADAS" Cyan
$View.blocked_actions | ForEach-Object { W (" - "+$_) DarkYellow }
W ""
W "Enter = volver" DarkGray
Read-Host "Enter" | Out-Null
