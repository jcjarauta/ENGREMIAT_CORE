Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_project)){throw "no_active_project"}
$project=[string]$s.active_project
$modsDir=Join-Path $project "MODULOS"
L "MODULOS DEL PROYECTO" Cyan
L ("project="+$project) DarkCyan
if(!(Test-Path -LiteralPath $modsDir)){L "WARN sin carpeta MODULOS" Yellow;exit}
$mods=Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Sort-Object Name
if(@($mods).Count -eq 0){L "WARN no hay modulos en este proyecto" Yellow;exit}
$i=1;foreach($m in $mods){$vault=Join-Path $m.FullName "BOVEDA_MODULO";$mjPath=Join-Path $vault "module.json";$status="UNKNOWN";$objective="";$source="";if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$objective=[string]$mj.objective;$source=[string]$mj.library_status}catch{}};L (" ["+$i+"] "+$m.Name+"  status="+$status+"  library="+$source) Green;if(![string]::IsNullOrWhiteSpace($objective)){L ("     objetivo="+$objective) DarkGray};L ("     path="+$m.FullName) DarkGray;$i++}
L "NEXT para entrar en uno: usa entrar-modulo / menu proyecto opcion 1" Magenta

