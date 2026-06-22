$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$MemoryDir=Join-Path $Core "memory\project-memory"
$ReportsDir=Join-Path $Core "reports"
$ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
$DiaryJsonl=Join-Path $MemoryDir "development-diary.jsonl"
$DiaryMd=Join-Path $MemoryDir "development-diary-latest.md"
New-Item -ItemType Directory -Force -Path $MemoryDir | Out-Null
function ActiveProject(){
  $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
  $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
  if(Test-Path $j){ try{ $x=Get-Content $j -Raw | ConvertFrom-Json; if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project } }catch{} }
  if(Test-Path $t){ $y=(Get-Content $t -Raw).Trim(); if(Test-Path $y){ return $y } }
  return ""
}
function CountDirs($p){ if(Test-Path $p){ return @(Get-ChildItem $p -Directory -ErrorAction SilentlyContinue).Count }; return 0 }
function Screen($id,$label,$path){ return [pscustomobject]@{ id=$id; label=$label; path=$path; exists=(Test-Path $path) } }
function LatestReports($limit){
  if(-not(Test-Path $ReportsDir)){ return @() }
  $files=Get-ChildItem $ReportsDir -Recurse -File -Include *.json -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First $limit
  $items=@()
  foreach($f in $files){
    $status="UNKNOWN"; $package=""; $stage=""; $next=""; $summary=""
    try{
      $j=Get-Content $f.FullName -Raw | ConvertFrom-Json
      if($j.status){ $status=[string]$j.status }
      if($j.package){ $package=[string]$j.package }
      if($j.stage){ $stage=[string]$j.stage }
      if($j.next){ $next=[string]$j.next }
      if($j.inicio){ $summary="inicio="+[string]$j.inicio }
      elseif($j.start_ps1){ $summary="start="+[string]$j.start_ps1 }
      elseif($j.memory_ps1){ $summary="memory="+[string]$j.memory_ps1 }
    }catch{}
    $items += [pscustomobject]@{ name=$f.Name; path=$f.FullName; updated=$f.LastWriteTime.ToString("s"); status=$status; package=$package; stage=$stage; next=$next; summary=$summary }
  }
  return $items
}
function DiaryEntries($limit){
  if(-not(Test-Path $DiaryJsonl)){ return @() }
  $raw=Get-Content $DiaryJsonl -ErrorAction SilentlyContinue | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Last $limit
  $items=@()
  foreach($line in $raw){ try{ $items += ($line | ConvertFrom-Json) }catch{} }
  return $items
}
function BuildMemory(){
  $project=ActiveProject
  $projectName=if($project){ Split-Path $project -Leaf }else{ "" }
  $projectModules=0
  if($project){ $projectModules=CountDirs (Join-Path $project "MODULOS") }
  $libRoot=Join-Path $Core "library\modules"
  $histRoot=Join-Path $Core "library\modules_historico"
  $libActive=0; $libInactive=0; $libHistoric=CountDirs $histRoot
  if(Test-Path $libRoot){
    foreach($m in (Get-ChildItem $libRoot -Directory -ErrorAction SilentlyContinue)){
      $st="ACTIVO"; $mj=Join-Path $m.FullName "module.json"
      if(Test-Path $mj){ try{ $mjx=Get-Content $mj -Raw | ConvertFrom-Json; if($mjx.status){ $st=[string]$mjx.status } }catch{} }
      if($st -eq "INACTIVO"){ $libInactive++ } else { $libActive++ }
    }
  }
  $screens=@()
  $screens += Screen "inicio" "Inicio" (Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1")
  $screens += Screen "memory_generate" "Generador memoria viva" (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1")
  $screens += Screen "diary_add" "Añadir diario" (Join-Path $Core "tools\launcher\ENGREMIAT-PROJECT-DIARY-ADD.ps1")
  $screens += Screen "navigation_tree" "Árbol navegación" (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-TREE.ps1")
  $screens += Screen "navigation_viewer" "Visor árbol" (Join-Path $Core "tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1")
  $screens += Screen "modules" "Módulos proyecto" (Join-Path $ToolDir "eng-project-modules-screen.ps1")
  $screens += Screen "library" "Biblioteca módulos" (Join-Path $ToolDir "eng-module-library-screen.ps1")
  $screens += Screen "workspace" "Workspace módulo" (Join-Path $ToolDir "eng-module-workspace-screen.ps1")
  $screens += Screen "cards" "Tarjetas módulo" (Join-Path $ToolDir "eng-module-cards-screen.ps1")
  $screens += Screen "graph" "Grafo módulos" (Join-Path $ToolDir "eng-refresh-project-module-graph.ps1")
  $reports=LatestReports 25
  $diary=DiaryEntries 30
  $built=@()
  foreach($r in ($reports | Where-Object { $_.status -eq "PASS" } | Select-Object -First 12)){
    if($r.package){ $built += ("Report PASS: " + $r.package) }
    elseif($r.name){ $built += ("Report PASS: " + $r.name) }
  }
  if($built.Count -eq 0){ $built += "Memoria viva creada; aún faltan reports útiles para inferir construido." }
  $learned=@()
  foreach($d in $diary){ if($d.learned){ $learned += [string]$d.learned } }
  if($learned.Count -eq 0){ $learned += "La memoria debe alimentarse con diario + reports reales, no solo texto simulado." }
  $pending=@()
  foreach($r in ($reports | Where-Object { $_.next } | Select-Object -First 8)){ $pending += ("NEXT desde report: " + $r.next) }
  foreach($d in $diary){ if($d.next){ $pending += [string]$d.next } }
  if($pending.Count -eq 0){ $pending += "Repasar árbol de navegación y crear pantalla avanzada de tareas." }
  return [pscustomobject]@{ generated_at=(Get-Date).ToString("s"); mode="LIVE_MEMORY_FROM_REPORTS_AND_DIARY"; core=$Core; active_project=$project; active_project_name=$projectName; counters=[pscustomobject]@{ project_modules=$projectModules; library_active=$libActive; library_inactive=$libInactive; library_historic=$libHistoric }; screens=$screens; latest_reports=$reports; diary_recent=$diary; built=$built; learned=($learned | Select-Object -Unique); pending=($pending | Select-Object -Unique); recommended_next=($pending | Select-Object -First 1) }
}
function WriteDiaryMd($entries){
  $out=@(); $out += "# ENGREMIAT - Diario de desarrollo"; $out += ""; $out += "- Generado: $(Get-Date -Format s)"; $out += "";
  if($entries.Count -eq 0){ $out += "Sin entradas todavía." }
  foreach($e in $entries){
    $out += "## $($e.time) - $($e.title)"
    if($e.summary){ $out += "- Resumen: $($e.summary)" }
    if($e.learned){ $out += "- Aprendido: $($e.learned)" }
    if($e.next){ $out += "- Siguiente: $($e.next)" }
    if($e.source){ $out += "- Fuente: $($e.source)" }
    $out += ""
  }
  $out | Set-Content $DiaryMd -Encoding UTF8
}
function WriteMemory($m){
  $json=Join-Path $MemoryDir "project-memory-latest.json"; $md=Join-Path $MemoryDir "project-memory-latest.md"; $chat=Join-Path $MemoryDir "continuation-prompt-latest.md"; $worker=Join-Path $MemoryDir "ollama-worker-prompt-latest.md"
  $m | ConvertTo-Json -Depth 80 | Set-Content $json -Encoding UTF8
  WriteDiaryMd $m.diary_recent
  $out=@(); $out += "# ENGREMIAT - Memoria viva del proyecto"; $out += ""; $out += "- Generado: $($m.generated_at)"; $out += "- Modo: $($m.mode)"; $out += "- Proyecto activo: $($m.active_project_name)"; $out += "- Módulos proyecto: $($m.counters.project_modules)"; $out += "- Biblioteca: $($m.counters.library_active) activos / $($m.counters.library_inactive) inactivos / $($m.counters.library_historic) históricos"; $out += ""; $out += "## Qué se ha construido inferido de reports"; foreach($x in $m.built){ $out += "- $x" }; $out += ""; $out += "## Qué se ha aprendido desde diario"; foreach($x in $m.learned){ $out += "- $x" }; $out += ""; $out += "## Pendiente inferido"; foreach($x in $m.pending){ $out += "- $x" }; $out += ""; $out += "## Últimos reports"; foreach($r in ($m.latest_reports | Select-Object -First 12)){ $out += "- [$($r.status)] $($r.name) · package=$($r.package) · next=$($r.next)" }; $out += ""; $out += "## Pantallas"; foreach($s in $m.screens){ $ok=if($s.exists){"OK"}else{"MISS"}; $out += "- [$ok] $($s.label): $($s.path)" }; $out += ""; $out += "## Siguiente recomendado"; $out += "- $($m.recommended_next)"; $out | Set-Content $md -Encoding UTF8
  $cp=@(); $cp += "CONTEXTO ENGREMIAT PARA CONTINUAR DESARROLLO"; $cp += ""; $cp += "Actúa como experto en ENGREMIAT / operador local PowerShell."; $cp += "Proyecto activo: $($m.active_project_name)"; $cp += "Memoria generada desde reports reales y diario de desarrollo."; $cp += ""; $cp += "Construido inferido:"; foreach($x in $m.built){ $cp += "- $x" }; $cp += ""; $cp += "Aprendido desde diario:"; foreach($x in $m.learned){ $cp += "- $x" }; $cp += ""; $cp += "Pendiente inferido:"; foreach($x in $m.pending){ $cp += "- $x" }; $cp += ""; $cp += "Siguiente recomendado: $($m.recommended_next)"; $cp += ""; $cp += "Entrega esperada: breve explicación y script PowerShell completo, estable, validado y sin pedir confirmación si el siguiente paso es claro."; $cp | Set-Content $chat -Encoding UTF8
  $wp=@(); $wp += "WORKER PROMPT - ENGREMIAT"; $wp += ""; $wp += "Rol: worker local controlado. No ejecutes acciones externas."; $wp += "Memoria generada desde reports reales y diario."; $wp += "Tarea recomendada: $($m.recommended_next)."; $wp += ""; $wp += "Contexto construido:"; foreach($x in $m.built){ $wp += "- $x" }; $wp += ""; $wp += "Contrato de salida: resumen, archivos afectados, riesgos, propuesta y validación esperada."; $wp | Set-Content $worker -Encoding UTF8
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
  return [pscustomobject]@{ json=$json; md=$md; diary=$DiaryMd; chatgpt_prompt=$chat; worker_prompt=$worker }
}
$m=BuildMemory
$files=WriteMemory $m
[pscustomobject]@{ status="PASS"; generated_at=$m.generated_at; mode=$m.mode; memory_json=$files.json; memory_md=$files.md; diary_md=$files.diary; chatgpt_prompt=$files.chatgpt_prompt; worker_prompt=$files.worker_prompt; recommended_next=$m.recommended_next } | ConvertTo-Json -Depth 20
