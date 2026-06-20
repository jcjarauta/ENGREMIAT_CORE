param([string]$Command="abrir-proyecto")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StateFile=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="abrir-proyecto";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
function Get-State{Ensure-State;return Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json}
function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
function Get-AllProjects{Get-ChildItem -LiteralPath ([Environment]::GetFolderPath("Desktop")) -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"}|Sort-Object LastWriteTime -Descending}
function Get-Projects{$all=@(Get-ChildItem -LiteralPath ([Environment]::GetFolderPath("Desktop")) -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"}|Sort-Object LastWriteTime -Descending);$s=Get-State;$historical=@();if($s.PSObject.Properties.Name -contains "historical_projects" -and $s.historical_projects){$historical=@($s.historical_projects|ForEach-Object{[string]$_.path})};$active=@($all|Where-Object{$historical -notcontains $_.FullName});if($active.Count -gt 0){return $active};return $all}
function New-Project{param([string]$Name);if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"};$safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-");if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"};$p=Join-Path ([Environment]::GetFolderPath("Desktop")) ("ENGREMIAT_PROJECT_"+$safe+"_"+(Get-Date -Format "yyyyMMdd-HHmmss"));New-Item -ItemType Directory -Force -Path (Join-Path $p "MODULOS")|Out-Null;New-Item -ItemType Directory -Force -Path (Join-Path $p "BOVEDA_PROYECTO")|Out-Null;return $p}
function Select-Project{
  while($true){
    Clear-Host
    L "ABRIR PROYECTO" Cyan
    L "Solo comandos de este paso: numero = entrar | n = nuevo proyecto | b = atras" DarkCyan
    $projects=@(Get-Projects)
    $i=1
    foreach($p in $projects){
      L (" ["+$i+"] Entrar: "+$p.Name+"  "+$p.LastWriteTime.ToString("yyyy-MM-dd HH:mm")) Green
      $i++
    }
    L " [n] Nuevo proyecto" Green
    L " [b] Atras" Yellow
    L "" Gray
    L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray
    L "" Gray
    $sel=(Read-Host "Elige accion").Trim().ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
    if($sel -in @("b","a","atras","atrás","volver","back","..","0")){
      $s=Get-State;$s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="abrir-proyecto-atras";Save-State $s;return
    }
    if($sel -eq "n"){
      $name=Read-Host "Nombre del proyecto"
      if([string]::IsNullOrWhiteSpace($name)){continue}
      $project=New-Project $name
    }else{
      if(!($sel -match "^\d+$")){continue}
      $idx=[int]$sel-1
      if($idx -lt 0 -or $idx -ge $projects.Count){continue}
      $project=$projects[$idx].FullName
    }
    $s=Get-State
$s.mode="project"
$s.active_project=$project
$s.active_master_vault=Join-Path $project "BOVEDA_PROYECTO"
$s.active_module=""
$s.active_module_vault=""
$s.last_command="abrir-proyecto"
$s.next="proyecto"
    Save-State $s
    return
  }
}
function Select-Module{
  param([switch]$Create)
  $s=Get-State
  $project=[string]$s.active_project
  if([string]::IsNullOrWhiteSpace($project)){throw "no_active_project"}
  $modsDir=Join-Path $project "MODULOS"
  New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  if($Create){
    while($true){
      Clear-Host
      L "CREAR MODULO" Cyan
      L "Solo comandos de este paso: nombre = crear | b = atras" DarkCyan
      L " [b] Atras" Yellow
      L "" Gray
      L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | texto = crear modulo" DarkGray
      L "" Gray
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
      $s=Get-State;$s.mode="module";$s.active_project=$project;$s.active_module=$safe;$s.active_module_vault=Join-Path $modulePath "BOVEDA_MODULO";$s.last_command="nuevo-modulo";$s.next="modulo";Save-State $s
      return
    }
  }
  while($true){
    Clear-Host
    L "ENTRAR EN MODULO" Cyan
    L "Solo comandos de este paso: numero = entrar | b = atras" DarkCyan
    $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{param([string]$Command="abrir-proyecto")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StateFile=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="abrir-proyecto";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
function Get-State{Ensure-State;return Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json}
function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
function Get-AllProjects{Get-ChildItem -LiteralPath ([Environment]::GetFolderPath("Desktop")) -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"}|Sort-Object LastWriteTime -Descending}
function Get-Projects{$all=@(Get-ChildItem -LiteralPath ([Environment]::GetFolderPath("Desktop")) -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"}|Sort-Object LastWriteTime -Descending);$s=Get-State;$historical=@();if($s.PSObject.Properties.Name -contains "historical_projects" -and $s.historical_projects){$historical=@($s.historical_projects|ForEach-Object{[string]$_.path})};$active=@($all|Where-Object{$historical -notcontains $_.FullName});if($active.Count -gt 0){return $active};return $all}
function New-Project{param([string]$Name);if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"};$safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-");if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"};$p=Join-Path ([Environment]::GetFolderPath("Desktop")) ("ENGREMIAT_PROJECT_"+$safe+"_"+(Get-Date -Format "yyyyMMdd-HHmmss"));New-Item -ItemType Directory -Force -Path (Join-Path $p "MODULOS")|Out-Null;New-Item -ItemType Directory -Force -Path (Join-Path $p "BOVEDA_PROYECTO")|Out-Null;return $p}
function Select-Project{
  while($true){
    Clear-Host
    L "ABRIR PROYECTO" Cyan
    L "Solo comandos de este paso: numero = entrar | n = nuevo proyecto | b = atras" DarkCyan
    $projects=@(Get-Projects)
    $i=1
    foreach($p in $projects){
      L (" ["+$i+"] Entrar: "+$p.Name+"  "+$p.LastWriteTime.ToString("yyyy-MM-dd HH:mm")) Green
      $i++
    }
    L " [n] Nuevo proyecto" Green
    L " [b] Atras" Yellow
    L "" Gray
    L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray
    L "" Gray
    $sel=(Read-Host "Elige accion").Trim().ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
    if($sel -in @("b","a","atras","atrás","volver","back","..","0")){
      $s=Get-State;$s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="abrir-proyecto-atras";Save-State $s;return
    }
    if($sel -eq "n"){
      $name=Read-Host "Nombre del proyecto"
      if([string]::IsNullOrWhiteSpace($name)){continue}
      $project=New-Project $name
    }else{
      if(!($sel -match "^\d+$")){continue}
      $idx=[int]$sel-1
      if($idx -lt 0 -or $idx -ge $projects.Count){continue}
      $project=$projects[$idx].FullName
    }
    $s=Get-State
$s.mode="project"
$s.active_project=$project
$s.active_master_vault=Join-Path $project "BOVEDA_PROYECTO"
$s.active_module=""
$s.active_module_vault=""
$s.last_command="abrir-proyecto"
$s.next="proyecto"
    Save-State $s
    return
  }
}
$cmd=$Command.Trim().ToLowerInvariant();if($cmd -in @("open-project","project-open")){$cmd="abrir-proyecto"}elseif($cmd -in @("new-project","create-project","project-new","project-create")){$cmd="nuevo-proyecto"}elseif($cmd -in @("open-module","enter-module","module-open","module-enter","entrar-modulo")){$cmd="abrir-modulo"}elseif($cmd -in @("new-module","create-module","module-new","module-create","crear-modulo")){$cmd="nuevo-modulo"}elseif($cmd -in @("library","open-library","import-library","library-import")){$cmd="biblioteca"}
if($cmd -eq "abrir-proyecto"){Select-Project;exit}
if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;$s=Get-State;$s.mode="project";$s.active_project=$p;$s.active_master_vault=Join-Path $p "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="nuevo-proyecto";$s.next="proyecto";Save-State $s;L ("OK active_project="+$p) Green;exit}
if($cmd -eq "abrir-modulo"){Select-Module;exit}
if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
if($cmd -eq "biblioteca"){& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-library-import.ps1");exit}
if($cmd -in @("projects","proyectos","ver-proyectos","list-projects","project-list")){
  $nav=Join-Path $PSScriptRoot "eng-navigation.ps1"
  $navRaw=Get-Content $nav -Raw
  $navBlock=[scriptblock]::Create($navRaw)
  . $navBlock
  function Draw-EngProjects {
    Eng-L "PROYECTOS" Cyan
    $s=Get-State
    $historical=@()
    if($s.PSObject.Properties.Name -contains "historical_projects" -and $s.historical_projects){$historical=@($s.historical_projects|ForEach-Object{[string]$_.path})}
    $projects=@(Get-AllProjects)
    if($projects.Count -eq 0){
      Eng-L "sin proyectos" Yellow
    }else{
      $i=1
      foreach($proj in $projects){
        $kind=if($historical -contains $proj.FullName){"HISTORICO"}else{"ACTIVO"}
        $color=if($kind -eq "HISTORICO"){"DarkGray"}else{"Green"}
        Eng-L (" ["+$i+"] "+$proj.Name+"  "+$proj.LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  "+$kind) $color
        $i++
      }
    }
    Eng-L ""
    Eng-L " [b] Atras" Yellow
  }
  Eng-InvokeScreenLoop -Draw ${function:Draw-EngProjects} | Out-Null
  $s=Get-State;$s.mode="global";$s.last_command="proyectos";$s.next="global";Save-State $s;exit
}
throw "context_command_not_supported=$Command"
.Name -ne ".obsidian"}|Sort-Object Name)
    if($mods.Count -eq 0){L "sin modulos" Yellow}else{$i=1;foreach($m in $mods){L (" ["+$i+"] "+$m.Name) Green;$i++}}
    L " [b] Atras" Yellow
    L "" Gray
    L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray
    L "" Gray
    $sel=(Read-Host "Elige modulo").Trim().ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
    if($sel -in @("b","a","atras","atrás","volver","back","..","0")){return}
    if(!($sel -match "^\d+$")){continue}
    $idx=[int]$sel-1
    if($idx -lt 0 -or $idx -ge $mods.Count){continue}
    $modulePath=$mods[$idx].FullName
$safe=$mods[$idx].Name
    $s=Get-State;$s.mode="module";$s.active_project=$project;$s.active_module=$safe;$s.active_module_vault=Join-Path $modulePath "BOVEDA_MODULO";$s.last_command="abrir-modulo";$s.next="modulo";Save-State $s
    return
  }
}

$cmd=$Command.Trim().ToLowerInvariant();if($cmd -in @("open-project","project-open")){$cmd="abrir-proyecto"}elseif($cmd -in @("new-project","create-project","project-new","project-create")){$cmd="nuevo-proyecto"}elseif($cmd -in @("open-module","enter-module","module-open","module-enter","entrar-modulo")){$cmd="abrir-modulo"}elseif($cmd -in @("new-module","create-module","module-new","module-create","crear-modulo")){$cmd="nuevo-modulo"}elseif($cmd -in @("library","open-library","import-library","library-import")){$cmd="biblioteca"}
if($cmd -eq "abrir-proyecto"){Select-Project;exit}
if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;$s=Get-State;$s.mode="project";$s.active_project=$p;$s.active_master_vault=Join-Path $p "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="nuevo-proyecto";$s.next="proyecto";Save-State $s;L ("OK active_project="+$p) Green;exit}
if($cmd -eq "abrir-modulo"){Select-Module;exit}
if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
if($cmd -eq "biblioteca"){& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-library-import.ps1");exit}
if($cmd -in @("projects","proyectos","ver-proyectos","list-projects","project-list")){
  $nav=Join-Path $PSScriptRoot "eng-navigation.ps1"
  $navRaw=Get-Content $nav -Raw
  $navBlock=[scriptblock]::Create($navRaw)
  . $navBlock
  function Draw-EngProjects {
    Eng-L "PROYECTOS" Cyan
    $s=Get-State
    $historical=@()
    if($s.PSObject.Properties.Name -contains "historical_projects" -and $s.historical_projects){$historical=@($s.historical_projects|ForEach-Object{[string]$_.path})}
    $projects=@(Get-AllProjects)
    if($projects.Count -eq 0){
      Eng-L "sin proyectos" Yellow
    }else{
      $i=1
      foreach($proj in $projects){
        $kind=if($historical -contains $proj.FullName){"HISTORICO"}else{"ACTIVO"}
        $color=if($kind -eq "HISTORICO"){"DarkGray"}else{"Green"}
        Eng-L (" ["+$i+"] "+$proj.Name+"  "+$proj.LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  "+$kind) $color
        $i++
      }
    }
    Eng-L ""
    Eng-L " [b] Atras" Yellow
  }
  Eng-InvokeScreenLoop -Draw ${function:Draw-EngProjects} | Out-Null
  $s=Get-State;$s.mode="global";$s.last_command="proyectos";$s.next="global";Save-State $s;exit
}
throw "context_command_not_supported=$Command"

