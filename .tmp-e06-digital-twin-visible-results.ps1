$ErrorActionPreference = 'Stop'

$root = (Get-Location).Path
$objective = 'ENGREMIAT_CORE_MVP_001'
$stage = 'E06'
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

function Add-UniqueValue([hashtable]$map, [string]$key) {
  if ($key -and -not $map.ContainsKey($key)) {
    $map[$key] = $true
  }
}

function Read-JsonSafe([string]$path) {
  try {
    return (Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop)
  } catch {
    return $null
  }
}

function HtmlEscape([string]$text) {
  if ($null -eq $text) { return '' }
  return [System.Net.WebUtility]::HtmlEncode($text)
}

try {
  foreach ($rel in @('reports','docs','data\state','data\evidence','data\events','tmp')) {
    $dir = Join-Path $root $rel
    if (-not (Test-Path -LiteralPath $dir)) {
      New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
  }

  $eventsPath = Join-Path $root 'data\events\events.jsonl'
  if (-not (Test-Path -LiteralPath $eventsPath)) {
    $noGo = [ordered]@{
      ok = $false
      objective = $objective
      stage = $stage
      decision = 'NO_GO'
      reason = 'EVENT_LEDGER_NOT_FOUND'
      required_dependency = 'P05.3.2'
      network = $false
      git = $false
      remote_execution = $false
    }
    $noGoPath = Join-Path $root "reports\e06-no-event-ledger.$stamp.json"
    Save-Json $noGoPath $noGo
    C Yellow "NO_GO objective=$objective stage=$stage reason=EVENT_LEDGER_NOT_FOUND report=$noGoPath next=REPAIR_E05_OR_REBUILD_EVENTS"
    throw 'No existe data\events\events.jsonl; E06 necesita eventos previos.'
  }

  $events = @()
  $lines = Get-Content -LiteralPath $eventsPath -Encoding UTF8 -ErrorAction Stop
  foreach ($line in $lines) {
    if (-not $line) { continue }
    try {
      $events += @($line | ConvertFrom-Json -ErrorAction Stop)
    } catch {
      continue
    }
  }

  if (@($events).Count -lt 1) {
    throw 'events.jsonl existe pero no contiene eventos JSONL válidos.'
  }

  $tasksMap = @{}
  $workersMap = @{}
  $projectsMap = @{}
  $leasesMap = @{}
  $runsMap = @{}
  $evidenceMap = @{}
  $matchesMap = @{}
  $blocked = @()

  foreach ($event in $events) {
    $payload = $event.payload
    if ($null -ne $payload) {
      Add-UniqueValue $tasksMap (TS $payload.task_id)
      Add-UniqueValue $workersMap (TS $payload.worker_id)
      Add-UniqueValue $projectsMap (TS $payload.project_id)
      Add-UniqueValue $leasesMap (TS $payload.lease_id)
      Add-UniqueValue $runsMap (TS $payload.run_id)
      Add-UniqueValue $evidenceMap (TS $payload.evidence_id)
      Add-UniqueValue $matchesMap (TS $payload.match_id)
    }
    if ((TS $event.event_type) -match 'BLOCK|DENY|FAILED|EXPIRED') {
      $blocked += @([ordered]@{
        event_id = TS $event.event_id
        event_type = TS $event.event_type
        entity_id = TS $event.entity_id
        timestamp = TS $event.timestamp
      })
    }
  }

  $jsonFiles = Get-ChildItem -LiteralPath $root -Recurse -File -Include '*.json' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch '\\node_modules\\|\\.git\\|\\tmp\\' }

  foreach ($file in $jsonFiles) {
    $name = $file.Name.ToLowerInvariant()
    $json = Read-JsonSafe $file.FullName
    if ($null -eq $json) { continue }

    if ($name -match 'task') {
      if ($json.PSObject.Properties.Name -contains 'task_id') { Add-UniqueValue $tasksMap (TS $json.task_id) }
      if ($json.PSObject.Properties.Name -contains 'last_task_id') { Add-UniqueValue $tasksMap (TS $json.last_task_id) }
    }
    if ($name -match 'worker') {
      if ($json.PSObject.Properties.Name -contains 'worker_id') { Add-UniqueValue $workersMap (TS $json.worker_id) }
      if ($json.PSObject.Properties.Name -contains 'last_worker_id') { Add-UniqueValue $workersMap (TS $json.last_worker_id) }
    }
    if ($name -match 'project') {
      if ($json.PSObject.Properties.Name -contains 'project_id') { Add-UniqueValue $projectsMap (TS $json.project_id) }
    }
    if ($name -match 'lease') {
      if ($json.PSObject.Properties.Name -contains 'lease_id') { Add-UniqueValue $leasesMap (TS $json.lease_id) }
      if ($json.PSObject.Properties.Name -contains 'reservation_id') { Add-UniqueValue $leasesMap (TS $json.reservation_id) }
      if ($json.PSObject.Properties.Name -contains 'last_lease_id') { Add-UniqueValue $leasesMap (TS $json.last_lease_id) }
    }
    if ($name -match 'evidence') {
      if ($json.PSObject.Properties.Name -contains 'evidence_id') { Add-UniqueValue $evidenceMap (TS $json.evidence_id) }
      if ($json.PSObject.Properties.Name -contains 'last_evidence_id') { Add-UniqueValue $evidenceMap (TS $json.last_evidence_id) }
    }
    if ($name -match 'match') {
      if ($json.PSObject.Properties.Name -contains 'match_id') { Add-UniqueValue $matchesMap (TS $json.match_id) }
    }
    if ($name -match 'run|execution') {
      if ($json.PSObject.Properties.Name -contains 'run_id') { Add-UniqueValue $runsMap (TS $json.run_id) }
      if ($json.PSObject.Properties.Name -contains 'last_run_id') { Add-UniqueValue $runsMap (TS $json.last_run_id) }
    }
  }

  $lastProjectStatePath = Join-Path $root 'data\state\project-state.json'
  $lastProjectState = $null
  if (Test-Path -LiteralPath $lastProjectStatePath) {
    $lastProjectState = Read-JsonSafe $lastProjectStatePath
  }

  $latestRun = ''
  $latestTask = ''
  $latestWorker = ''
  $latestLease = ''
  $latestEvidence = ''
  $latestProject = ''

  if ($null -ne $lastProjectState) {
    $latestRun = TS $lastProjectState.last_run_id
    $latestTask = TS $lastProjectState.last_task_id
    $latestWorker = TS $lastProjectState.last_worker_id
    $latestLease = TS $lastProjectState.last_lease_id
    $latestEvidence = TS $lastProjectState.last_evidence_id
    $latestProject = TS $lastProjectState.project_id
  }

  if (-not $latestProject) {
    $projectKeys = @($projectsMap.Keys)
    if (@($projectKeys).Count -gt 0) { $latestProject = $projectKeys[0] }
  }

  $eventTypeCounts = @{}
  foreach ($event in $events) {
    $t = TS $event.event_type
    if (-not $t) { continue }
    if (-not $eventTypeCounts.ContainsKey($t)) { $eventTypeCounts[$t] = 0 }
    $eventTypeCounts[$t] = [int]$eventTypeCounts[$t] + 1
  }

  $networkState = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    generated_at = (Get-Date).ToString('o')
    source = 'events.jsonl + local json artifacts'
    projects = @($projectsMap.Keys | Sort-Object)
    tasks = @($tasksMap.Keys | Sort-Object)
    workers = @($workersMap.Keys | Sort-Object)
    nodes = @('NODE-LOCAL-CORE')
    capabilities = @()
    needs = @()
    matches = @($matchesMap.Keys | Sort-Object)
    leases = @($leasesMap.Keys | Sort-Object)
    runs = @($runsMap.Keys | Sort-Object)
    evidences = @($evidenceMap.Keys | Sort-Object)
    blocked = $blocked
    counters = [ordered]@{
      events = @($events).Count
      event_types = $eventTypeCounts
      projects = @($projectsMap.Keys).Count
      tasks = @($tasksMap.Keys).Count
      workers = @($workersMap.Keys).Count
      matches = @($matchesMap.Keys).Count
      leases = @($leasesMap.Keys).Count
      runs = @($runsMap.Keys).Count
      evidences = @($evidenceMap.Keys).Count
      blocked = @($blocked).Count
    }
    last_known = [ordered]@{
      project_id = $latestProject
      task_id = $latestTask
      worker_id = $latestWorker
      lease_id = $latestLease
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
    next = 'E07_B07_1_MANIFEST_Y_CHECKSUMS'
  }

  $networkStatePath = Join-Path $root 'data\state\network-state.json'
  Save-Json $networkStatePath $networkState

  $taskQueueItems = @()
  foreach ($taskId in @($tasksMap.Keys | Sort-Object)) {
    $status = 'UNKNOWN'
    if ($taskId -eq $latestTask) { $status = 'COMPLETED' }

    $relatedEvents = @()
    foreach ($event in $events) {
      $payload = $event.payload
      if ($null -ne $payload -and (TS $payload.task_id) -eq $taskId) {
        $relatedEvents += @(TS $event.event_type)
      }
    }

    $taskQueueItems += @([ordered]@{
      task_id = $taskId
      project_id = $latestProject
      status = $status
      related_event_types = $relatedEvents
      last_run_id = $(if ($taskId -eq $latestTask) { $latestRun } else { '' })
      last_worker_id = $(if ($taskId -eq $latestTask) { $latestWorker } else { '' })
      last_evidence_id = $(if ($taskId -eq $latestTask) { $latestEvidence } else { '' })
    })
  }

  $taskQueue = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    generated_at = (Get-Date).ToString('o')
    items = $taskQueueItems
    counters = [ordered]@{
      total = @($taskQueueItems).Count
      completed = @($taskQueueItems | Where-Object { $_.status -eq 'COMPLETED' }).Count
    }
  }

  $taskQueuePath = Join-Path $root 'data\state\task-queue.json'
  Save-Json $taskQueuePath $taskQueue

  $evidenceManifestFiles = Get-ChildItem -LiteralPath (Join-Path $root 'data\evidence') -File -Include 'evidence-manifest*.json' -ErrorAction SilentlyContinue
  $evidenceItems = @()

  foreach ($manifestFile in $evidenceManifestFiles) {
    $manifest = Read-JsonSafe $manifestFile.FullName
    if ($null -eq $manifest) { continue }

    if ($manifest.PSObject.Properties.Name -contains 'items') {
      foreach ($item in @($manifest.items)) {
        $exists = Test-Path -LiteralPath (TS $item.path)
        $evidenceItems += @([ordered]@{
          evidence_id = TS $item.evidence_id
          run_id = TS $item.run_id
          task_id = TS $item.task_id
          path = TS $item.path
          relative_path = TS $item.relative_path
          type = TS $item.type
          sha256 = TS $item.sha256
          exists = $exists
          verified = $false
          manifest = $manifestFile.FullName
        })
      }
    }
  }

  $evidenceIndex = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    generated_at = (Get-Date).ToString('o')
    items = $evidenceItems
    counters = [ordered]@{
      files = @($evidenceItems).Count
      existing = @($evidenceItems | Where-Object { $_.exists }).Count
      manifests = @($evidenceManifestFiles).Count
    }
  }

  $evidenceIndexPath = Join-Path $root 'data\state\evidence-index.json'
  Save-Json $evidenceIndexPath $evidenceIndex

  $nodeNetworkPath = Join-Path $root 'reports\node-network.mmd'
  $projectTaskMapPath = Join-Path $root 'reports\project-task-map.mmd'
  $taskLifecyclePath = Join-Path $root 'reports\task-lifecycle.mmd'

  $nodeLines = @()
  $nodeLines += 'flowchart TD'
  $nodeLines += '  CORE["ENGREMIAT_CORE"]'
  $nodeLines += '  NODE["NODE-LOCAL-CORE"]'
  $nodeLines += '  CORE --> NODE'
  foreach ($worker in @($workersMap.Keys | Sort-Object)) {
    $safe = ($worker -replace '[^A-Za-z0-9_]','_')
    $nodeLines += "  NODE --> W_$safe[""$worker""]"
  }
  foreach ($task in @($tasksMap.Keys | Sort-Object)) {
    $safe = ($task -replace '[^A-Za-z0-9_]','_')
    $nodeLines += "  CORE --> T_$safe[""$task""]"
  }
  $nodeLines | Set-Content -LiteralPath $nodeNetworkPath -Encoding UTF8

  $projectLines = @()
  $projectLines += 'flowchart LR'
  $projectLines += "  P[""PROJECT: $latestProject""]"
  foreach ($task in @($tasksMap.Keys | Sort-Object)) {
    $safe = ($task -replace '[^A-Za-z0-9_]','_')
    $label = $task
    if ($task -eq $latestTask) { $label = "$task COMPLETED" }
    $projectLines += "  P --> T_$safe[""$label""]"
  }
  if ($latestRun) { $projectLines += "  T_$($latestTask -replace '[^A-Za-z0-9_]','_') --> R[""RUN: $latestRun""]" }
  if ($latestEvidence) { $projectLines += "  R --> E[""EVIDENCE: $latestEvidence""]" }
  $projectLines | Set-Content -LiteralPath $projectTaskMapPath -Encoding UTF8

  @(
    'flowchart TD'
    '  A[TASK_CREATED / TASK_AVAILABLE]'
    '  B[MATCH_SELECTED]'
    '  C[OFFER_CREATED]'
    '  D[POLICY_ALLOWED]'
    '  E[LEASE_ACTIVE]'
    '  F[EXECUTION_STARTED]'
    '  G[TASK_PROGRESS]'
    '  H[EXECUTION_COMPLETED]'
    '  I[EVIDENCE_CREATED]'
    '  J[RESULT_VERIFIED]'
    '  K[TASK_COMPLETED]'
    '  L[PROJECT_UPDATED]'
    '  A --> B --> C --> D --> E --> F --> G --> H --> I --> J --> K --> L'
  ) | Set-Content -LiteralPath $taskLifecyclePath -Encoding UTF8

  $currentStatePath = Join-Path $root 'docs\CURRENT_STATE.md'
  $mvpReportPath = Join-Path $root 'docs\MVP_REPORT.md'

  @(
    '# CURRENT_STATE — ENGREMIAT_CORE_MVP_001'
    ''
    "- Generado: $((Get-Date).ToString('o'))"
    "- Etapa actual: $stage"
    "- Estado: DIGITAL_TWIN_VISIBLE"
    "- Proyecto activo: $latestProject"
    "- Última tarea: $latestTask"
    "- Último worker: $latestWorker"
    "- Último lease: $latestLease"
    "- Último run: $latestRun"
    "- Última evidencia: $latestEvidence"
    ''
    '## Seguridad'
    ''
    '- LOCAL_ONLY: true'
    '- network: false'
    '- git: false'
    '- remote_execution: false'
    ''
    '## Artefactos generados'
    ''
    "- data/state/network-state.json"
    "- data/state/task-queue.json"
    "- data/state/evidence-index.json"
    "- reports/node-network.mmd"
    "- reports/project-task-map.mmd"
    "- reports/task-lifecycle.mmd"
    "- reports/index.html"
    ''
    '## Siguiente paso'
    ''
    'E07_B07_1_MANIFEST_Y_CHECKSUMS'
  ) | Set-Content -LiteralPath $currentStatePath -Encoding UTF8

  @(
    '# MVP_REPORT — ENGREMIAT_CORE_MVP_001'
    ''
    '## Resultado visible'
    ''
    'ENGREMIAT_CORE ya dispone de una primera capa de digital twin local: estado de red, cola de tareas, índice de evidencias, diagramas Mermaid y dashboard HTML.'
    ''
    '## Contadores'
    ''
    "- Eventos: $(@($events).Count)"
    "- Proyectos: $(@($projectsMap.Keys).Count)"
    "- Tareas: $(@($tasksMap.Keys).Count)"
    "- Workers: $(@($workersMap.Keys).Count)"
    "- Leases: $(@($leasesMap.Keys).Count)"
    "- Runs: $(@($runsMap.Keys).Count)"
    "- Evidencias: $(@($evidenceItems).Count)"
    ''
    '## Límites'
    ''
    '- No ejecuta acciones reales.'
    '- No usa red.'
    '- No usa Git.'
    '- No toca sistemas externos.'
    ''
    '## Próximo paso'
    ''
    'E07 — Cierre, memoria y demo.'
  ) | Set-Content -LiteralPath $mvpReportPath -Encoding UTF8

  $htmlPath = Join-Path $root 'reports\index.html'
  $html = @()
  $html += '<!doctype html>'
  $html += '<html lang="es">'
  $html += '<head>'
  $html += '<meta charset="utf-8">'
  $html += '<meta name="viewport" content="width=device-width, initial-scale=1">'
  $html += '<title>ENGREMIAT_CORE_MVP_001 — Digital Twin</title>'
  $html += '<style>body{font-family:Segoe UI,Arial,sans-serif;margin:32px;background:#0f172a;color:#e5e7eb}section{background:#111827;border:1px solid #334155;border-radius:14px;padding:18px;margin:14px 0}h1,h2{color:#93c5fd}.ok{color:#86efac}.warn{color:#fde68a}code,pre{background:#020617;color:#e5e7eb;padding:10px;border-radius:8px;display:block;white-space:pre-wrap}a{color:#7dd3fc}table{border-collapse:collapse;width:100%}td,th{border:1px solid #334155;padding:8px;text-align:left}</style>'
  $html += '</head><body>'
  $html += '<h1>ENGREMIAT_CORE_MVP_001 — Digital Twin</h1>'
  $html += '<section><h2>Estado</h2>'
  $html += '<p class="ok">E06 generado correctamente en modo LOCAL_ONLY.</p>'
  $html += '<table>'
  $html += '<tr><th>Campo</th><th>Valor</th></tr>'
  $html += '<tr><td>Proyecto</td><td>' + (HtmlEscape $latestProject) + '</td></tr>'
  $html += '<tr><td>Tarea</td><td>' + (HtmlEscape $latestTask) + '</td></tr>'
  $html += '<tr><td>Worker</td><td>' + (HtmlEscape $latestWorker) + '</td></tr>'
  $html += '<tr><td>Lease</td><td>' + (HtmlEscape $latestLease) + '</td></tr>'
  $html += '<tr><td>Run</td><td>' + (HtmlEscape $latestRun) + '</td></tr>'
  $html += '<tr><td>Evidencia</td><td>' + (HtmlEscape $latestEvidence) + '</td></tr>'
  $html += '</table></section>'
  $html += '<section><h2>Contadores</h2><ul>'
  $html += "<li>Eventos: $(@($events).Count)</li>"
  $html += "<li>Proyectos: $(@($projectsMap.Keys).Count)</li>"
  $html += "<li>Tareas: $(@($tasksMap.Keys).Count)</li>"
  $html += "<li>Workers: $(@($workersMap.Keys).Count)</li>"
  $html += "<li>Leases: $(@($leasesMap.Keys).Count)</li>"
  $html += "<li>Runs: $(@($runsMap.Keys).Count)</li>"
  $html += "<li>Evidencias indexadas: $(@($evidenceItems).Count)</li>"
  $html += '</ul></section>'
  $html += '<section><h2>Artefactos</h2><ul>'
  $html += '<li>data/state/network-state.json</li>'
  $html += '<li>data/state/task-queue.json</li>'
  $html += '<li>data/state/evidence-index.json</li>'
  $html += '<li>reports/node-network.mmd</li>'
  $html += '<li>reports/project-task-map.mmd</li>'
  $html += '<li>reports/task-lifecycle.mmd</li>'
  $html += '<li>docs/CURRENT_STATE.md</li>'
  $html += '<li>docs/MVP_REPORT.md</li>'
  $html += '</ul></section>'
  $html += '<section><h2>Seguridad</h2><pre>LOCAL_ONLY=true&#10;network=false&#10;git=false&#10;remote_execution=false&#10;external_systems_touched=false</pre></section>'
  $html += '<section><h2>Siguiente paso</h2><p class="warn">E07_B07_1_MANIFEST_Y_CHECKSUMS</p></section>'
  $html += '</body></html>'
  $html | Set-Content -LiteralPath $htmlPath -Encoding UTF8

  $final = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    steps = 6
    network_state = $networkStatePath
    task_queue = $taskQueuePath
    evidence_index = $evidenceIndexPath
    diagrams = @($nodeNetworkPath,$projectTaskMapPath,$taskLifecyclePath)
    docs = @($currentStatePath,$mvpReportPath)
    html = $htmlPath
    counters = [ordered]@{
      events = @($events).Count
      tasks = @($taskQueueItems).Count
      evidence_items = @($evidenceItems).Count
    }
    git = $false
    network = $false
    remote_execution = $false
    next = 'E07_B07_1_MANIFEST_Y_CHECKSUMS'
  }

  $finalPath = Join-Path $root "reports\e06-digital-twin-visible-results-report.$stamp.json"
  Save-Json $finalPath $final

  try {
    Start-Process -FilePath $htmlPath | Out-Null
    $opened = $true
  } catch {
    $opened = $false
  }

  C Green "OK objective=$objective stage=E06 steps=6 network_state=True task_queue=True evidence_index=True mermaid=3 markdown=2 html=True opened=$opened git=False network=False remote_execution=False report=$finalPath next=E07_B07_1_MANIFEST_Y_CHECKSUMS"
} catch {
  C Red ("ERR objective=ENGREMIAT_CORE_MVP_001 stage=E06 message=" + $_.Exception.Message)
  throw
}
