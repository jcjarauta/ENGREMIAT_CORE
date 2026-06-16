$ErrorActionPreference = 'Stop'

$root = (Get-Location).Path
$objective = 'ENGREMIAT_CORE_MVP_001'
$stage = 'E05'
$stamp = (Get-Date).ToString('yyyyMMdd-HHmmss')

function C([string]$color, [string]$message) {
  Write-Host $message -ForegroundColor $color
}

function TS($value) {
  if ($null -eq $value) { return '' }
  return [string]$value
}

function To-JsonText($obj) {
  return ($obj | ConvertTo-Json -Depth 80)
}

function Save-Json([string]$path, $obj) {
  $dir = Split-Path -Parent $path
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  To-JsonText $obj | Set-Content -LiteralPath $path -Encoding UTF8
}

function New-EngId([string]$prefix) {
  return ($prefix + '-' + ([guid]::NewGuid().ToString('N').Substring(0,12).ToUpper()))
}

function Get-Sha256Text([string]$text) {
  $sha = [Security.Cryptography.SHA256]::Create()
  $bytes = [Text.Encoding]::UTF8.GetBytes($text)
  return ([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-','').ToLowerInvariant()
}

function Append-Event([string]$path, [string]$type, [string]$entity, [string]$trace, $payload) {
  $dir = Split-Path -Parent $path
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }

  $prev = ''
  if (Test-Path -LiteralPath $path) {
    $prev = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
  }

  $payloadJson = To-JsonText $payload
  $payloadHash = Get-Sha256Text $payloadJson

  $event = [ordered]@{
    event_id = New-EngId 'EVT'
    event_type = $type
    entity_id = $entity
    issuer = 'ENGREMIAT_CORE_LOCAL_SIMULATOR'
    timestamp = (Get-Date).ToString('o')
    trace_id = $trace
    correlation_id = $trace
    payload_hash = $payloadHash
    previous_event_hash = $prev
    payload = $payload
  }

  (To-JsonText $event -replace "`r?`n",'') | Add-Content -LiteralPath $path -Encoding UTF8
  return $event
}

try {
  foreach ($rel in @('reports','data\events','data\executions','data\state','data\evidence','evidence','tmp')) {
    $dir = Join-Path $root $rel
    if (-not (Test-Path -LiteralPath $dir)) {
      New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
  }

  $leaseFiles = Get-ChildItem -LiteralPath $root -Recurse -File -Include '*lease*.json' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch '\\node_modules\\|\\.git\\|\\tmp\\' }

  $leases = @()

  foreach ($file in $leaseFiles) {
    try {
      $json = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
      $items = @()

      if ($json -is [array]) {
        $items = @($json)
      } else {
        $items += @($json)
        foreach ($propName in @('leases','active_leases','reservations','items','data')) {
          if ($json.PSObject.Properties.Name -contains $propName) {
            $value = $json.$propName
            if ($value -is [array]) {
              $items += @($value)
            } else {
              $items += @($value)
            }
          }
        }
      }

      foreach ($item in $items) {
        if ($null -eq $item) { continue }

        $status = TS $item.status
        $leaseId = TS $item.lease_id
        if (-not $leaseId) { $leaseId = TS $item.reservation_id }
        if (-not $leaseId) { $leaseId = TS $item.id }

        $taskId = TS $item.task_id
        $workerId = TS $item.worker_id
        $projectId = TS $item.project_id
        $expiresAt = TS $item.expires_at

        $statusIsActive = $false
        if ($status -match 'ACTIVE|ACCEPTED|LEASE_ACTIVE') { $statusIsActive = $true }
        if ($file.Name -match '^lease\.json$') { $statusIsActive = $true }

        if ($statusIsActive -and $leaseId -and $taskId -and $workerId) {
          $safeStatus = $status
          if (-not $safeStatus) { $safeStatus = 'ACTIVE' }

          $leases += [pscustomobject]@{
            lease_id = $leaseId
            task_id = $taskId
            worker_id = $workerId
            project_id = $projectId
            status = $safeStatus
            expires_at = $expiresAt
            source = $file.FullName
          }
        }
      }
    } catch {
      continue
    }
  }

  if (@($leases).Count -lt 1) {
    $noGo = [ordered]@{
      ok = $false
      objective = $objective
      stage = $stage
      decision = 'NO_GO'
      reason = 'NO_ACTIVE_LEASE_FOUND'
      required_dependency = 'P04.3.1'
      execution_started = $false
      network = $false
      git = $false
      remote_execution = $false
      checked_files = @($leaseFiles | Select-Object -ExpandProperty FullName)
    }

    $noGoReport = Join-Path $root ("reports\e05-no-active-lease.$stamp.json")
    Save-Json $noGoReport $noGo
    C Yellow ("NO_GO objective=$objective stage=$stage reason=NO_ACTIVE_LEASE_FOUND report=$noGoReport next=REPAIR_E04_LEASE_OR_RERUN_E04")
    throw 'No hay lease activo: E05 debe fallar si no existe P04.3.1 activo.'
  }

  $lease = $leases | Select-Object -First 1
  $runId = New-EngId 'RUN'
  $traceId = New-EngId 'TRACE'
  $evidenceId = New-EngId 'EVID'
  $eventsPath = Join-Path $root 'data\events\events.jsonl'

  $started = [ordered]@{
    run_id = $runId
    trace_id = $traceId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    project_id = $lease.project_id
    lease_id = $lease.lease_id
    lease_source = $lease.source
    mode = 'SIMULATED_EXECUTION'
    network = $false
    remote_execution = $false
    external_systems_touched = $false
    started_at = (Get-Date).ToString('o')
  }

  $ev1 = Append-Event $eventsPath 'EXECUTION_STARTED' $runId $traceId $started

  $progress = [ordered]@{
    run_id = $runId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    lease_id = $lease.lease_id
    progress_percent = 50
    message = 'Simulación local segura iniciada y procesando evidencia.'
    simulated = $true
  }

  $ev2 = Append-Event $eventsPath 'TASK_PROGRESS' $lease.task_id $traceId $progress

  $completed = [ordered]@{
    run_id = $runId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    lease_id = $lease.lease_id
    status = 'COMPLETED'
    result = 'SIMULATED_SUCCESS'
    completed_at = (Get-Date).ToString('o')
    network = $false
    remote_execution = $false
  }

  $ev3 = Append-Event $eventsPath 'EXECUTION_COMPLETED' $runId $traceId $completed

  $execDir = Join-Path $root ("data\executions\$runId")
  $evidenceDir = Join-Path $root ("evidence\$runId")
  New-Item -ItemType Directory -Path $execDir,$evidenceDir -Force | Out-Null

  $startedPath = Join-Path $execDir 'execution-started.json'
  $executionReportPath = Join-Path $execDir 'execution-report.json'

  Save-Json $startedPath $started

  $executionReport = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    block = 'B05.1'
    steps = @('P05.1.1','P05.1.2')
    run_id = $runId
    trace_id = $traceId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    lease_id = $lease.lease_id
    events = @($ev1.event_id,$ev2.event_id,$ev3.event_id)
    result = 'EXECUTION_COMPLETED'
    simulated = $true
    network = $false
    git = $false
    remote_execution = $false
  }

  Save-Json $executionReportPath $executionReport

  $evidenceReportPath = Join-Path $evidenceDir 'report.json'
  $evidenceSummaryPath = Join-Path $evidenceDir 'summary.md'
  $evidenceStdoutPath = Join-Path $evidenceDir 'stdout.log'

  Save-Json $evidenceReportPath ([ordered]@{
    evidence_id = $evidenceId
    run_id = $runId
    trace_id = $traceId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    lease_id = $lease.lease_id
    result = 'SIMULATED_SUCCESS'
    human_summary = 'Ejecución simulada local completada sin red, sin Git y sin sistemas externos.'
  })

  @(
    '# Evidencia de ejecución simulada'
    ''
    "- Objective: $objective"
    "- Stage: $stage"
    "- Run: $runId"
    "- Task: $($lease.task_id)"
    "- Worker: $($lease.worker_id)"
    "- Lease: $($lease.lease_id)"
    '- Resultado: SIMULATED_SUCCESS'
    '- Seguridad: LOCAL_ONLY, NO_NETWORK, NO_REMOTE_EXECUTION, NO_GIT'
  ) | Set-Content -LiteralPath $evidenceSummaryPath -Encoding UTF8

  "EXECUTION_SIMULATED_OK run_id=$runId task_id=$($lease.task_id) worker_id=$($lease.worker_id) lease_id=$($lease.lease_id) network=False remote_execution=False git=False" |
    Set-Content -LiteralPath $evidenceStdoutPath -Encoding UTF8

  $evidenceFiles = @($evidenceReportPath,$evidenceSummaryPath,$evidenceStdoutPath)
  $manifestItems = @()

  foreach ($path in $evidenceFiles) {
    $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
    $relative = $path.Substring($root.Length).TrimStart('\')
    $manifestItems += [ordered]@{
      evidence_id = $evidenceId
      path = $path
      relative_path = $relative
      type = ([IO.Path]::GetExtension($path).TrimStart('.'))
      sha256 = $hash
      run_id = $runId
      task_id = $lease.task_id
      verified = $false
    }
  }

  $manifest = [ordered]@{
    objective = $objective
    stage = $stage
    block = 'B05.2'
    steps = @('P05.2.1','P05.2.2')
    evidence_id = $evidenceId
    run_id = $runId
    task_id = $lease.task_id
    created_at = (Get-Date).ToString('o')
    items = $manifestItems
    verified = $false
  }

  $manifestPath = Join-Path $root "data\evidence\evidence-manifest.$runId.json"
  $checksumsPath = Join-Path $root "data\evidence\checksums.$runId.sha256"
  Save-Json $manifestPath $manifest
  ($manifestItems | ForEach-Object { $_.sha256 + '  ' + $_.relative_path }) | Set-Content -LiteralPath $checksumsPath -Encoding UTF8

  $verifyItems = @()
  $allOk = $true

  foreach ($item in $manifestItems) {
    $exists = Test-Path -LiteralPath $item.path
    $actual = ''
    if ($exists) {
      $actual = (Get-FileHash -LiteralPath $item.path -Algorithm SHA256).Hash.ToLowerInvariant()
    }

    $ok = $exists -and ($actual -eq $item.sha256) -and ($item.run_id -eq $runId) -and ($item.task_id -eq $lease.task_id)
    if (-not $ok) { $allOk = $false }

    $verifyItems += [ordered]@{
      path = $item.path
      exists = $exists
      expected_sha256 = $item.sha256
      actual_sha256 = $actual
      run_id_match = ($item.run_id -eq $runId)
      task_id_match = ($item.task_id -eq $lease.task_id)
      ok = $ok
    }
  }

  $verification = [ordered]@{
    ok = $allOk
    objective = $objective
    stage = $stage
    block = 'B05.3'
    step = 'P05.3.1'
    evidence_id = $evidenceId
    run_id = $runId
    task_id = $lease.task_id
    verified_at = (Get-Date).ToString('o')
    items = $verifyItems
  }

  $verificationPath = Join-Path $root "reports\evidence-verification-report.$stamp.json"
  Save-Json $verificationPath $verification

  if (-not $allOk) {
    C Red "ERR objective=$objective stage=$stage evidence_verified=False report=$verificationPath next=REPAIR_E05_EVIDENCE"
    throw 'La evidencia no verifica; no se cierra la tarea.'
  }

  $ev4 = Append-Event $eventsPath 'RESULT_VERIFIED' $evidenceId $traceId ([ordered]@{
    run_id = $runId
    task_id = $lease.task_id
    evidence_id = $evidenceId
    verification_report = $verificationPath
  })

  $ev5 = Append-Event $eventsPath 'TASK_COMPLETED' $lease.task_id $traceId ([ordered]@{
    task_id = $lease.task_id
    run_id = $runId
    evidence_id = $evidenceId
    status = 'COMPLETED'
  })

  $safeProjectId = TS $lease.project_id
  if (-not $safeProjectId) { $safeProjectId = 'PROJECT-UNKNOWN' }

  $ev6 = Append-Event $eventsPath 'PROJECT_UPDATED' $safeProjectId $traceId ([ordered]@{
    project_id = $safeProjectId
    task_id = $lease.task_id
    last_completed_task = $lease.task_id
    status = 'UPDATED_AFTER_SIMULATED_TASK_CLOSE'
  })

  $taskClose = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    step = 'P05.3.2'
    run_id = $runId
    task_id = $lease.task_id
    project_id = $safeProjectId
    events = @($ev4.event_id,$ev5.event_id,$ev6.event_id)
    task_status = 'COMPLETED'
    project_status = 'UPDATED'
    network = $false
    git = $false
    remote_execution = $false
  }

  $taskClosePath = Join-Path $root "reports\task-close-report.$stamp.json"
  Save-Json $taskClosePath $taskClose

  $projectState = [ordered]@{
    objective = $objective
    stage = $stage
    project_id = $safeProjectId
    last_run_id = $runId
    last_task_id = $lease.task_id
    last_worker_id = $lease.worker_id
    last_lease_id = $lease.lease_id
    last_evidence_id = $evidenceId
    task_status = 'COMPLETED'
    project_status = 'UPDATED_AFTER_E05'
    updated_at = (Get-Date).ToString('o')
  }

  $projectStatePath = Join-Path $root 'data\state\project-state.json'
  Save-Json $projectStatePath $projectState

  $final = [ordered]@{
    ok = $true
    objective = $objective
    stage = $stage
    steps = 6
    execution_started = $true
    progress_registered = $true
    execution_completed = $true
    evidence_files = 3
    evidence_verified = $true
    task_closed = $true
    project_updated = $true
    run_id = $runId
    trace_id = $traceId
    task_id = $lease.task_id
    worker_id = $lease.worker_id
    lease_id = $lease.lease_id
    reports = [ordered]@{
      execution_started = $startedPath
      execution_report = $executionReportPath
      evidence_manifest = $manifestPath
      checksums = $checksumsPath
      verification = $verificationPath
      task_close = $taskClosePath
      project_state = $projectStatePath
    }
    git = $false
    network = $false
    remote_execution = $false
    next = 'E06_B06_1_PROYECCIONES_VISIBLES'
  }

  $finalPath = Join-Path $root "reports\e05-execution-evidence-validation-report.$stamp.json"
  Save-Json $finalPath $final

  C Green "OK objective=$objective stage=E05 steps=6 run_id=$runId task_id=$($lease.task_id) worker_id=$($lease.worker_id) lease_id=$($lease.lease_id) evidence_verified=True task_closed=True project_updated=True git=False network=False remote_execution=False report=$finalPath next=E06_B06_1_PROYECCIONES_VISIBLES"
} catch {
  C Red ("ERR objective=ENGREMIAT_CORE_MVP_001 stage=E05 message=" + $_.Exception.Message)
  throw
}
