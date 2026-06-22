$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$MemoryDir=Join-Path $Core "memory\project-memory"
$ReportsDir=Join-Path $Core "reports"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
New-Item -ItemType Directory -Force -Path $MemoryDir | Out-Null
function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }
function ActiveProject(){
  $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
  $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
  if(Test-Path $j){ try{ $x=Get-Content $j -Raw | ConvertFrom-Json; if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project } }catch{} }
  if(Test-Path $t){ $y=(Get-Content $t -Raw).Trim(); if(Test-Path $y){ return $y } }
  return ""
}
function CountDirs($p){ if(Test-Path $p){ return @(Get-ChildItem $p -Directory -ErrorAction SilentlyContinue).Count }; return 0 }
function Screen($id,$label,$path){ return [pscustomobject]@{ id=$id; label=$label; path=$path; exists=(Test-Path $path) } }
function BuildMemory(){
  $project=ActiveProject
  $projectName=if($project){ Split-Path $project -Leaf }else{ "" }
  $projectModules=0
  if($project){ $projectModules=CountDirs (Join-Path $project "MODULOS") }
  $libActiveRoot=Join-Path $Core "library\modules"
  $libHistRoot=Join-Path $Core "library\modules_historico"
  $libActive=0; $libInactive=0; $libHistoric=CountDirs $libHistRoot
  if(Test-Path $libActiveRoot){
    foreach($m in (Get-ChildItem $libActiveRoot -Directory -ErrorAction SilentlyContinue)){
      $st="ACTIVO"; $mj=Join-Path $m.FullName "module.json"
      if(Test-Path $mj){ try{ $j=Get-Content $mj -Raw | ConvertFrom-Json; if($j.status){ $st=[string]$j.status } }catch{} }
      if($st -eq "INACTIVO"){ $libInactive++ } else { $libActive++ }
    }
  }
  $screens=@()
  $screens += Screen "inicio" "Inicio" (Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1")
  $screens += Screen "memory" "Memoria proyecto" (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY.ps1")
  $screens += Screen "navigation_tree" "Árbol navegación" (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-TREE.ps1")
  $screens += Screen "navigation_viewer" "Visor árbol" (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1")
  $screens += Screen "modules" "Módulos proyecto" (Join-Path $ToolDir "eng-project-modules-screen.ps1")
  $screens += Screen "library" "Biblioteca módulos" (Join-Path $ToolDir "eng-module-library-screen.ps1")
  $screens += Screen "workspace" "Workspace módulo" (Join-Path $ToolDir "eng-module-workspace-screen.ps1")
  $screens += Screen "cards" "Tarjetas módulo" (Join-Path $ToolDir "eng-module-cards-screen.ps1")
  $screens += Screen "graph" "Grafo módulos" (Join-Path $ToolDir "eng-refresh-project-module-graph.ps1")
  $built=@("Inicio V10 con navegación numérica, diagnóstico y memoria.","Diagnóstico externo con status copiable.","Árbol de navegación y visor.","Pantalla de módulos del proyecto.","Biblioteca de módulos con activos, inactivos e históricos.","Workspace operativo de módulo.","Pantalla avanzada de tarjetas.","Refresco de grafo de módulos.")
  $learned=@("El inicio debe ser raíz ligera.","En inicio solo números para navegar; q salir; Enter refrescar.","Pantallas profundas pueden usar letras para acciones internas.","Patrón repetible: lista, ficha, crear, desactivar, historizar, borrar, buscar y vincular.","La memoria debe separar construido, aprendido, pendiente y prompts de continuidad.","Primero estabilidad, luego inteligencia.")
  $pending=@("Crear pantalla avanzada de tareas equivalente a tarjetas.","Vincular tarjetas con tareas.","Extender grafo a tarjetas, tareas, tipos y enlaces.","Normalizar árbol de navegación tras cada pantalla.","Mejorar prompts de continuidad ChatGPT/Ollama/Cline.")
  return [pscustomobject]@{ generated_at=(Get-Date).ToString("s"); core=$Core; active_project=$project; active_project_name=$projectName; counters=[pscustomobject]@{ project_modules=$projectModules; library_active=$libActive; library_inactive=$libInactive; library_historic=$libHistoric }; screens=$screens; built=$built; learned=$learned; pending=$pending; recommended_next="E24A_CREATE_MODULE_TASKS_MANAGEMENT_SCREEN" }
}
function WriteMemory($m){
  $json=Join-Path $MemoryDir "project-memory-latest.json"; $md=Join-Path $MemoryDir "project-memory-latest.md"; $chat=Join-Path $MemoryDir "continuation-prompt-latest.md"; $worker=Join-Path $MemoryDir "ollama-worker-prompt-latest.md"
  $m | ConvertTo-Json -Depth 50 | Set-Content $json -Encoding UTF8
  $out=@(); $out += "# ENGREMIAT - Memoria del proyecto"; $out += ""; $out += "- Generado: $($m.generated_at)"; $out += "- Proyecto activo: $($m.active_project_name)"; $out += "- Módulos proyecto: $($m.counters.project_modules)"; $out += "- Biblioteca: $($m.counters.library_active) activos / $($m.counters.library_inactive) inactivos / $($m.counters.library_historic) históricos"; $out += ""; $out += "## Qué se ha construido"; foreach($x in $m.built){ $out += "- $x" }; $out += ""; $out += "## Qué se ha aprendido"; foreach($x in $m.learned){ $out += "- $x" }; $out += ""; $out += "## Pendiente"; foreach($x in $m.pending){ $out += "- $x" }; $out += ""; $out += "## Pantallas"; foreach($s in $m.screens){ $ok=if($s.exists){"OK"}else{"MISS"}; $out += "- [$ok] $($s.label): $($s.path)" }; $out += ""; $out += "## Siguiente recomendado"; $out += "- $($m.recommended_next)"; $out | Set-Content $md -Encoding UTF8
  $cp=@(); $cp += "CONTEXTO ENGREMIAT PARA CONTINUAR DESARROLLO"; $cp += ""; $cp += "Actúa como experto en ENGREMIAT / operador local PowerShell."; $cp += "Proyecto activo: $($m.active_project_name)"; $cp += "Estado: inicio V10 con navegación numérica, diagnóstico, memoria y prompts."; $cp += ""; $cp += "Construido:"; foreach($x in $m.built){ $cp += "- $x" }; $cp += ""; $cp += "Aprendido / normas:"; foreach($x in $m.learned){ $cp += "- $x" }; $cp += ""; $cp += "Siguiente recomendado: $($m.recommended_next)"; $cp += "Objetivo: crear pantalla avanzada de tareas equivalente a tarjetas y conectarla al workspace."; $cp += ""; $cp += "Entrega esperada: breve explicación y script PowerShell completo, estable, validado y sin pedir confirmación si el siguiente paso es claro."; $cp | Set-Content $chat -Encoding UTF8
  $wp=@(); $wp += "WORKER PROMPT - ENGREMIAT"; $wp += ""; $wp += "Rol: worker local controlado. No ejecutes acciones externas."; $wp += "Tarea: $($m.recommended_next)."; $wp += "Objetivo: proponer o revisar pantalla avanzada de tareas de módulo siguiendo el patrón de tarjetas."; $wp += "Salida: resumen, archivos afectados, riesgos, propuesta, validación esperada."; $wp | Set-Content $worker -Encoding UTF8
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
  return [pscustomobject]@{ json=$json; md=$md; chatgpt_prompt=$chat; worker_prompt=$worker }
}
function Show(){
  $m=BuildMemory; $files=WriteMemory $m
  Clear-Host; W "==== MEMORIA DEL PROYECTO ====" Cyan; W ("Proyecto activo: {0}" -f $m.active_project_name) Green; W ("Módulos proyecto: {0}" -f $m.counters.project_modules) White; W ("Biblioteca: {0} activos / {1} inactivos / {2} históricos" -f $m.counters.library_active,$m.counters.library_inactive,$m.counters.library_historic) White; W ""; W "CONSTRUIDO" Yellow; foreach($x in $m.built){ W (" - {0}" -f $x) White }; W ""; W "SIGUIENTE" Yellow; W (" - {0}" -f $m.recommended_next) Green; W ""; W "1 = abrir memoria MD | 2 = prompt ChatGPT | 3 = prompt Ollama/Cline | 4 = regenerar | b = atrás" Cyan
  $cmd=Read-Host "MEMORIA"
  if($cmd -eq "1"){ Start-Process notepad.exe $files.md }
  elseif($cmd -eq "2"){ Start-Process notepad.exe $files.chatgpt_prompt }
  elseif($cmd -eq "3"){ Start-Process notepad.exe $files.worker_prompt }
  elseif($cmd -eq "4"){ $m2=BuildMemory; WriteMemory $m2 | Out-Null; W "OK memoria_regenerada" Green; P }
  elseif($cmd -eq "b"){ return $false }
  return $true
}
while($true){ $keep=Show; if(-not $keep){ break } }
