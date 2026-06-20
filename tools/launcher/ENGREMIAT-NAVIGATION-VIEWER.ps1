param()

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$RepDir=Join-Path $Core "reports\navigation"
$TreeScript=Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-TREE.ps1"
$Json=Join-Path $RepDir "navigation-tree-latest.json"
$Md=Join-Path $RepDir "navigation-tree-latest.md"

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

function EnsureTree(){
  if(-not(Test-Path $TreeScript)){ throw "navigation_tree_script_missing=$TreeScript" }
  & powershell -NoProfile -ExecutionPolicy Bypass -File $TreeScript | Out-Null
  if(-not(Test-Path $Json)){ throw "navigation_tree_json_missing=$Json" }
  return (Get-Content $Json -Raw | ConvertFrom-Json)
}

function ShowMain($obj){
  Clear-Host
  W "==== ARBOL DE NAVEGACION ====" Cyan
  W ("Generado: {0}" -f $obj.generated) DarkCyan
  W ("Proyecto activo: {0}" -f $obj.project_active) Green
  W ("Módulos proyecto: {0}" -f $obj.project_modules) White
  W ("Biblioteca: {0} activos / {1} inactivos / {2} históricos" -f $obj.library_active,$obj.library_inactive,$obj.library_historic) White
  W ("Pantallas OK: {0}/{1}" -f $obj.screens_ok,$obj.screens_total) Green
  W ("Rutas registradas: {0}" -f $obj.routes_total) White
  W ("Siguiente: {0}" -f $obj.next) Yellow
  W ""
  W "[1] ver pantallas" White
  W "[2] ver rutas por seccion" White
  W "[3] ver memoria/diario" White
  W "[4] ver recomendaciones" White
  W "[5] abrir markdown" White
  W "[6] regenerar árbol" White
  W "[b] atras | [Enter] refrescar" Cyan; W ""
}

function ShowScreens($obj){
  Clear-Host
  W "==== PANTALLAS ====" Cyan
  foreach($s in $obj.screens){
    W ("[{0}] {1}  {2}" -f $s.id,$s.label,$s.status) White
  }
  W ""
  W "[b] atras | [Enter] refrescar" Cyan; W ""
}

function ShowRoutes($obj){
  Clear-Host
  W "==== RUTAS POR SECCION ====" Cyan
  $sections=@($obj.routes | ForEach-Object { $_.section } | Select-Object -Unique)
  foreach($sec in $sections){
    W "" White
    W $sec Yellow
    foreach($r in @($obj.routes | Where-Object { $_.section -eq $sec })){
      W ("[{0}] {1} -> {2}" -f $r.key,$r.from,$r.to) White
      W ("    {0}" -f $r.description) DarkGray
    }
  }
  W ""
  W "[b] atras | [Enter] refrescar" Cyan; W ""
}

function ShowMemory($obj){
  Clear-Host
  W "==== MEMORIA / DIARIO ====" Cyan
  W "[15] memoria viva" White
  W "[16] prompt continuidad ChatGPT" White
  W "[17] prompt worker Ollama/Cline" White
  W "[18] diario de desarrollo" White
  W "[19] añadir entrada al diario" White
  W ""
  W "Ruta memoria: C:\ENGREMIAT_CORE\memory\project-memory" DarkCyan
  W "[b] atras | [Enter] refrescar" Cyan; W ""
}

function ShowRecommendations($obj){
  Clear-Host
  W "==== RECOMENDACIONES ====" Cyan
  W ("Siguiente: {0}" -f $obj.next) Yellow
  W ""
  W "Pendiente recomendado: crear pantalla avanzada de tareas de módulo." White
  W "Revisión actual: mantener INICIO como raíz estable antes de profundizar." White
  W ""
  W "[b] atras | [Enter] refrescar" Cyan; W ""
}

$obj=EnsureTree
$view="main"

while($true){
  if($view -eq "main"){ ShowMain $obj }
  elseif($view -eq "screens"){ ShowScreens $obj }
  elseif($view -eq "routes"){ ShowRoutes $obj }
  elseif($view -eq "memory"){ ShowMemory $obj }
  elseif($view -eq "recommendations"){ ShowRecommendations $obj }

  $cmd=Read-Host "ARBOL"
  if([string]::IsNullOrWhiteSpace($cmd)){
    $obj=EnsureTree
    continue
  }
  if($cmd -eq "b"){
    if($view -eq "main"){ return }
    $view="main"
    continue
  }
  if($view -eq "main"){
    if($cmd -eq "1"){ $view="screens"; continue }
    if($cmd -eq "2"){ $view="routes"; continue }
    if($cmd -eq "3"){ $view="memory"; continue }
    if($cmd -eq "4"){ $view="recommendations"; continue }
    if($cmd -eq "5"){
      if(Test-Path $Md){ Start-Process notepad.exe $Md }
      continue
    }
    if($cmd -eq "6"){
      $obj=EnsureTree
      continue
    }
  }
  W "WARN comando_no_reconocido" Yellow
  P
}

