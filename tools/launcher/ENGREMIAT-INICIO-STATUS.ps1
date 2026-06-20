param()

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$RepDir=Join-Path $Core "reports\launcher"
New-Item -ItemType Directory -Force -Path $RepDir | Out-Null

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }

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

function CountDirs($path){
  if(Test-Path $path){ return @((Get-ChildItem $path -Directory -ErrorAction SilentlyContinue)).Count }
  return 0
}

function CountLibrary(){
  $lib=Join-Path $Core "library\modules"
  $hist=Join-Path $Core "library\modules_historico"
  $active=0
  $inactive=0
  if(Test-Path $lib){
    foreach($d in (Get-ChildItem $lib -Directory -ErrorAction SilentlyContinue)){
      $st=ModuleStatus $d.FullName
      if($st -eq "INACTIVO"){ $inactive++ } else { $active++ }
    }
  }
  return [pscustomobject]@{
    active=$active
    inactive=$inactive
    historic=(CountDirs $hist)
  }
}

function ReadFocus(){
  $files=@(
    (Join-Path $Core "data\launcher\last-focus.json"),
    (Join-Path $Core "data\desktop-terminal-operator\last-focus.json"),
    (Join-Path $Core "reports\launcher\last-inicio-status.json")
  )
  foreach($f in $files){
    if(Test-Path $f){
      try{
        $x=Get-Content $f -Raw | ConvertFrom-Json
        if($x.last_focus){ return $x.last_focus }
        if($x.screen){ return $x }
      }catch{}
    }
  }
  return [pscustomobject]@{ screen="none"; note="sin foco guardado"; updated_at="" }
}

function Check($label,$path){
  if(Test-Path $path){ W ("[OK]   {0}" -f $label) Green }
  else{ W ("[MISS] {0}" -f $label) Yellow }
}

$p=ActiveProject
$lib=CountLibrary
$f=ReadFocus
$projectModules=0
if($p){ $projectModules=CountDirs (Join-Path $p "MODULOS") }

$statusFile=Join-Path $RepDir "last-inicio-status.json"
$logFile=Join-Path $RepDir "last-inicio-log.txt"

Clear-Host
W "==== STATUS EXTERNO INICIO ====" Cyan
W ""
W ("Generado: {0}" -f (Get-Date).ToString("s")) DarkCyan
W ("Core: {0}" -f $Core) White
if($p){
  W ("Proyecto activo: {0}" -f (Split-Path $p -Leaf)) Green
  W ("Ruta: {0}" -f $p) DarkCyan
}else{
  W "Proyecto activo: NO_DETECTADO" Yellow
  W "Ruta: -" DarkGray
}
W ""
W "RESUMEN" Yellow
W ("  Módulos proyecto: {0}" -f $projectModules) White
W ("  Biblioteca: {0} activos / {1} inactivos / {2} históricos" -f $lib.active,$lib.inactive,$lib.historic) White
if($f.screen -eq "operator"){
  W "  Último foco: operator | dashboard humano / operador visual" White
}else{
  W ("  Último foco: {0} | {1}" -f $f.screen,$f.note) White
}
W ""
W "PANTALLAS" Yellow
Check "Inicio" (Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1")
Check "Dashboard humano / operador visual" (Join-Path $Core "dashboard\human-start\index.html")
Check "Módulos proyecto" (Join-Path $Core "tools\desktop-terminal-operator\eng-project-modules-screen.ps1")
Check "Biblioteca módulos" (Join-Path $Core "tools\desktop-terminal-operator\eng-module-library-screen.ps1")
Check "Workspace módulo" (Join-Path $Core "tools\desktop-terminal-operator\eng-module-workspace-screen.ps1")
Check "Tarjetas módulo" (Join-Path $Core "tools\desktop-terminal-operator\eng-module-cards-screen.ps1")
Check "Grafo módulos" (Join-Path $Core "tools\desktop-terminal-operator\eng-refresh-project-module-graph.ps1")
Check "Árbol navegación" (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1")
Check "Memoria viva" (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1")
W ""
W "ARCHIVOS" Yellow
W ("  COPIABLE_JSON: {0}" -f $statusFile) White
W ("  LOG:           {0}" -f $logFile) White
W ""
W "[Enter] volver al inicio" Cyan
W ""
[void](Read-Host "STATUS_EXTERNO")
