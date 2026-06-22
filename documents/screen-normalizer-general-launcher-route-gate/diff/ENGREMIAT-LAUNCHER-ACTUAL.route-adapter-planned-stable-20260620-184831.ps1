$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

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
    W "==== ENGREMIAT LAUNCHER ACTUAL ====" Cyan
    W "Un clic -> panel central del sistema actual" DarkCyan
    W ""
    if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
    else{ W "Proyecto activo: NO_DETECTADO" Yellow }
    W ""
    W "OPERADOR / PROYECTO" Yellow
    W "1 = abrir operador terminal principal" White
    W "2 = abrir carpeta proyecto activo" White
    W "3 = estado compacto del launcher" White
    W ""
    W "MODULOS / BIBLIOTECA" Yellow
    W "4 = pantalla modulos del proyecto" White
    W "5 = biblioteca de modulos" White
    W "6 = workspace de modulo" White
    W "7 = tarjetas de modulo" White
    W ""
    W "MANTENIMIENTO" Yellow
    W "8 = refrescar grafo de modulos del proyecto activo" White
    W "9 = abrir carpeta tools launcher" White
    W ""
    W "q = salir | Enter = refrescar" Cyan
    W ""
    $cmd=Read-Host "ENGREMIAT"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "q"){ return }

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


# ENGREMIAT_ROUTE_GATE_PLANNED_BEGIN
# Planned route only. This candidate is NOT applied to the real launcher.
# Human route: Adapter subpantallas normalizadas.
function Invoke-EngremiatSubscreenRoutingAdapter {
  & powershell -NoProfile -ExecutionPolicy Bypass -File 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1'
}
# Proposed menu option: [9] Adapter subpantallas normalizadas
# Integration note: wire this function into the launcher menu/switch after explicit apply authorization.
# ENGREMIAT_ROUTE_GATE_PLANNED_END
