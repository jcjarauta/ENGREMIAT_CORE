param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Router=Join-Path $PSScriptRoot "eng-router.ps1"
$StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
function Set-BootGlobalKeepContext{
  $s=Get-State
  $s.mode="global"
  $s.active_module=""
  $s.active_module_vault=""
  if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
    $s.active_master_vault=""
  } else {
    $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
  }
  $s.next="global"
  $s.last_command="boot-global-keep-context"
  Save-State $s
}
function Get-Level{
  $s=Get-State
  if($s -and $s.PSObject.Properties.Name -contains "mode"){
    if([string]$s.mode -eq "module"){return "MODULE"}
    if([string]$s.mode -eq "project"){return "PROJECT"}
    if([string]$s.mode -eq "global"){return "GLOBAL"}
  }
  if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
  if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
  return "GLOBAL"
}
function Show-LocationBar{
  $s=Get-State
  $level=Get-Level
  $projectPath=[string]$s.active_project
  $moduleName=[string]$s.active_module
  $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
  $moduleLabel=if($moduleName){$moduleName}else{"-"}
  $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
  L "UBICACION" DarkCyan
  L (" Nivel:    "+$level) DarkCyan
  L (" Proyecto: "+$projectName) DarkCyan
  L (" Modulo:   "+$moduleLabel) DarkCyan
  L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
  L ""
}
function Show-ProjectModulesInline{
  $s=Get-State
  if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
  $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
  L "MODULOS" Cyan
  if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
  $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
  if($mods.Count -eq 0){L " sin modulos" Yellow;return}
  $i=1
  foreach($m in $mods){
    $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
    $status="NO_JSON";$lib=""
    if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
    $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
    L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
    $i++
  }
  L ""
}
function Show-Menu{
  $level=Get-Level
  if($level -eq "GLOBAL"){
    L "GLOBAL" Cyan
    L " [1] Abrir proyecto     p" Green
    L " [2] Nuevo proyecto     n" Green
    L " [3] Ver proyectos" Green
    L " [4] Estado compacto    e" Green
    W " [10] Screen normalizer adapter" Cyan
    L " [q] Salir" Yellow
  } elseif($level -eq "PROJECT"){
    L "PROYECTO" Cyan
    Show-ProjectModulesInline
    L "ACCIONES" Cyan
    L " [1] Entrar en modulo   m" Green
    L " [2] Crear modulo       n" Green
    L " [3] Biblioteca modulos b" Green
    L " [4] Revisar proyecto   r" Green
    L " [a] Atras" Yellow
  } else {
    L "MODULO" Cyan
    L " [1] Contrato           c" Green
    L " [2] Tareas             t" Green
    L " [3] Evidencias         ev" Green
    L " [4] Gates              g" Green
    L " [5] Smoke              s" Green
    L " [6] Editar artefacto   ed" Green
    L " [7] Definir objetivo   o" Green
    L " [8] Cerrar modulo      cm" Green
    L " [9] Promover biblioteca pb" Green
    L " [a] Atras" Yellow
  }
  L ""
  L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray
  L ""
}
function Refresh-Screen{
  Clear-Host
  L "ENGREMIAT TERMINAL OPERATOR" Cyan
  L ("Workspace: "+$Root) Cyan
  L "Sistema: HEALTHY" Green
  L ""
  Show-LocationBar
  Show-Menu
}
function Normalize-Command($raw){
  $x=([string]$raw).Trim().ToLowerInvariant()
  $level=Get-Level
  if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  if($x -in @("?","ayuda")){return "ayuda"}
  if($x -in @("q","salir","exit")){return "salir"}
  if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  if($level -eq "GLOBAL"){
    if($x -in @("1","p")){return "abrir-proyecto"}
    if($x -in @("2","n")){return "nuevo-proyecto"}
    if($x -eq "3"){return "proyectos"}
    if($x -in @("4","e")){return "estado"}
  } elseif($level -eq "PROJECT"){
    if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
    if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
    if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
    if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  } else {
    if($x -in @("1","c")){return "contrato"}
    if($x -in @("2","t")){return "tareas"}
    if($x -in @("3","ev","e")){return "evidencias"}
    if($x -in @("4","g")){return "gates"}
    if($x -in @("5","s")){return "preparar-smoke"}
    if($x -in @("6","ed","editar")){return "editar"}
    if($x -in @("7","o","objetivo")){return "objetivo"}
    if($x -in @("8","cm","cerrar","cerrar-modulo")){return "cerrar-modulo"}
    if($x -in @("9","pb","promover","promover-biblioteca")){return "promover"}
  }
  return $x
}
function Go-Back{
  $level=Get-Level
  $s=Get-State
  if($level -eq "MODULE"){
    $s.mode="project"
    $s.active_module=""
    $s.active_module_vault=""
    $s.next="proyecto"
    Save-State $s
    return
  }
  if($level -eq "PROJECT"){
    $s.mode="global"
    $s.active_module=""
    $s.active_module_vault=""
    $s.next="global"
    Save-State $s
    return
  }
}
function Show-Help{
  L "AYUDA" Cyan
  L "Enter/refrescar/f5 redibuja pantalla." Gray
  L "a/b/atras vuelve al nivel anterior." Gray
  L "q sale desde GLOBAL." Gray
}
Set-BootGlobalKeepContext
while($true){
  Refresh-Screen
  $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  
if($cmd -in @("m","mant","mantenimiento")){
    Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
    continue
  }
  # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  if($cmd -eq "__refresh__"){continue}
  if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  if($cmd -eq "atras"){Go-Back;continue}
  & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
}

# ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
# Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
# Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
# Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
# ENGREMIAT_RUNTIME_UI_INTEGRATION_END

# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
function Invoke-EngremiatHumanMaintenanceCard {
  param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
}
# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
# Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
# ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
# ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END

# ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  Write-Host ""
  Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
Ruta: INICIO > Pantalla actual
Rol: operacion guiada del sistema
Principio: contexto visible | acciones claras | mantenimiento humano disponible
  Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  $title=Read-Host "Titulo breve"
  if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  if($dimension -notin $allowedDimensions){$dimension="other"}
  $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  $severity=$severity.ToUpperInvariant()
  if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  $observation=Read-Host "Observacion"
  if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  $suggested=Read-Host "Accion sugerida"
  if ($suggested -eq '10') {
    $adapter = Join-Path $PSScriptRoot "screen-normalizer-general-launcher-adapter.ps1"
    if (Test-Path $adapter) {
      & powershell -NoProfile -ExecutionPolicy Bypass -File $adapter
    } else {
      Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow
      Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
    }
    return
  }
  if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  if($title.Length -gt 120){$title=$title.Substring(0,120)}
  if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
}
# ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END


