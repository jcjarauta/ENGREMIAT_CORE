$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
$FocusFile=Join-Path $Core "data\desktop-terminal-operator\last-focus.json"

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

function SaveFocus($screen,$project,$module,$note){
  New-Item -ItemType Directory -Force -Path (Split-Path $FocusFile) | Out-Null
  [pscustomobject]@{
    screen=$screen
    project=$project
    module=$module
    note=$note
    updated_at=(Get-Date).ToString("s")
  } | ConvertTo-Json -Depth 20 | Set-Content $FocusFile -Encoding UTF8
}

function ReadFocus(){
  if(Test-Path $FocusFile){
    try{ return Get-Content $FocusFile -Raw | ConvertFrom-Json }catch{}
  }

  return [pscustomobject]@{
    screen="none"
    project=""
    module=""
    note="sin foco guardado"
    updated_at=""
  }
}

function RunTool($name,$args=@(),$focusScreen="tool",$focusNote=""){
  $path=Join-Path $ToolDir $name
  if(-not(Test-Path $path)){
    W "NO_GO herramienta_no_encontrada=$path" Red
    P
    return
  }

  $p=ActiveProject
  SaveFocus $focusScreen $p "" $focusNote
  & powershell -NoProfile -ExecutionPolicy Bypass -File $path @args
}

function OpenFolder($path){
  if(Test-Path $path){ Start-Process explorer.exe $path }
  else{ W "NO_GO carpeta_no_encontrada=$path" Yellow; P }
}

function FindMainOperatorScripts(){
  $roots=@(
    (Join-Path $Core "tools\desktop-terminal-operator"),
    (Join-Path $Core "tools"),
    $Core
  ) | Where-Object { Test-Path $_ }

  $preferredNames=@(
    "eng-desktop-terminal-operator.ps1",
    "eng-terminal-operator.ps1",
    "eng-operator.ps1",
    "operator.ps1",
    "eng.ps1",
    "e.ps1"
  )

  $found=@()

  foreach($root in $roots){
    foreach($name in $preferredNames){
      $p=Join-Path $root $name
      if(Test-Path $p){
        $found += [pscustomobject]@{ score=100; name=$name; path=$p; source="preferred" }
      }
    }
  }

  foreach($root in $roots){
    Get-ChildItem $root -Filter "*.ps1" -Recurse -ErrorAction SilentlyContinue |
      Where-Object {
        $_.FullName -notlike "*\.git\*" -and
        $_.Name -match "(operator|inicio|launcher|desktop|terminal|engremiat|eng)"
      } |
      ForEach-Object {
        $score=10
        if($_.Name -match "operator"){ $score+=40 }
        if($_.Name -match "desktop"){ $score+=15 }
        if($_.Name -match "terminal"){ $score+=15 }
        if($_.Name -match "engremiat|eng"){ $score+=10 }
        if($_.FullName -match "desktop-terminal-operator"){ $score+=20 }
        $found += [pscustomobject]@{ score=$score; name=$_.Name; path=$_.FullName; source="scan" }
      }
  }

  return @($found | Sort-Object score,name -Descending | Group-Object path | ForEach-Object { $_.Group | Select-Object -First 1 } | Sort-Object score -Descending)
}

function OpenMainOperator(){
  $scripts=FindMainOperatorScripts

  if(-not $scripts -or $scripts.Count -eq 0){
    W "NO_GO no_se_encontro_operador_principal" Red
    W "Usa 4 módulos, 5 biblioteca, 6 workspace o 7 tarjetas mientras reconstruimos el operador raíz." Yellow
    P
    return
  }

  $best=$scripts | Select-Object -First 1

  if($best.score -ge 80){
    SaveFocus "operator" (ActiveProject) "" "operador principal"
    & powershell -NoProfile -ExecutionPolicy Bypass -File $best.path
    return
  }

  while($true){
    Clear-Host
    W "==== SELECCIONAR OPERADOR PRINCIPAL ====" Cyan
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
    W ""

    for($i=0;$i -lt $scripts.Count;$i++){
      W ("[{0,-2}] score={1,-3} {2}" -f ($i+1),$scripts[$i].score,$scripts[$i].name) White
      W ("     {0}" -f $scripts[$i].path) DarkGray
    }

    W ""
    $cmd=Read-Host "OPERADOR"
    if([string]::IsNullOrWhiteSpace($cmd)){ $scripts=FindMainOperatorScripts; continue }
    if($cmd -eq "b"){ return }
    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $scripts.Count){
        SaveFocus "operator" (ActiveProject) "" $scripts[$ix].path
        & powershell -NoProfile -ExecutionPolicy Bypass -File $scripts[$ix].path
        return
      }
    }
  }
}

function ContinueLastFocus(){
  $f=ReadFocus
  $p=ActiveProject

  if(-not $f -or $f.screen -eq "none"){
    W "WARN no_hay_ultimo_foco_guardado" Yellow
    W "Ruta recomendada: 4 módulos o 6 workspace de módulo." DarkCyan
    P
    return
  }

  if($f.screen -eq "modules"){
    if($p){ RunTool "eng-project-modules-screen.ps1" @("-ProjectPath",$p) "modules" "modulos proyecto" }
    else{ RunTool "eng-project-modules-screen.ps1" @() "modules" "modulos proyecto" }
    return
  }

  if($f.screen -eq "library"){
    if($p){ RunTool "eng-module-library-screen.ps1" @("-ProjectPath",$p) "library" "biblioteca modulos" }
    else{ RunTool "eng-module-library-screen.ps1" @() "library" "biblioteca modulos" }
    return
  }

  if($f.screen -eq "workspace"){
    if($p){ RunTool "eng-module-workspace-screen.ps1" @("-ProjectPath",$p) "workspace" "workspace modulo" }
    else{ RunTool "eng-module-workspace-screen.ps1" @() "workspace" "workspace modulo" }
    return
  }

  if($f.screen -eq "cards"){
    if($p){ RunTool "eng-module-cards-screen.ps1" @("-ProjectPath",$p) "cards" "tarjetas modulo" }
    else{ RunTool "eng-module-cards-screen.ps1" @() "cards" "tarjetas modulo" }
    return
  }

  if($f.screen -eq "operator"){
    OpenMainOperator
    return
  }

  W "WARN foco_no_reconocido=$($f.screen)" Yellow
  P
}

function Status(){
  $p=ActiveProject
  $f=ReadFocus
  $snap=GetDashboardSnapshot

  Clear-Host
  W "==== ESTADO TÉCNICO INICIO ====" Cyan
  W ""

  W ("Core: {0}" -f $Core) White

  if($p){
    W ("Proyecto activo: {0}" -f (Split-Path $p -Leaf)) Green
    W ("Ruta: {0}" -f $p) DarkCyan
  } else {
    W "Proyecto activo: NO_DETECTADO" Yellow
    W "Ruta: -" DarkGray
  }

  W ""

  W "ÚLTIMO FOCO" Yellow
  if($f.screen -and $f.screen -ne "none"){
    if($f.screen -eq "operator"){
      W "  screen: operator" White
      W "  nota:   dashboard humano / operador visual" White
    } else {
      W ("  screen: {0}" -f $f.screen) White
      W ("  nota:   {0}" -f $f.note) White
    }
    W ("  fecha:  {0}" -f $f.updated_at) DarkGray
  } else {
    W "  screen: -" DarkGray
    W "  nota:   sin foco guardado" DarkGray
    W "  fecha:  -" DarkGray
  }

  W ""

  W "PANTALLAS / HERRAMIENTAS" Yellow

  $checks=@(
    @{ label="Inicio"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1") },
    @{ label="Dashboard humano / operador visual"; path=(Join-Path $Core "dashboard\human-start\index.html") },
    @{ label="Módulos proyecto"; path=(Join-Path $Core "tools\desktop-terminal-operator\eng-project-modules-screen.ps1") },
    @{ label="Biblioteca módulos"; path=(Join-Path $Core "tools\desktop-terminal-operator\eng-module-library-screen.ps1") },
    @{ label="Workspace módulo"; path=(Join-Path $Core "tools\desktop-terminal-operator\eng-module-workspace-screen.ps1") },
    @{ label="Tarjetas módulo"; path=(Join-Path $Core "tools\desktop-terminal-operator\eng-module-cards-screen.ps1") },
    @{ label="Selector workspace seguro"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1") },
    @{ label="Selector tarjetas seguro"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-SELECT-MODULE-CARDS.ps1") },
    @{ label="Árbol navegación"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1") },
    @{ label="Memoria viva"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1") },
    @{ label="Diario desarrollo"; path=(Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-DIARY-ADD.ps1") },
    @{ label="Grafo módulos"; path=(Join-Path $Core "tools\desktop-terminal-operator\eng-refresh-project-module-graph.ps1") }
  )

  foreach($c in $checks){
    if(Test-Path $c.path){
      W ("  [OK]   {0}" -f $c.label) Green
    } else {
      W ("  [MISS] {0}" -f $c.label) Yellow
    }
  }

  W ""

  W "CONTEOS" Yellow
  W ("  Módulos proyecto activo: {0}" -f $snap.project_modules) White
  W ("  Biblioteca módulos: {0} activos / {1} inactivos / {2} históricos" -f $snap.library_active,$snap.library_inactive,$snap.library_historic) White

  W ""

  W "COMANDOS" Yellow
  W "  [Enter] volver al inicio" Cyan
  W ""
  [void](Read-Host "ESTADO")
}



function Help(){
  Clear-Host
  W "==== AYUDA ENGREMIAT INICIO ====" Cyan
  W ""
  W "Este inicio es la raíz estable del sistema." White
  W "Sirve para entrar rápido en la pantalla correcta, no para trabajar en profundidad." DarkCyan
  W ""

  W "CONTINUAR" Yellow
  W "  [1] continuar último foco: vuelve a donde estabas trabajando." White
  W ""

  W "TRABAJO" Yellow
  W "  [2] módulos del proyecto activo: revisar/abrir módulos del proyecto." White
  W "  [3] biblioteca de módulos: reutilizables, activos, inactivos e históricos." White
  W "  [4] workspace de módulo: seleccionar módulo y abrir su espacio operativo." White
  W "  [5] tarjetas de módulo: seleccionar módulo y gestionar tarjetas." White
  W "  [6] abrir carpeta proyecto activo: acceso directo al explorador." White
  W "  [7] dashboard humano / operador visual: abre el HTML de inicio humano." White
  W ""

  W "REVISAR / AYUDA" Yellow
  W "  [8] árbol de navegación seguro: mapa de pantallas y rutas." White
  W "  [9] rutas recomendadas: caminos prácticos de trabajo." White
  W "  [10] ayuda: esta pantalla." White
  W "  [11] estado técnico: diagnóstico interno del inicio." White
  W "  [12] estado copiable: resumen para devolver a ChatGPT." White
  W "  [13] status externo: status ejecutable independiente." White
  W "  [14] ver último log: última salida registrada." White
  W ""

  W "MEMORIA" Yellow
  W "  [15] generar/abrir memoria viva." White
  W "  [16] generar/abrir prompt continuidad ChatGPT." White
  W "  [17] generar/abrir prompt worker Ollama/Cline." White
  W "  [18] abrir diario de desarrollo." White
  W "  [19] añadir entrada al diario." White
  W ""

  W "MANTENIMIENTO" Yellow
  W "  [20] refrescar grafo de módulos." White
  W "  [21] abrir C:\ENGREMIAT_CORE." White
  W ""

  W "Regla práctica:" Yellow
  W "  construir/revisar proyecto -> [2]" White
  W "  ordenar módulos reutilizables -> [3]" White
  W "  trabajar un módulo -> [4]" White
  W "  ordenar tarjetas -> [5]" White
  W "  revisar navegación -> [8]" White
  W "  después de cambios estructurales -> [20] y luego [11]" White
  W ""

  W "[Enter] volver al inicio" Cyan
  W ""
  [void](Read-Host "AYUDA")
}



function Routes(){
  Clear-Host
  W "==== RUTAS RECOMENDADAS ====" Cyan
  W ""

  W "Ruta 1: crear o revisar módulo" Yellow
  W "  [2] módulos del proyecto -> número de módulo -> workspace/ficha del módulo" White
  W ""

  W "Ruta 2: convertir módulo en trabajo operativo" Yellow
  W "  [4] workspace de módulo -> seleccionar módulo -> tarjetas/tareas/tipos/enlaces" White
  W ""

  W "Ruta 3: limpiar biblioteca" Yellow
  W "  [3] biblioteca de módulos -> [d] desactivados / [h] históricos / [e] gestionar biblioteca" White
  W ""

  W "Ruta 4: después de cambios estructurales" Yellow
  W "  [20] refrescar grafo de módulos -> [11] estado técnico" White
  W ""

  W "Ruta 5: seguir como estabas" Yellow
  W "  [1] continuar último foco" White
  W ""

  W "[Enter] volver al inicio" Cyan
  W ""
  [void](Read-Host "RUTAS")
}



function GetDashboardSnapshot(){
  $p=ActiveProject
  $mods=0
  $libActive=0
  $libHistoric=0
  $libInactive=0
  $recentModule=""
  $recentModuleSource=""
  $recentWorkspace=""

  if($p){
    $modsDir=Join-Path $p "MODULOS"
    if(Test-Path $modsDir){ $mods=@(Get-ChildItem $modsDir -Directory -ErrorAction SilentlyContinue).Count }
  }

  $libA="C:\ENGREMIAT_CORE\library\modules"
  $libH="C:\ENGREMIAT_CORE\library\modules_historico"

  if(Test-Path $libA){
    $libDirs=@(Get-ChildItem $libA -Directory -ErrorAction SilentlyContinue)
    $libActive=@($libDirs | Where-Object {
      $mj=Join-Path $_.FullName "module.json"
      if(Test-Path $mj){
        try{ ((Get-Content $mj -Raw | ConvertFrom-Json).status) -ne "INACTIVO" }catch{ $true }
      } else { $true }
    }).Count
    $libInactive=@($libDirs | Where-Object {
      $mj=Join-Path $_.FullName "module.json"
      if(Test-Path $mj){
        try{ ((Get-Content $mj -Raw | ConvertFrom-Json).status) -eq "INACTIVO" }catch{ $false }
      } else { $false }
    }).Count
  }

  if(Test-Path $libH){ $libHistoric=@(Get-ChildItem $libH -Directory -ErrorAction SilentlyContinue).Count }

  $workspaceCandidates=@()

  if($p){
    $modsDir=Join-Path $p "MODULOS"
    if(Test-Path $modsDir){
      Get-ChildItem $modsDir -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $ws=Join-Path $_.FullName "_workspace"
        if(Test-Path $ws){
          $workspaceCandidates += [pscustomobject]@{
            module=$_.Name
            path=$_.FullName
            workspace=$ws
            source="PROYECTO"
            time=(Get-Item $ws).LastWriteTime
          }
        }
      }
    }
  }

  foreach($root in @("C:\ENGREMIAT_CORE\library\modules","C:\ENGREMIAT_CORE\library\modules_historico")){
    if(Test-Path $root){
      Get-ChildItem $root -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $ws=Join-Path $_.FullName "_workspace"
        if(Test-Path $ws){
          $src=if($root -like "*modules_historico"){"BIB_HIST"}else{"BIBLIOTECA"}
          $workspaceCandidates += [pscustomobject]@{
            module=$_.Name
            path=$_.FullName
            workspace=$ws
            source=$src
            time=(Get-Item $ws).LastWriteTime
          }
        }
      }
    }
  }

  $recent=$workspaceCandidates | Sort-Object time -Descending | Select-Object -First 1
  if($recent){
    $recentModule=$recent.module
    $recentModuleSource=$recent.source
    $recentWorkspace=$recent.workspace
  }

  return [pscustomobject]@{
    project=$p
    project_modules=$mods
    library_active=$libActive
    library_inactive=$libInactive
    library_historic=$libHistoric
    recent_module=$recentModule
    recent_module_source=$recentModuleSource
    recent_workspace=$recentWorkspace
    recent_module_path=if($recent){$recent.path}else{""}
  }
}

function OpenRecentModuleWorkspace(){
  $resolved=ResolveRecentModulePath
  $p=ActiveProject

  if($resolved.found){
    OpenModuleWorkspaceDirect ([string]$resolved.path) ("workspace directo: " + [string]$resolved.name)
    return
  }

  SaveInicioStatus "open_recent_module_workspace_selector" ("recent_module_not_resolved name=" + [string]$resolved.name)
  W "WARN no_se_pudo_resolver_ultimo_modulo; abriendo selector" Yellow
  Start-Sleep -Milliseconds 700

  if($p){ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\desktop-terminal-operator\eng-module-workspace-screen.ps1") -ProjectPath $p }
  else{ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\desktop-terminal-operator\eng-module-workspace-screen.ps1") }
}





function OpenRecentModuleCards(){
  $resolved=ResolveRecentModulePath
  $p=ActiveProject

  if($resolved.found){
    OpenModuleCardsDirect ([string]$resolved.path) ("tarjetas directo: " + [string]$resolved.name)
    return
  }

  SaveInicioStatus "open_recent_module_cards_selector" ("recent_module_not_resolved name=" + [string]$resolved.name)
  W "WARN no_se_pudo_resolver_ultimo_modulo; abriendo selector" Yellow
  Start-Sleep -Milliseconds 700

  if($p){ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\desktop-terminal-operator\eng-module-cards-screen.ps1") -ProjectPath $p }
  else{ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\desktop-terminal-operator\eng-module-cards-screen.ps1") }
}





function ShowHomeDecisionGuide($snapshot,$focus){
  W "LECTURA RAPIDA" Cyan

  if($snapshot.project_modules -eq 0){
    W " - El proyecto activo no tiene módulos detectados: empieza por 4." Yellow
  } else {
    W (" - Proyecto con {0} módulos: puedes trabajar desde 4 o 6." -f $snapshot.project_modules) Green
  }

  if($snapshot.library_active -eq 0){
    W " - Biblioteca sin módulos activos: usa 5 para crear/importar." Yellow
  } else {
    W (" - Biblioteca: {0} activos / {1} inactivos / {2} históricos." -f $snapshot.library_active,$snapshot.library_inactive,$snapshot.library_historic) Green
  }

  if($snapshot.recent_module){
    W (" - Último módulo detectado: {0} ({1}). Usa u o k." -f $snapshot.recent_module,$snapshot.recent_module_source) DarkCyan
  } else {
    W " - Sin módulo reciente: usa 6 para elegir uno." Yellow
  }

  if($focus.screen -and $focus.screen -ne "none"){
    W (" - Último foco guardado: {0}. Usa 1 para continuar." -f $focus.screen) DarkCyan
  } else {
    W " - Sin foco guardado todavía." DarkGray
  }
}
$LauncherLogFile=Join-Path $Core "reports\launcher\last-inicio-log.txt"
$LauncherStatusFile=Join-Path $Core "reports\launcher\last-inicio-status.json"

function LogInicio($msg){
  New-Item -ItemType Directory -Force -Path (Split-Path $LauncherLogFile) | Out-Null
  $line="{0} {1}" -f (Get-Date).ToString("s"),$msg
  Add-Content -Path $LauncherLogFile -Encoding UTF8 -Value $line
}

function SaveInicioStatus($event,$detail){
  $p=ActiveProject
  $f=ReadFocus
  $snap=GetDashboardSnapshot
  [pscustomobject]@{
    event=$event
    detail=$detail
    updated_at=(Get-Date).ToString("s")
    project=$p
    project_name=if($p){Split-Path $p -Leaf}else{""}
    last_focus=$f
    snapshot=$snap
  } | ConvertTo-Json -Depth 30 | Set-Content $LauncherStatusFile -Encoding UTF8
  LogInicio ("event={0} detail={1}" -f $event,$detail)
}

function ShowLastInicioLog(){
  $logFile=Join-Path $Core "reports\launcher\last-inicio-log.txt"

  Clear-Host
  W "==== ÚLTIMO LOG INICIO ====" Cyan
  W ""

  if(Test-Path $logFile){
    Get-Content $logFile -Tail 30 | Write-Host
    W ""
    W ("archivo: {0}" -f $logFile) Green
  } else {
    W "NO_LOG todavía no hay log de inicio." Yellow
    W ""
    W ("archivo esperado: {0}" -f $logFile) DarkGray
  }

  W ""
  W "[Enter] volver al inicio" Cyan
  W ""
  [void](Read-Host "LOG")
}



function ShowCopyableInicioStatus(){
  SaveInicioStatus "manual_status" "copyable_status"

  $statusFile=Join-Path $Core "reports\launcher\last-inicio-status.json"

  Clear-Host
  W "==== ESTADO COPIABLE INICIO ====" Cyan
  W ""

  if(Test-Path $statusFile){
    Get-Content $statusFile -Raw | Write-Host
    W ""
    W "COPIAR archivo: $statusFile" Green
  } else {
    W "NO_GO estado_copiable_no_generado" Yellow
  }

  W ""
  W "[Enter] volver al inicio" Cyan
  W ""
  [void](Read-Host "ESTADO_COPIABLE")
}


function GetInicioRecommendation($snap,$focus){
  if($focus -and $focus.screen -and $focus.screen -ne "none"){
    return [pscustomobject]@{
      label="continuar último foco"
      command="1"
      reason=("foco guardado: " + $focus.screen)
      mode="FOCUS"
    }
  }

  if($snap.recent_module){
    return [pscustomobject]@{
      label="abrir workspace del último módulo"
      command="1"
      reason=("último módulo detectado: " + $snap.recent_module)
      mode="RECENT_WORKSPACE"
    }
  }

  if($snap.project_modules -gt 0){
    return [pscustomobject]@{
      label="abrir módulos del proyecto"
      command="1"
      reason="hay módulos en el proyecto activo"
      mode="MODULES"
    }
  }

  if($snap.library_active -gt 0){
    return [pscustomobject]@{
      label="abrir biblioteca de módulos"
      command="1"
      reason="hay módulos activos reutilizables"
      mode="LIBRARY"
    }
  }

  return [pscustomobject]@{
    label="abrir operador principal"
    command="1"
    reason="no hay foco ni módulo reciente"
    mode="OPERATOR"
  }
}

function SmartStart($snap,$focus){
  $rec=GetInicioRecommendation $snap $focus

  if($rec.mode -eq "FOCUS"){
    SaveInicioStatus "continue_last_focus" "smart_start_focus"
    ContinueLastFocus
    return
  }

  if($rec.mode -eq "RECENT_WORKSPACE"){
    SaveInicioStatus "smart_start_recent_workspace" "opcion_1"
    OpenRecentModuleWorkspace
    return
  }

  if($rec.mode -eq "MODULES"){
    $p=ActiveProject
    if($p){ RunTool "eng-project-modules-screen.ps1" @("-ProjectPath",$p) "modules" "smart_start_modules" }
    else{ RunTool "eng-project-modules-screen.ps1" @() "modules" "smart_start_modules" }
    return
  }

  if($rec.mode -eq "LIBRARY"){
    $p=ActiveProject
    if($p){ RunTool "eng-module-library-screen.ps1" @("-ProjectPath",$p) "library" "smart_start_library" }
    else{ RunTool "eng-module-library-screen.ps1" @() "library" "smart_start_library" }
    return
  }

  OpenMainOperator
}
function GenerateProjectMemoryFiles(){
  $gen=Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1"
  if(-not(Test-Path $gen)){
    W "NO_GO generador_memoria_no_existe" Red
    W $gen Yellow
    P
    return $null
  }

  try{
    $rawResult=& powershell -NoProfile -ExecutionPolicy Bypass -File $gen
    $result=$rawResult | ConvertFrom-Json
    if($result.status -ne "PASS"){
      W "NO_GO memoria_no_generada" Red
      W ($rawResult | Out-String) Yellow
      P
      return $null
    }
    return $result
  }catch{
    W "ERR generando_memoria" Red
    W $_.Exception.Message Yellow
    P
    return $null
  }
}

function OpenGeneratedFile($path,$label){
  if($path -and (Test-Path $path)){
    Start-Process notepad.exe $path
    W ("OK abierto {0}: {1}" -f $label,$path) Green
    Start-Sleep -Milliseconds 700
  }else{
    W ("NO_GO archivo_no_existe {0}: {1}" -f $label,$path) Yellow
    P
  }
}
function ResolveRecentModulePath(){
  $snap=GetDashboardSnapshot
  $p=ActiveProject
  $name=""

  if($snap -and $snap.recent_module){ $name=[string]$snap.recent_module }

  if($snap -and $snap.recent_module_path -and (Test-Path ([string]$snap.recent_module_path))){
    return [pscustomobject]@{ found=$true; name=$name; path=[string]$snap.recent_module_path; source="SNAPSHOT_PATH" }
  }

  if(-not [string]::IsNullOrWhiteSpace($name)){
    $candidates=@()

    if($p){
      $candidates += (Join-Path (Join-Path $p "MODULOS") $name)
    }

    $candidates += (Join-Path (Join-Path $Core "library\modules") $name)
    $candidates += (Join-Path (Join-Path $Core "library\modules_historico") $name)

    foreach($candidate in $candidates){
      if($candidate -and (Test-Path $candidate)){
        return [pscustomobject]@{ found=$true; name=$name; path=$candidate; source="RESOLVED_BY_NAME" }
      }
    }
  }

  return [pscustomobject]@{ found=$false; name=$name; path=""; source="NOT_FOUND" }
}

function OpenModuleWorkspaceDirect($modulePath,$note){
  $p=ActiveProject
  $script=Join-Path $Core "tools\desktop-terminal-operator\eng-module-workspace-screen.ps1"

  if(-not(Test-Path $script)){
    W "NO_GO workspace_script_missing" Red
    W $script Yellow
    P
    return
  }

  if(-not(Test-Path $modulePath)){
    W "NO_GO module_path_missing" Red
    W $modulePath Yellow
    P
    return
  }

  SaveInicioStatus "open_workspace_direct" $modulePath
  & powershell -NoProfile -ExecutionPolicy Bypass -File $script -ProjectPath $p -ModulePath $modulePath
}

function OpenModuleCardsDirect($modulePath,$note){
  $p=ActiveProject
  $script=Join-Path $Core "tools\desktop-terminal-operator\eng-module-cards-screen.ps1"

  if(-not(Test-Path $script)){
    W "NO_GO cards_script_missing" Red
    W $script Yellow
    P
    return
  }

  if(-not(Test-Path $modulePath)){
    W "NO_GO module_path_missing" Red
    W $modulePath Yellow
    P
    return
  }

  SaveInicioStatus "open_cards_direct" $modulePath
  & powershell -NoProfile -ExecutionPolicy Bypass -File $script -ProjectPath $p -ModulePath $modulePath
}
function Main(){
  while($true){
    $p=ActiveProject
    $f=ReadFocus
    $snap=GetDashboardSnapshot
    $rec=GetInicioRecommendation $snap $f

    Clear-Host
    W "==== ENGREMIAT INICIO V30 ====" Cyan
    W "Raíz estable: navegación, memoria viva, diario y selectores seguros" DarkCyan
    W ""

    if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
    else{ W "Proyecto activo: NO_DETECTADO" Yellow }

    W ("Módulos proyecto: {0} | Biblioteca: {1} activos / {2} inactivos / {3} históricos" -f $snap.project_modules,$snap.library_active,$snap.library_inactive,$snap.library_historic) White

    if($snap.recent_module){ W ("Último módulo: {0} [{1}]" -f $snap.recent_module,$snap.recent_module_source) DarkCyan }
    else{ W "Último módulo: -" DarkGray }

    if($f.screen -and $f.screen -ne "none"){ if($f.screen -eq "operator"){ W "Último foco: operator | dashboard humano / operador visual" DarkCyan } else { W ("Último foco: {0} | {1}" -f $f.screen,$f.note) DarkCyan } }
    else{ W "Último foco: sin foco guardado" DarkGray }

    W ("Recomendado: {0}" -f $rec.label) Yellow
    W ("Motivo: {0}" -f $rec.reason) DarkYellow
    W "Acceso rápido: [4] selector workspace normalizado / [5] selector tarjetas normalizado" DarkGray
    W ""

    W "CONTINUAR" Yellow
    W ("[1]  {0}" -f $rec.label) White

    W ""
    W "TRABAJO" Yellow
    W "[2]  módulos del proyecto activo" White
    W "[3]  biblioteca de módulos" White
    W "[4]  workspace de módulo" White
    W "[5]  tarjetas de módulo" White
    W "[6]  abrir carpeta proyecto activo" White
    W "[7]  dashboard humano / operador visual" White

    W ""
    W "REVISAR / AYUDA" Yellow
    W "[8]  árbol de navegación seguro" White
    W "[9]  rutas recomendadas" White
    W "[10] ayuda" White
    W "[11] estado técnico" White
    W "[12] estado copiable" White
    W "[13] status externo" White
    W "[14] ver último log" White

    W ""
    W "MEMORIA" Yellow
    W "[15] memoria y documentación" White
    W "[16] generar/abrir prompt continuidad ChatGPT" White
    W "[17] generar/abrir prompt worker Ollama/Cline" White
    W "[18] abrir diario de desarrollo" White
    W "[19] añadir entrada al diario" White

    W ""
    W "MANTENIMIENTO" Yellow
    W "[20] refrescar grafo de módulos" White
    W "[21] abrir C:\ENGREMIAT_CORE" White

    W ""
    W "[q] salir | [Enter] refrescar" Cyan
    W ""

    $cmd=Read-Host "ENGREMIAT_INICIO"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "q"){ return }

    if($cmd -eq "1"){ SmartStart $snap $f; continue }

    if($cmd -eq "2"){
      if($p){ RunTool "eng-project-modules-screen.ps1" @("-ProjectPath",$p) "modules" "modulos proyecto" }
      else{ RunTool "eng-project-modules-screen.ps1" @() "modules" "modulos proyecto" }
      continue
    }

    if($cmd -eq "3"){
      if($p){ RunTool "eng-module-library-screen.ps1" @("-ProjectPath",$p) "library" "biblioteca modulos" }
      else{ RunTool "eng-module-library-screen.ps1" @() "library" "biblioteca modulos" }
      continue
    }

    if($cmd -eq "4"){
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-SELECT-MODULE-SAFE.ps1") -Mode workspace -ProjectPath $p
      continue
    }

    if($cmd -eq "5"){
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-SELECT-MODULE-SAFE.ps1") -Mode cards -ProjectPath $p
      continue
    }

    if($cmd -eq "6"){
      if($p){ OpenFolder $p }
      else{ W "NO_GO proyecto_activo_no_detectado" Yellow; P }
      continue
    }

    if($cmd -eq "7"){ OpenMainOperator; continue }

    if($cmd -eq "8"){
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-SAFE.ps1")
      continue
    }

    if($cmd -eq "9"){ Routes; continue }
    if($cmd -eq "10"){ SaveInicioStatus "help" "ayuda"; Help; continue }
    if($cmd -eq "11"){ Status; continue }
    if($cmd -eq "12"){ ShowCopyableInicioStatus; continue }
    if($cmd -eq "13"){ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-INICIO-STATUS.ps1"); continue }
    if($cmd -eq "14"){ ShowLastInicioLog; continue }

    if($cmd -eq "15"){
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER.ps1")
      continue
    }

    if($cmd -eq "16"){
      $result=GenerateProjectMemoryFiles
      if($result){ OpenGeneratedFile $result.chatgpt_prompt "prompt_chatgpt" }
      continue
    }

    if($cmd -eq "17"){
      $result=GenerateProjectMemoryFiles
      if($result){ OpenGeneratedFile $result.worker_prompt "prompt_worker" }
      continue
    }

    if($cmd -eq "18"){
      $result=GenerateProjectMemoryFiles
      $diary=Join-Path $Core "memory\project-memory\development-diary-latest.md"
      if(Test-Path $diary){ Start-Process notepad.exe $diary }
      else{ W "NO_GO diario_no_generado" Yellow; P }
      continue
    }

    if($cmd -eq "19"){
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-DIARY-ADD.ps1")
      & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1") | Out-Null
      W "OK diario_actualizado_y_memoria_regenerada" Green
      P
      continue
    }

    if($cmd -eq "20"){
      if($p){ RunTool "eng-refresh-project-module-graph.ps1" @("-ProjectPath",$p) "graph" "refrescar grafo" }
      else{ RunTool "eng-refresh-project-module-graph.ps1" @() "graph" "refrescar grafo" }
      continue
    }

    if($cmd -eq "21"){ OpenFolder $Core; continue }

    W "WARN comando_no_reconocido. Usa solo números, q o Enter." Yellow
    P
  }
}

























Main






























