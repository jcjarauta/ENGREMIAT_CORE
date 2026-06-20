param()

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$RepDir=Join-Path $Core "reports\navigation"
New-Item -ItemType Directory -Force -Path $RepDir | Out-Null

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

$p=ActiveProject
$projectModules=0
if($p){ $projectModules=CountDirs (Join-Path $p "MODULOS") }
$lib=CountLibrary

$screens=@(
  @{ id="inicio"; label="Inicio"; status="OK" },
  @{ id="modules"; label="Módulos del proyecto"; status="OK" },
  @{ id="library"; label="Biblioteca de módulos"; status="OK" },
  @{ id="workspace"; label="Workspace de módulo"; status="OK" },
  @{ id="cards"; label="Tarjetas de módulo"; status="OK" },
  @{ id="navigation"; label="Árbol de navegación"; status="OK" },
  @{ id="routes"; label="Rutas recomendadas"; status="OK" },
  @{ id="help"; label="Ayuda"; status="OK" },
  @{ id="technical_status"; label="Estado técnico"; status="OK" },
  @{ id="copyable_status"; label="Estado copiable"; status="OK" },
  @{ id="memory"; label="Memoria viva"; status="OK" },
  @{ id="diary"; label="Diario de desarrollo"; status="OK" }
)

$routes=@(
  @{ section="CONTINUAR"; from="inicio"; key="1"; to="smart_start"; description="acción recomendada contextual" },
  @{ section="TRABAJO"; from="inicio"; key="2"; to="modules"; description="módulos del proyecto activo" },
  @{ section="TRABAJO"; from="inicio"; key="3"; to="library"; description="biblioteca de módulos" },
  @{ section="TRABAJO"; from="inicio"; key="4"; to="workspace"; description="workspace de módulo" },
  @{ section="TRABAJO"; from="inicio"; key="5"; to="cards"; description="tarjetas de módulo" },
  @{ section="TRABAJO"; from="inicio"; key="6"; to="project_folder"; description="abrir carpeta del proyecto activo" },
  @{ section="TRABAJO"; from="inicio"; key="7"; to="human_start_dashboard"; description="dashboard humano / operador visual" },
  @{ section="REVISAR"; from="inicio"; key="8"; to="navigation_safe"; description="árbol de navegación seguro" },
  @{ section="REVISAR"; from="inicio"; key="9"; to="routes_help"; description="rutas recomendadas" },
  @{ section="REVISAR"; from="inicio"; key="10"; to="help"; description="ayuda" },
  @{ section="DIAGNOSTICO"; from="inicio"; key="11"; to="technical_status"; description="estado técnico" },
  @{ section="DIAGNOSTICO"; from="inicio"; key="12"; to="copyable_status"; description="estado copiable" },
  @{ section="DIAGNOSTICO"; from="inicio"; key="13"; to="external_status"; description="status externo" },
  @{ section="DIAGNOSTICO"; from="inicio"; key="14"; to="last_log"; description="último log" },
  @{ section="MEMORIA"; from="inicio"; key="15"; to="live_memory"; description="generar/abrir memoria viva" },
  @{ section="MEMORIA"; from="inicio"; key="16"; to="chatgpt_prompt"; description="generar/abrir prompt continuidad ChatGPT" },
  @{ section="MEMORIA"; from="inicio"; key="17"; to="worker_prompt"; description="generar/abrir prompt worker Ollama/Cline" },
  @{ section="MEMORIA"; from="inicio"; key="18"; to="development_diary"; description="abrir diario de desarrollo" },
  @{ section="MEMORIA"; from="inicio"; key="19"; to="add_diary_entry"; description="añadir entrada al diario" },
  @{ section="MANTENIMIENTO"; from="inicio"; key="20"; to="graph_refresh"; description="refrescar grafo de módulos" },
  @{ section="MANTENIMIENTO"; from="inicio"; key="21"; to="core_folder"; description="abrir C:\ENGREMIAT_CORE" },
  @{ section="WORKSPACE"; from="workspace"; key="2"; to="cards"; description="tarjetas avanzadas del módulo" },
  @{ section="BIBLIOTECA"; from="library_item"; key="w"; to="workspace"; description="abrir workspace desde ficha de módulo" }
)

$obj=[pscustomobject]@{
  generated=(Get-Date).ToString("s")
  project_active=if($p){ Split-Path $p -Leaf }else{"NO_DETECTADO"}
  project_path=$p
  project_modules=$projectModules
  library_active=$lib.active
  library_inactive=$lib.inactive
  library_historic=$lib.historic
  screens=$screens
  routes=$routes
  screens_ok=@($screens | Where-Object { $_.status -eq "OK" }).Count
  screens_total=@($screens).Count
  routes_total=@($routes).Count
  next="E24A_CREATE_MODULE_TASKS_MANAGEMENT_SCREEN"
}

$json=Join-Path $RepDir "navigation-tree-latest.json"
$md=Join-Path $RepDir "navigation-tree-latest.md"

$obj | ConvertTo-Json -Depth 50 | Set-Content $json -Encoding UTF8

$lines=@()
$lines+="# ENGREMIAT - Árbol de navegación"
$lines+=""
$lines+="Generado: $($obj.generated)"
$lines+="Proyecto activo: $($obj.project_active)"
$lines+="Módulos proyecto: $($obj.project_modules)"
$lines+="Biblioteca: $($obj.library_active) activos / $($obj.library_inactive) inactivos / $($obj.library_historic) históricos"
$lines+="Pantallas OK: $($obj.screens_ok)/$($obj.screens_total)"
$lines+="Rutas registradas: $($obj.routes_total)"
$lines+="Siguiente: $($obj.next)"
$lines+=""
$lines+="## Rutas"
foreach($sec in ($routes.section | Select-Object -Unique)){
  $lines+=""
  $lines+="### $sec"
  foreach($r in ($routes | Where-Object { $_.section -eq $sec })){
    $lines+="- [$($r.key)] $($r.from) -> $($r.to): $($r.description)"
  }
}
$lines | Set-Content $md -Encoding UTF8

Write-Host "OK navigation_tree_generated=True" -ForegroundColor Green
Write-Host "json=$json" -ForegroundColor Green
Write-Host "md=$md" -ForegroundColor Green
