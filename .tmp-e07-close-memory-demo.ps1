$ErrorActionPreference = 'Stop'

$root = (Get-Location).Path
$objective = 'ENGREMIAT_CORE_MVP_001'
$stage = 'E07'
$stamp = (Get-Date).ToString('yyyyMMdd-HHmmss')

function C([string]$color, [string]$message) { Write-Host $message -ForegroundColor $color }

function TS($value) {
  if ($null -eq $value) { return '' }
  return [string]$value
}

function To-JsonText($obj) {
  return ($obj | ConvertTo-Json -Depth 100)
}

function Save-Json([string]$path, $obj) {
  $dir = Split-Path -Parent $path
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  To-JsonText $obj | Set-Content -LiteralPath $path -Encoding UTF8
}

function Read-JsonSafe([string]$path) {
  try {
    return (Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop)
  } catch {
    return $null
  }
}

function RelativePath([string]$path) {
  if ($path.StartsWith($root)) {
    return $path.Substring($root.Length).TrimStart('\')
  }
  return $path
}

try {
  foreach ($rel in @('reports','docs','data\state','data\evidence','data\events','tmp')) {
    $dir = Join-Path $root $rel
    if (-not (Test-Path -LiteralPath $dir)) {
      New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
  }

  $required = @(
    'data\events\events.jsonl',
    'data\state\network-state.json',
    'data\state\project-state.json',
    'data\state\task-queue.json',
    'data\state\evidence-index.json',
    'docs\CURRENT_STATE.md',
    'docs\MVP_REPORT.md',
    'reports\index.html',
    'reports\node-network.mmd',
    'reports\project-task-map.mmd',
    'reports\task-lifecycle.mmd'
  )

  $missing = @()
  foreach ($rel in $required) {
    $p = Join-Path $root $rel
    if (-not (Test-Path -LiteralPath $p)) {
      $missing += $rel
    }
  }

  if (@($missing).Count -gt 0) {
    $noGo = [ordered]@{
      ok = $false
      objective = $objective
      stage = $stage
      decision = 'NO_GO'
      reason = 'REQUIRED_E06_ARTIFACTS_MISSING'
      missing = $missing
      git = $false
      network = $false
      remote_execution = $false
    }
    $noGoPath = Join-Path $root "reports\e07-missing-artifacts.$stamp.json"
    Save-Json $noGoPath $noGo
    C Yellow "NO_GO objective=$objective stage=$stage reason=REQUIRED_E06_ARTIFACTS_MISSING missing=$(@($missing).Count) report=$noGoPath next=REPAIR_E06"
    throw 'Faltan artefactos requeridos de E06; no se puede cerrar E07.'
  }

  $eventsPath = Join-Path $root 'data\events\events.jsonl'
  $events = @()
  foreach ($line in (Get-Content -LiteralPath $eventsPath -Encoding UTF8)) {
    if (-not $line) { continue }
    try { $events += @($line | ConvertFrom-Json -ErrorAction Stop) } catch { }
  }

  $networkStatePath = Join-Path $root 'data\state\network-state.json'
  $projectStatePath = Join-Path $root 'data\state\project-state.json'
  $taskQueuePath = Join-Path $root 'data\state\task-queue.json'
  $evidenceIndexPath = Join-Path $root 'data\state\evidence-index.json'

  $networkState = Read-JsonSafe $networkStatePath
  $projectState = Read-JsonSafe $projectStatePath
  $taskQueue = Read-JsonSafe $taskQueuePath
  $evidenceIndex = Read-JsonSafe $evidenceIndexPath

  $latestProject = ''
  $latestTask = ''
  $latestWorker = ''
  $latestRun = ''
  $latestEvidence = ''

  if ($null -ne $projectState) {
    $latestProject = TS $projectState.project_id
    $latestTask = TS $projectState.last_task_id
    $latestWorker = TS $projectState.last_worker_id
    $latestRun = TS $projectState.last_run_id
    $latestEvidence = TS $projectState.last_evidence_id
  }

  $artifactPatterns = @(
    'data\events\*.jsonl',
    'data\state\*.json',
    'data\evidence\*.json',
    'data\evidence\*.sha256',
    'data\executions\*.json',
    'docs\*.md',
    'reports\*.json',
    'reports\*.html',
    'reports\*.mmd',
    'evidence\*\*.json',
    'evidence\*\*.md',
    'evidence\*\*.log'
  )

  $artifactFiles = @()
  foreach ($pattern in $artifactPatterns) {
    $artifactFiles += @(Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue |
      Where-Object {
        $rel = RelativePath $_.FullName
        $match = $false
        foreach ($pat in $artifactPatterns) {
          if ($rel -like $pat) { $match = $true }
        }
        $match -and ($_.FullName -notmatch '\\node_modules\\|\\.git\\|\\tmp\\')
      })
    break
  }

  $artifactFiles = @($artifactFiles | Sort-Object FullName -Unique)

  $manifestItems = @()
  foreach ($file in $artifactFiles) {
    $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    $manifestItems += [ordered]@{
      path = $file.FullName
      relative_path = RelativePath $file.FullName
      type = $file.Extension.TrimStart('.')
      bytes = $file.Length
      sha256 = $hash
      last_write_time = $file.LastWriteTime.ToString('o')
    }
  }

  $manifest = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    generated_at = (Get-Date).ToString('o')
    description = 'Paquete local verificable del MVP ENGREMIAT_CORE_MVP_001'
    artifacts = $manifestItems
    counters = [ordered]@{
      artifacts = @($manifestItems).Count
      events = @($events).Count
      tasks = if ($null -ne $taskQueue -and $taskQueue.PSObject.Properties.Name -contains 'counters') { $taskQueue.counters.total } else { 0 }
      evidence_items = if ($null -ne $evidenceIndex -and $evidenceIndex.PSObject.Properties.Name -contains 'counters') { $evidenceIndex.counters.files } else { 0 }
    }
    latest = [ordered]@{
      project_id = $latestProject
      task_id = $latestTask
      worker_id = $latestWorker
      run_id = $latestRun
      evidence_id = $latestEvidence
    }
    safety = [ordered]@{
      local_only = $true
      network = $false
      git = $false
      remote_execution = $false
      external_systems_touched = $false
    }
    next = 'DEFINE_NEXT_OBJECTIVE_AFTER_CORE_MVP'
  }

  $manifestPath = Join-Path $root 'manifest.json'
  Save-Json $manifestPath $manifest

  $checksumsPath = Join-Path $root 'checksums.sha256'
  ($manifestItems | ForEach-Object { $_.sha256 + '  ' + $_.relative_path }) | Set-Content -LiteralPath $checksumsPath -Encoding UTF8

  $timelinePath = Join-Path $root 'docs\TIMELINE.md'
  $decisionsPath = Join-Path $root 'docs\DECISIONS.md'
  $lessonsPath = Join-Path $root 'docs\LESSONS.md'
  $closePath = Join-Path $root 'docs\CLOSE.md'
  $nextObjectivePath = Join-Path $root 'docs\NEXT_OBJECTIVE.md'
  $executiveSummaryPath = Join-Path $root 'docs\EXECUTIVE_SUMMARY.md'
  $technicalSummaryPath = Join-Path $root 'docs\TECHNICAL_SUMMARY.md'
  $demoScriptPath = Join-Path $root 'docs\DEMO_SCRIPT.md'

  $timeline = @()
  $timeline += '# TIMELINE — ENGREMIAT_CORE_MVP_001'
  $timeline += ''
  $timeline += "Generado: $((Get-Date).ToString('o'))"
  $timeline += ''
  $timeline += '| Orden | Timestamp | Evento | Entidad | Trace |'
  $timeline += '|---:|---|---|---|---|'
  $i = 0
  foreach ($event in $events) {
    $i++
    $timeline += "| $i | $(TS $event.timestamp) | $(TS $event.event_type) | $(TS $event.entity_id) | $(TS $event.trace_id) |"
  }
  $timeline | Set-Content -LiteralPath $timelinePath -Encoding UTF8

  @(
    '# DECISIONS — ENGREMIAT_CORE_MVP_001'
    ''
    '## Decisiones de diseño consolidadas'
    ''
    '- El core funciona en modo LOCAL_ONLY.'
    '- La ejecución real queda fuera del MVP.'
    '- El estado se reconstruye desde eventos y artefactos locales.'
    '- La evidencia se genera, indexa y verifica con SHA256.'
    '- El dashboard HTML es estático y local.'
    '- Mermaid se usa como salida visual ligera y portable.'
    '- Git, red, IA externa, workers remotos y sistemas externos quedan fuera de este cierre.'
    ''
    '## Decisión final'
    ''
    'El MVP queda cerrado como núcleo operativo simulado, verificable y presentable.'
  ) | Set-Content -LiteralPath $decisionsPath -Encoding UTF8

  @(
    '# LESSONS — ENGREMIAT_CORE_MVP_001'
    ''
    '## Lecciones aprendidas'
    ''
    '- El flujo por etapas evita construir inteligencia antes de tener trazabilidad.'
    '- El ledger append-only permite explicar qué ocurrió sin depender de memoria conversacional.'
    '- Los leases fuerzan una frontera clara: no hay ejecución sin reserva activa.'
    '- La evidencia mínima debe ser humana y verificable por máquina.'
    '- El HTML local permite revisar el MVP sin instalar herramientas pesadas.'
    '- PowerShell 5.1 requiere evitar sintaxis moderna como operadores ternarios.'
    ''
    '## Mejora para la siguiente iteración'
    ''
    'Convertir estos scripts en comandos reutilizables del operador local para reducir pegado manual.'
  ) | Set-Content -LiteralPath $lessonsPath -Encoding UTF8

  @(
    '# CLOSE — ENGREMIAT_CORE_MVP_001'
    ''
    '## Estado de cierre'
    ''
    '- objective_closed: true'
    '- mvp_operativo_simulado: true'
    '- evidencia_verificable: true'
    '- dashboard_local: true'
    '- manifest: true'
    '- checksums: true'
    '- git: false'
    '- network: false'
    '- remote_execution: false'
    ''
    '## Último estado'
    ''
    "- project_id: $latestProject"
    "- task_id: $latestTask"
    "- worker_id: $latestWorker"
    "- run_id: $latestRun"
    "- evidence_id: $latestEvidence"
    ''
    '## Resultado'
    ''
    'ENGREMIAT_CORE_MVP_001 queda consolidado como paquete local demostrable.'
  ) | Set-Content -LiteralPath $closePath -Encoding UTF8

  @(
    '# NEXT_OBJECTIVE — propuesta'
    ''
    '## Siguiente objetivo recomendado'
    ''
    'ENGREMIAT_CORE_MVP_002 — Convertir el MVP local en núcleo reutilizable con comandos estables.'
    ''
    '## Objetivo'
    ''
    'Pasar de scripts de etapa a una pequeña herramienta local que permita ejecutar: init, seed, project, match, offer, lease, simulate, evidence, report, close.'
    ''
    '## Mantener fuera todavía'
    ''
    '- Red real'
    '- Git remoto automático'
    '- Workers remotos'
    '- IA obligatoria'
    '- Telegram'
    '- Google Sheets'
    ''
    '## Primer bloque recomendado'
    ''
    'Crear `tools/engremiat-core.ps1` como orquestador local reusable.'
  ) | Set-Content -LiteralPath $nextObjectivePath -Encoding UTF8

  @(
    '# EXECUTIVE_SUMMARY — ENGREMIAT_CORE_MVP_001'
    ''
    'ENGREMIAT_CORE_MVP_001 demuestra un núcleo operativo local capaz de organizar un proyecto, representar tareas, seleccionar worker mediante matching previo, generar oferta/autorización/lease, simular ejecución, producir evidencia verificable, cerrar tarea y actualizar estado.'
    ''
    '## Valor'
    ''
    'El sistema deja de ser solo una idea conceptual y pasa a tener un ciclo local verificable con trazabilidad, evidencia y visualización.'
    ''
    '## Límites'
    ''
    'No ejecuta acciones reales, no usa red, no usa IA externa y no depende de herramientas pesadas.'
    ''
    '## Entregables'
    ''
    '- Estado de red JSON'
    '- Cola de tareas'
    '- Índice de evidencias'
    '- Ledger de eventos'
    '- Manifest y checksums'
    '- Dashboard HTML'
    '- Diagramas Mermaid'
    '- Memoria documental'
  ) | Set-Content -LiteralPath $executiveSummaryPath -Encoding UTF8

  @(
    '# TECHNICAL_SUMMARY — ENGREMIAT_CORE_MVP_001'
    ''
    '## Arquitectura técnica'
    ''
    '- JSON/JSONL como formato canónico.'
    '- Ledger append-only en `data/events/events.jsonl`.'
    '- Estado derivado en `data/state/`.'
    '- Evidencia en `evidence/` y `data/evidence/`.'
    '- Documentación en `docs/`.'
    '- Reportes y Mermaid en `reports/`.'
    ''
    '## Ciclo validado'
    ''
    'project/task → matching → offer → policy → lease → simulated execution → evidence → verification → close → digital twin → manifest.'
    ''
    '## Seguridad'
    ''
    'Todo el cierre es LOCAL_ONLY: no red, no Git, no ejecución remota, no sistemas externos.'
  ) | Set-Content -LiteralPath $technicalSummaryPath -Encoding UTF8

  @(
    '# DEMO_SCRIPT — ENGREMIAT_CORE_MVP_001'
    ''
    '## Demo rápida'
    ''
    '1. Abrir `reports/index.html`.'
    '2. Revisar el estado del proyecto, tarea, worker, run y evidencia.'
    '3. Abrir `data/state/network-state.json` para ver el estado de red derivado.'
    '4. Abrir `data/state/task-queue.json` para ver la cola de tareas.'
    '5. Abrir `data/state/evidence-index.json` para comprobar evidencias indexadas.'
    '6. Revisar `evidence/<RUN_ID>/summary.md` y `stdout.log`.'
    '7. Abrir `manifest.json` y `checksums.sha256` para validar integridad.'
    '8. Mostrar los diagramas Mermaid:'
    '   - `reports/node-network.mmd`'
    '   - `reports/project-task-map.mmd`'
    '   - `reports/task-lifecycle.mmd`'
    ''
    '## Mensaje de demo'
    ''
    'ENGREMIAT_CORE puede cerrar localmente un ciclo de trabajo simulado con gobernanza mínima, trazabilidad y evidencia verificable.'
  ) | Set-Content -LiteralPath $demoScriptPath -Encoding UTF8

  $newDocs = @(
    $timelinePath,
    $decisionsPath,
    $lessonsPath,
    $closePath,
    $nextObjectivePath,
    $executiveSummaryPath,
    $technicalSummaryPath,
    $demoScriptPath
  )

  $allFinalArtifacts = @($artifactFiles.FullName + $manifestPath + $checksumsPath + $newDocs)
  $allFinalArtifacts = @($allFinalArtifacts | Sort-Object -Unique)

  $finalItems = @()
  foreach ($path in $allFinalArtifacts) {
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $file = Get-Item -LiteralPath $path
    $finalItems += [ordered]@{
      path = $file.FullName
      relative_path = RelativePath $file.FullName
      bytes = $file.Length
      sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    }
  }

  $finalChecksumsPath = Join-Path $root 'checksums.sha256'
  ($finalItems | ForEach-Object { $_.sha256 + '  ' + $_.relative_path }) | Set-Content -LiteralPath $finalChecksumsPath -Encoding UTF8

  $closeReport = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    objective_closed = $true
    package_presentable = $true
    manifest = $manifestPath
    checksums = $finalChecksumsPath
    timeline = $timelinePath
    decisions = $decisionsPath
    lessons = $lessonsPath
    close = $closePath
    next_objective = $nextObjectivePath
    executive_summary = $executiveSummaryPath
    technical_summary = $technicalSummaryPath
    demo_script = $demoScriptPath
    artifacts = @($finalItems).Count
    latest = [ordered]@{
      project_id = $latestProject
      task_id = $latestTask
      worker_id = $latestWorker
      run_id = $latestRun
      evidence_id = $latestEvidence
    }
    git = $false
    network = $false
    remote_execution = $false
    next = 'DEFINE_NEXT_OBJECTIVE_AFTER_CORE_MVP'
  }

  $closeReportPath = Join-Path $root "reports\e07-close-memory-demo-report.$stamp.json"
  Save-Json $closeReportPath $closeReport

  try {
    Start-Process -FilePath (Join-Path $root 'reports\index.html') | Out-Null
    $opened = $true
  } catch {
    $opened = $false
  }

  C Green "OK objective=$objective stage=E07 objective_closed=True package_presentable=True manifest=True checksums=True docs=8 artifacts=$(@($finalItems).Count) opened=$opened git=False network=False remote_execution=False report=$closeReportPath next=DEFINE_NEXT_OBJECTIVE_AFTER_CORE_MVP"
} catch {
  C Red ("ERR objective=ENGREMIAT_CORE_MVP_001 stage=E07 message=" + $_.Exception.Message)
  throw
}
