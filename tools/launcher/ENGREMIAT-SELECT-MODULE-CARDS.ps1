param(
  [string]$ProjectPath=""
)

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
$TargetScript=Join-Path $ToolDir "eng-module-cards-screen.ps1"

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

function ActiveProject(){
  if($ProjectPath -and (Test-Path $ProjectPath)){ return $ProjectPath }

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

function NormalizeStatus($status){
  $s=([string]$status).Trim().ToUpperInvariant()
  if($s -eq "ACTIVE" -or $s -eq "ACTIVO"){ return "ACTIVO" }
  if($s -eq "INACTIVE" -or $s -eq "INACTIVO" -or $s -eq "DISABLED" -or $s -eq "DESACTIVADO"){ return "INACTIVO" }
  if($s -eq "HISTORIC" -or $s -eq "HISTORICAL" -or $s -eq "HISTORICO" -or $s -eq "HISTÓRICO"){ return "HISTORICO" }
  if([string]::IsNullOrWhiteSpace($s)){ return "ACTIVO" }
  return $s
}

function ModuleStatus($dir){
  $mj=Join-Path $dir "module.json"
  if(Test-Path $mj){
    try{
      $j=Get-Content $mj -Raw | ConvertFrom-Json
      if($j.status){ return NormalizeStatus $j.status }
    }catch{}
  }
  return "ACTIVO"
}



function Row($origin,$dir){
  return [pscustomobject]@{
    origin=$origin
    name=(Split-Path $dir -Leaf)
    path=$dir
    status=(ModuleStatus $dir)
  }
}

function GetRows($view,$project){
  $rows=@()

  $projectRoot=""
  if($project){ $projectRoot=Join-Path $project "MODULOS" }

  $libRoot=Join-Path $Core "library\modules"
  $histRoot=Join-Path $Core "library\modules_historico"

  if($view -eq "PROYECTO" -or $view -eq "TODOS"){
    if(Test-Path $projectRoot){
      foreach($d in (Get-ChildItem $projectRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
        $rows += Row "PROYECTO" $d.FullName
      }
    }
  }

  if($view -eq "BIBLIOTECA" -or $view -eq "TODOS"){
    if(Test-Path $libRoot){
      foreach($d in (Get-ChildItem $libRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
        $rows += Row "BIBLIOTECA" $d.FullName
      }
    }
  }

  if($view -eq "HISTORICOS" -or $view -eq "TODOS"){
    if(Test-Path $histRoot){
      foreach($d in (Get-ChildItem $histRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
        $rows += Row "BIB_HIST" $d.FullName
      }
    }
  }

  return @($rows)
}

function ShowRows($rows,$view,$project){
  Clear-Host
  W "==== SELECCIONAR MODULO PARA TARJETAS ====" Cyan

  if($project){ W ("Proyecto activo: {0}" -f (Split-Path $project -Leaf)) Green }
  else{ W "Proyecto activo: NO_DETECTADO" Yellow }

  W ("VISTA: {0}" -f $view) Yellow
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
  W ""

  W "N    ORIGEN       MODULO                                       ESTADO" DarkGray
  W "--   ------       ------                                       ------" DarkGray

  $i=1
  foreach($r in $rows){
    $n=("[{0,-2}]" -f $i)
    $origin=("{0,-12}" -f $r.origin)
    $name=("{0,-44}" -f $r.name)
    $st=$r.status
    $color=if($st -eq "INACTIVO"){"DarkGray"}elseif($st -eq "HISTORICO"){"Yellow"}else{"White"}
    W ("{0} {1} {2} {3}" -f $n,$origin,$name,$st) $color
    $i++
  }

  if($rows.Count -eq 0){
    W ""
    W "Sin módulos en esta vista." Yellow
  }

  W ""
}

function Main(){
  if(-not(Test-Path $TargetScript)){ throw "target_script_missing=$TargetScript" }

  $project=ActiveProject
  $view="PROYECTO"

  while($true){
    $rows=GetRows $view $project
    ShowRows $rows $view $project

    $cmd=Read-Host "MODULO_TARJETAS_SELECTOR"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "b"){ return }
    if($cmd -eq "p"){ $view="PROYECTO"; continue }
    if($cmd -eq "l"){ $view="BIBLIOTECA"; continue }
    if($cmd -eq "h"){ $view="HISTORICOS"; continue }
    if($cmd -eq "t"){ $view="TODOS"; continue }

    $n=0
    if([int]::TryParse($cmd,[ref]$n)){
      if($n -ge 1 -and $n -le $rows.Count){
        $selected=$rows[$n-1]
        & powershell -NoProfile -ExecutionPolicy Bypass -File $TargetScript -ProjectPath $project -ModulePath ([string]$selected.path)
        continue
      }
    }

    W "WARN comando_no_reconocido" Yellow
    P
  }
}

Main


