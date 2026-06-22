param([string]$Command="abrir-proyecto",[string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Desktop-Path{return [Environment]::GetFolderPath("Desktop")}
function Ensure-State{
  if(!(Test-Path -LiteralPath $StateFile)){
    New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null
    $desktop=Desktop-Path
    [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
  }
}
function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}
function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
function Resolve-ParentPath([string]$InputPath,[string]$DefaultParent){
  $p=$InputPath.Trim()
  if([string]::IsNullOrWhiteSpace($p)){$p=$DefaultParent}
  $p=[Environment]::ExpandEnvironmentVariables($p)
  try{return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}catch{New-Item -ItemType Directory -Force -Path $p|Out-Null;return (Resolve-Path -LiteralPath $p).Path}
}
function Get-ProjectRoots{
  $s=Get-State
  $roots=@()
  $desktop=Desktop-Path
  if($desktop){$roots+=$desktop}
  if($s.last_project_parent){$roots+=[string]$s.last_project_parent}
  if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$roots+=(Split-Path ([string]$s.active_project) -Parent)}
  if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){foreach($r in @($s.project_roots)){if([string]$r){$roots+=[string]$r}}}
  return @($roots|Where-Object{$_}|Sort-Object -Unique)
}
function Get-Projects{
  $items=@()
  foreach($r in Get-ProjectRoots){
    if(Test-Path -LiteralPath $r){$items+=@(Get-ChildItem -LiteralPath $r -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"})}
  }
  $s=Get-State
  if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$items+=@(Get-Item -LiteralPath ([string]$s.active_project))}
  return @($items|Sort-Object FullName -Unique|Sort-Object LastWriteTime -Descending)
}
function Set-Project-ParentMemory([string]$Parent){
  $s=Get-State
  $roots=@()
  if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){$roots+=@($s.project_roots)}
  $roots+=$Parent
  $s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue $Parent
  $s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($roots|Where-Object{$_}|Sort-Object -Unique)
  Save-State $s
}
function New-Project{
  param([string]$Name)
  $s=Get-State
  if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"}
  $safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-")
  if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"}
  $desktop=Desktop-Path
  $remembered=$desktop
  if($s.last_project_parent -and (Test-Path -LiteralPath ([string]$s.last_project_parent))){$remembered=[string]$s.last_project_parent}
  $templateSource=""
  if($s.PSObject.Properties.Name -contains "current_template_source" -and [string]$s.current_template_source -and (Test-Path -LiteralPath ([string]$s.current_template_source))){$templateSource=[string]$s.current_template_source}
  while($true){
    Clear-Host
    L "CREAR PROYECTO DESDE PLANTILLA MAESTRA ORIGINAL" Cyan
    L ("Nombre:           "+$safe) Gray
    L ("Ruta recordada:   "+$remembered) Green
    L ("Plantilla origen: "+$(if($templateSource){$templateSource}else{"NO_CONFIGURADA"})) Yellow
    L ""
    if([string]::IsNullOrWhiteSpace($templateSource)){throw "current_template_source_not_configured"}
    L "Indica carpeta BASE donde se creara la carpeta ENGREMIAT_PROJECT_*." DarkCyan
    L "Enter = usar ruta recordada | . = workspace actual | escritorio = Escritorio | ruta absoluta = usar esa ruta" DarkGray
    L ""
    $parentRaw=(Read-Host "Carpeta base").Trim()
    if([string]::IsNullOrWhiteSpace($parentRaw)){$parentRaw=$remembered}
    if($parentRaw -eq "."){$parentRaw=$Root}
    if($parentRaw.ToLowerInvariant() -eq "escritorio"){$parentRaw=$desktop}
    $parentRaw=[Environment]::ExpandEnvironmentVariables($parentRaw)
    if(![System.IO.Path]::IsPathRooted($parentRaw)){$parentRaw=Join-Path $Root $parentRaw}
    if(!(Test-Path -LiteralPath $parentRaw)){L ("WARN ruta no existe, se creara: "+$parentRaw) Yellow;New-Item -ItemType Directory -Force -Path $parentRaw|Out-Null}
    $parent=(Resolve-Path -LiteralPath $parentRaw).Path
    $projectName="ENGREMIAT_PROJECT_"+$safe+"_"+(Get-Date -Format "yyyyMMdd-HHmmss")
    $p=Join-Path $parent $projectName
    L ""
    L "DESTINO FINAL DEL PROYECTO" Cyan
    L $p Green
    L ""
    $ok=(Read-Host "Crear aqui usando plantilla maestra original? Enter/s = si | n = cambiar ruta").Trim().ToLowerInvariant()
    if($ok -in @("n","no","cambiar","c")){continue}
    $vault=Join-Path $p "BOVEDA_PROYECTO"
    $mods=Join-Path $p "MODULOS"
    $archivos=Join-Path $p "ARCHIVOS"
    $plantillas=Join-Path $archivos "PLANTILLAS"
    $dest=Join-Path $plantillas "OBSIDIAN_REAL_TEMPLATE_PACKAGE"
    $sourceName=Split-Path $templateSource -Leaf
    $destVault=Join-Path $dest $sourceName
    New-Item -ItemType Directory -Force -Path $p,$vault,$mods,$archivos,$plantillas,$dest|Out-Null
    Copy-Item -LiteralPath $templateSource -Destination $dest -Recurse -Force
    $copiedFiles=@(Get-ChildItem -LiteralPath $destVault -Recurse -File -ErrorAction SilentlyContinue)
    if($copiedFiles.Count -lt 10){throw "template_copy_incomplete files="+$copiedFiles.Count+" dest="+$destVault}
    $startModule=Join-Path $mods "MODULE_inicio"
    $startVault=Join-Path $startModule "BOVEDA_MODULO"
    New-Item -ItemType Directory -Force -Path $startVault,(Join-Path $startVault "00_CONTROL")|Out-Null
    $moduleJson=Join-Path $startVault "00_CONTROL\module.json"
    if(!(Test-Path -LiteralPath $moduleJson)){[ordered]@{module="MODULE_inicio";title="Inicio";lifecycle="ACTIVE_IN_PROJECT";library_status="FROM_ORIGINAL_MASTER_TEMPLATE";objective="Arranque desde plantilla maestra original";project_path=$p;template_source=$templateSource;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $moduleJson -Encoding UTF8}
    $manifest=Join-Path $plantillas "CURRENT_TEMPLATE_SOURCE.json"
    [ordered]@{template_source_kind="OBSIDIAN_REAL_TEMPLATE_PACKAGE";template_source=$templateSource;project=$p;project_name=$projectName;destination=$destVault;copied_files=$copiedFiles.Count;selected_reason="official_original_master_template";created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $manifest -Encoding UTF8
    New-Item -ItemType Directory -Force -Path (Join-Path $vault "00_CONTROL")|Out-Null
    Copy-Item -LiteralPath $manifest -Destination (Join-Path $vault "00_CONTROL\template-source.json") -Force
    [ordered]@{project=$projectName;root=$p;vault=$vault;modules_dir=$mods;template_source=$templateSource;visible_templates=$plantillas;status="ACTIVE_PROJECT";created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath (Join-Path $vault "00_CONTROL\project.json") -Encoding UTF8
    $required=@($destVault,$manifest,(Join-Path $vault "00_CONTROL\template-source.json"),(Join-Path $vault "00_CONTROL\project.json"),$moduleJson)
    $missing=@($required|Where-Object{!(Test-Path -LiteralPath $_)})
    if($missing.Count -gt 0){throw "new_project_from_original_template_missing="+($missing -join ";")}
    $s=Get-State
    $roots=@()
    if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){$roots+=@($s.project_roots)}
    $roots+=$parent
    $s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue $parent
    $s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($roots|Where-Object{$_}|Sort-Object -Unique)
    $s|Add-Member -Force -NotePropertyName current_template_source -NotePropertyValue $templateSource
    Save-State $s
    L ""
    L "OK proyecto creado desde plantilla maestra original:" Green
    L (" Proyecto: "+$p) Green
    L (" Plantilla copiada: "+$destVault) Green
    L (" Archivos copiados: "+$copiedFiles.Count) Green
    Start-Sleep -Milliseconds 1200
    return $p
  }
}
function Set-Project-State([string]$Project){$s=Get-State;$s.mode="project";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="abrir-proyecto";$s.next="proyecto";Save-State $s}
function Set-Module-State([string]$Project,[string]$ModulePath,[string]$ModuleName,[string]$LastCommand){$s=Get-State;$s.mode="module";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module=$ModuleName;$s.active_module_vault=Join-Path $ModulePath "BOVEDA_MODULO";$s.last_command=$LastCommand;$s.next="modulo";Save-State $s}
function Back-To-Global{$s=Get-State;$s.mode="global";$s.active_module="";$s.active_module_vault="";$s.last_command="back-global";$s.next="global";Save-State $s}
function Clean-StaleActiveProject{
  $s=Get-State
  $active=[string]$s.active_project
  if($active -and !(Test-Path -LiteralPath $active)){
    L ("WARN active_project borrado, limpiando estado: "+$active) Yellow
    $s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="clean-stale-active-project";Save-State $s
    return ""
  }
  return $active
}
function Select-Project {
  $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  if(Test-Path -LiteralPath $manager){
    & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
    return
  }
  Write-Host ""
  Write-Host "==== NO_GO ====" -ForegroundColor Yellow
  Write-Host "No se encuentra el gestor de proyectos: $manager" -ForegroundColor Yellow
  Read-Host "Enter para volver"
}
function Show-Projects{
  while($true){
    Clear-Host
    L "PROYECTOS" Cyan
    $active=Clean-StaleActiveProject
    $projects=@(Get-Projects)
    if($projects.Count -eq 0){L "sin proyectos detectados" Yellow}else{
      $i=1
      foreach($p in $projects){
        $kind=if($active -and ([string]$p.FullName -eq $active)){"ACTIVO"}else{"HISTORICO"}
        $color=if($kind -eq "ACTIVO"){"Green"}else{"DarkGray"}
        L (" ["+$i+"] "+$p.Name+"  "+$p.LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  "+$kind) $color
        $i++
      }
    }
    L " [b] Atras" Yellow
    L ""
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
    L ""
    $sel=(Read-Host "ENGREMIAT").Trim().ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
    if($sel -in @("b","a","atras","atrás","volver","back","0")){return}
    if(!($sel -match "^\d+$")){continue}
    $idx=[int]$sel-1
    if($idx -lt 0 -or $idx -ge $projects.Count){continue}
    Set-Project-State ([string]$projects[$idx].FullName)
    return
  }
}
function Select-Module{
  param([switch]$Create)
  $s=Get-State
  $project=[string]$s.active_project
  if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "no_active_project"}
  $modsDir=Join-Path $project "MODULOS"
  New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  if($Create){
    while($true){
      Clear-Host
      L "CREAR MODULO" Cyan
      L "Solo comandos de este paso: nombre = crear | b = atras" DarkCyan
      L " [b] Atras" Yellow
      L ""
      L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | texto = crear modulo" DarkGray
      L ""
      $name=(Read-Host "Nombre del modulo").Trim()
      $x=$name.ToLowerInvariant()
      if([string]::IsNullOrWhiteSpace($name) -or $x -in @("refrescar","refresh","f5","menu","comandos")){continue}
      if($x -in @("b","a","atras","atrás","volver","back","..","0")){return}
      $safe=($name -replace "[^a-zA-Z0-9_-]","_")
      if($safe -notlike "MODULE_*"){$safe="MODULE_"+$safe}
      $modulePath=Join-Path $modsDir $safe
      New-Item -ItemType Directory -Force -Path (Join-Path $modulePath "BOVEDA_MODULO")|Out-Null
      $mj=Join-Path $modulePath "BOVEDA_MODULO\module.json"
      if(!(Test-Path $mj)){[ordered]@{module=$safe;lifecycle="ACTIVE_IN_PROJECT";library_status="NOT_READY";objective="";created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $mj -Encoding UTF8}
      Set-Module-State $project $modulePath $safe "nuevo-modulo"
      return
    }
  }
  while($true){
    Clear-Host
    L "ENTRAR EN MODULO" Cyan
    L "Solo comandos de este paso: numero = entrar | b = atras" DarkCyan
    $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
    if($mods.Count -eq 0){L "sin modulos" Yellow}else{$i=1;foreach($m in $mods){L (" ["+$i+"] "+$m.Name) Green;$i++}}
    L " [b] Atras" Yellow
    L ""
    L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray
    L ""
    $sel=(Read-Host "Elige modulo").Trim().ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
    if($sel -in @("b","a","atras","atrás","volver","back","..","0")){return}
    if(!($sel -match "^\d+$")){continue}
    $idx=[int]$sel-1
    if($idx -lt 0 -or $idx -ge $mods.Count){continue}
    Set-Module-State $project ([string]$mods[$idx].FullName) ([string]$mods[$idx].Name) "abrir-modulo"
    return
  }
}
$cmd=$Command.Trim().ToLowerInvariant()
if($cmd -in @("open-project","project-open")){$cmd="abrir-proyecto"}elseif($cmd -in @("new-project","create-project","project-new","project-create")){$cmd="nuevo-proyecto"}elseif($cmd -in @("projects","proyectos","ver-proyectos","list-projects","project-list")){$cmd="projects"}elseif($cmd -in @("open-module","enter-module","module-open","module-enter","entrar-modulo")){$cmd="abrir-modulo"}elseif($cmd -in @("new-module","create-module","module-new","module-create","crear-modulo")){$cmd="nuevo-modulo"}
if($cmd -eq "abrir-proyecto"){Select-Project;exit}
if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;Set-Project-State $p;exit}
if($cmd -eq "projects"){Show-Projects;exit}
if($cmd -eq "abrir-modulo"){Select-Module;exit}
if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
L ("WARN comando_contexto_no_soportado="+$cmd) Yellow
exit 1


# ENGREMIAT_E02E_PROJECTS_MANAGER_ROUTE
function Invoke-EngremiatProjectsManager {
  $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  if(Test-Path -LiteralPath $manager){
    & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
    return
  }
  Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
  Read-Host "Enter para volver"
}
function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
function Show-Projects { Invoke-EngremiatProjectsManager }
function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }

