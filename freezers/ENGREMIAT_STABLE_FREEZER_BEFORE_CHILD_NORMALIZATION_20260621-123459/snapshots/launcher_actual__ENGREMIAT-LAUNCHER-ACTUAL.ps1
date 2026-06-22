
# ENG_LAUNCHER_ACTUAL_SCREEN_MASTER_E29_BEGIN
function Show-EngLauncherActualHelp {
  Clear-Host
  Write-Host "==== AYUDA - LAUNCHER ACTUAL ====" -ForegroundColor Cyan
  Write-Host "Ruta: LAUNCHER ACTUAL" -ForegroundColor DarkCyan
  Write-Host ""
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor Gray
  Write-Host "q/b = salir o volver" -ForegroundColor Gray
  Write-Host "m = mantenimiento contextual si ya existe en esta pantalla" -ForegroundColor Gray
  Write-Host "? = ayuda" -ForegroundColor Gray
  Write-Host ""
  Read-Host "Enter para volver" | Out-Null
}
# ENG_LAUNCHER_ACTUAL_SCREEN_MASTER_E29_END

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"

function Invoke-HumanCardAssistant(){ $assistant = Join-Path $Root "tools\human-card-assistant.ps1"; if(Test-Path $assistant){ & powershell -NoProfile -ExecutionPolicy Bypass -File $assistant } else { W "PENDIENTE asistente tarjetas humanas" Yellow; Read-Host "Enter = volver" | Out-Null } }
function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

function Show-EngLauncherActualMaintenance(){
  Clear-Host
  W "==== ENGREMIAT / LAUNCHER ACTUAL - MANTENIMIENTO ====" Cyan
  W ""
  W ("Ruta: " + $PSCommandPath) DarkGray
  W "Principio: mantenimiento contextual del launcher actual" DarkGray
  W ""
  W "[1] Revisar ruta launcher actual" White
  W "[2] Abrir carpeta tools launcher" White
  W "[3] Volver sin cambios" White
  W ""
  W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" DarkGray
  W ""
  $mc = Read-Host "MANTENIMIENTO"
  $mc = ($mc + "").Trim().ToLowerInvariant()
  if($mc -eq "1"){ W ("OK ruta=" + $PSCommandPath) Green; P; return }
  if($mc -eq "2"){ $d=Join-Path $Core "tools\launcher"; if(Test-Path $d){ Start-Process explorer.exe $d }; return }
  return
}
function ActiveProject(){
  $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
  $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
  if(Test-Path $j){
    try{
      $x=Get-Content $j -Raw | ConvertFrom-Json
      if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }
    }catch{}
  }
  if(Test-Path $t){
    $y=(Get-Content $t -Raw).Trim()
    if(Test-Path $y){ return $y }
  }
  return ""
}

function RunScript($file,$args=@()){
  if(-not(Test-Path $file)){
    W "NO_GO script_no_encontrado=$file" Red
    P
    return
  }
  & powershell -NoProfile -ExecutionPolicy Bypass -File $file @args
}

function ShowStatus(){
  Clear-Host
  $p=ActiveProject
  W "==== ESTADO ENGREMIAT ====" Cyan
  W "Core: $Core" White
  if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green; W "Ruta: $p" DarkGray }
  else{ W "Proyecto activo: NO_DETECTADO" Yellow }

  $checks=@(
    @{name="Pantalla proyectos/modulos"; path=(Join-Path $ToolDir "eng-project-modules-screen.ps1")},
    @{name="Biblioteca modulos"; path=(Join-Path $ToolDir "eng-module-library-screen.ps1")},
    @{name="Workspace modulo"; path=(Join-Path $ToolDir "eng-module-workspace-screen.ps1")},
    @{name="Tarjetas modulo"; path=(Join-Path $ToolDir "eng-module-cards-screen.ps1")},
    @{name="Grafo modulos"; path=(Join-Path $ToolDir "eng-refresh-project-module-graph.ps1")}
  )

  W ""
  W "Pantallas detectadas:" Cyan
  foreach($c in $checks){
    if(Test-Path $c.path){ W " OK   $($c.name)" Green }
    else{ W " MISS $($c.name)" Yellow }
  }

  if($p){
    $modsDir=Join-Path $p "MODULOS"
    $mods=if(Test-Path $modsDir){ @(Get-ChildItem $modsDir -Directory -ErrorAction SilentlyContinue).Count }else{0}
    W ""
    W "Modulos proyecto activo: $mods" White
  }

  $libAct="C:\ENGREMIAT_CORE\library\modules"
  $libHist="C:\ENGREMIAT_CORE\library\modules_historico"
  $la=if(Test-Path $libAct){ @(Get-ChildItem $libAct -Directory -ErrorAction SilentlyContinue).Count }else{0}
  $lh=if(Test-Path $libHist){ @(Get-ChildItem $libHist -Directory -ErrorAction SilentlyContinue).Count }else{0}
  W "Biblioteca: $la activos / $lh historicos" White
  P
}

function OpenActiveProjectFolder(){
  $p=ActiveProject
  if($p){ Start-Process explorer.exe $p }
  else{ W "NO_GO no_hay_proyecto_activo" Yellow; P }
}

function Main(){
  while($true){
    $p=ActiveProject
    Clear-Host
W "==== ENGREMIAT / LAUNCHER ACTUAL ====" Cyan
W ""
W ("Ruta: " + $PSCommandPath) DarkGray
W "Principio: panel central del sistema actual" DarkGray
    W ""
    if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
    else{ W "Proyecto activo: NO_DETECTADO" Yellow }
    W ""
    W "OPERADOR / PROYECTO" Yellow
    W "[1] Abrir operador terminal principal" White
    W "[2] Abrir carpeta proyecto activo" White
    W "[3] Estado compacto del launcher" White
    W ""
    W "MODULOS / BIBLIOTECA" Yellow
    W "[4] Pantalla modulos del proyecto" White
    W "[5] Biblioteca de modulos" White
    W "[6] Workspace de modulo" White
    W "[7] Tarjetas de modulo" White
    W ""
    W "MANTENIMIENTO" Yellow
    W "[8] Refrescar grafo de modulos del proyecto activo" White
    W "[9] Abrir carpeta tools launcher" White
    W ""
W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" Cyan
    W ""
    $cmd=Read-Host "ENGREMIAT"
# ENG_LAUNCHER_ACTUAL_ROUTER_E29_BEGIN
$__eng_launcher_cmd = if($null -eq $cmd) { "" } else { [string]$cmd }
$__eng_launcher_cmd = $__eng_launcher_cmd.Trim().ToLowerInvariant()
if($__eng_launcher_cmd -eq ""){ continue }
if($__eng_launcher_cmd -eq "?"){ Show-EngLauncherActualHelp; continue }
if($__eng_launcher_cmd -eq "m"){ Show-EngLauncherActualMaintenance; continue }
if($__eng_launcher_cmd -eq "b"){ return }
if($__eng_launcher_cmd -eq "q"){ return }
# ENG_LAUNCHER_ACTUAL_ROUTER_E29_END

    if($false){ continue }
    if($false){ return }

    if($cmd -eq "1"){
      $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
      if(Test-Path $main){ RunScript $main }
      else{
        $alt=Join-Path $ToolDir "eng-terminal-operator.ps1"
        RunScript $alt
      }
      continue
    }

    if($cmd -eq "2"){ OpenActiveProjectFolder; continue }
    if($cmd -eq "3"){ ShowStatus; continue }

    if($cmd -eq "4"){
      $s=Join-Path $ToolDir "eng-project-modules-screen.ps1"
      if($p){ RunScript $s @("-ProjectPath",$p) } else { RunScript $s }
      continue
    }

    if($cmd -eq "5"){
      $s=Join-Path $ToolDir "eng-module-library-screen.ps1"
      if($p){ RunScript $s @("-ProjectPath",$p) } else { RunScript $s }
      continue
    }

    if($cmd -eq "6"){
      $s=Join-Path $ToolDir "eng-module-workspace-screen.ps1"
      if($p){ RunScript $s @("-ProjectPath",$p) } else { RunScript $s }
      continue
    }

    if($cmd -eq "7"){
      $s=Join-Path $ToolDir "eng-module-cards-screen.ps1"
      if($p){ RunScript $s @("-ProjectPath",$p) } else { RunScript $s }
      continue
    }

    if($cmd -eq "8"){
      $s=Join-Path $ToolDir "eng-refresh-project-module-graph.ps1"
      if($p){ RunScript $s @("-ProjectPath",$p) } else { RunScript $s }
      continue
    }

    if($cmd -eq "9"){
      Start-Process explorer.exe (Split-Path $PSCommandPath)
      continue
    }
  }
}

Main





