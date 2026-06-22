param(
  [string]$Root = "C:\ENGREMIAT_CORE",
  [switch]$Watch,
  [int]$DurationSeconds = 30,
  [int]$PollSeconds = 3,
  [switch]$Quiet
)
$ErrorActionPreference = "Stop"
$Package = "ENGREMIAT_OBSERVER_WATCH"
$Stage = "READONLY_MEMORY_LOOP"

function S($v) {
  if ($null -eq $v) { return "" }
  return [string]$v
}
function J($p) {
  return Join-Path $Root $p
}
function EnsureDir($p) {
  New-Item -ItemType Directory -Force -Path $p | Out-Null
}
function ReadJson($p) {
  try {
    if (Test-Path -LiteralPath $p) {
      return Get-Content -LiteralPath $p -Raw | ConvertFrom-Json
    }
  } catch {}
  return $null
}
function Sha256($p) {
  try {
    if (Test-Path -LiteralPath $p) {
      return (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    }
  } catch {}
  return ""
}
function Rel($p) {
  try {
    return (Resolve-Path -LiteralPath $p).Path.Replace($Root,"").TrimStart("\")
  } catch {
    return S $p
  }
}
function WriteJson($p,$obj,$depth) {
  $obj | ConvertTo-Json -Depth $depth | Set-Content -LiteralPath $p -Encoding UTF8
}
function AppendEvent($type,$data) {
  $eventPath = J "memory\development\events.jsonl"
  $evt = [ordered]@{
    ts = Get-Date -Format s
    type = $type
    source = "observer-watch"
    readonly = $true
    git_write = $false
    data = $data
  }
  $evt | ConvertTo-Json -Compress -Depth 12 | Add-Content -LiteralPath $eventPath -Encoding UTF8
}
function BuildSnapshot {
  $paths = @()
  $nav = ReadJson (J "documents\launcher-contracts\NAVIGATION_CONTRACT.json")
  if ($nav -and $nav.targets) {
    foreach ($prop in $nav.targets.PSObject.Properties) {
      $paths += [ordered]@{
        key = S $prop.Name
        kind = "navigation_target"
        path = S $prop.Value
      }
    }
  }

  $extra = @(
    "ENGREMIAT.ps1",
    "documents\launcher-contracts\MASTER_ENTRY_CONTRACT.json",
    "documents\launcher-contracts\NAVIGATION_CONTRACT.json",
    "documents\diagnostics\DIAGNOSTIC_CANONICAL_MAP.json",
    "documents\diagnostics\DIAGNOSTIC_TOOL_REGISTRY.json",
    "tools\observer\engremiat-observer.ps1",
    "tools\observer\engremiat-observer-watch.ps1"
  )

  foreach ($e in $extra) {
    $paths += [ordered]@{
      key = [IO.Path]::GetFileName($e)
      kind = "contract_or_tool"
      path = J $e
    }
  }

  $files = @()
  foreach ($x in $paths) {
    $p = S $x.path
    $exists = Test-Path -LiteralPath $p
    $len = 0
    $lw = ""
    if ($exists) {
      $it = Get-Item -LiteralPath $p
      $len = $it.Length
      $lw = $it.LastWriteTime.ToString("s")
    }
    $files += [ordered]@{
      key = S $x.key
      kind = S $x.kind
      path = $p
      relative = Rel $p
      exists = [bool]$exists
      length = $len
      last_write = $lw
      sha256 = Sha256 $p
    }
  }
  return @($files)
}
function CompareSnapshots($old,$new) {
  $changes = @()
  $oldMap = @{}

  foreach ($o in @($old)) {
    $relOld = S $o.relative
    if ($relOld) {
      $oldMap[$relOld] = $o
    }
  }

  foreach ($n in @($new)) {
    $relNew = S $n.relative
    if (-not $oldMap.ContainsKey($relNew)) {
      $changes += [ordered]@{
        change = "NEW_TRACKED_FILE"
        relative = $relNew
        path = S $n.path
      }
    } else {
      $o = $oldMap[$relNew]
      $oldHash = S $o.sha256
      $newHash = S $n.sha256
      $oldExists = S $o.exists
      $newExists = S $n.exists
      if ($oldHash -ne $newHash) {
        $changes += [ordered]@{
          change = "HASH_CHANGED"
          relative = $relNew
          path = S $n.path
          old_hash = $oldHash
          new_hash = $newHash
        }
      }
      if ($oldExists -ne $newExists) {
        $changes += [ordered]@{
          change = "EXISTS_CHANGED"
          relative = $relNew
          path = S $n.path
          old_exists = $oldExists
          new_exists = $newExists
        }
      }
    }
  }
  return @($changes)
}

$reportDir = J "reports\observer"
$memDir = J "memory\development"
EnsureDir $reportDir
EnsureDir $memDir

$observer = J "tools\observer\engremiat-observer.ps1"
if (!(Test-Path -LiteralPath $observer)) {
  throw "No existe observer puntual: $observer"
}

$statePath = J "memory\development\watch-state.json"
$timelinePath = J "memory\development\timeline.md"

$previousFiles = @()
if (Test-Path -LiteralPath $statePath) {
  $previous = ReadJson $statePath
  if ($previous -and $previous.files) {
    $previousFiles = @($previous.files)
  }
}

$currentFiles = BuildSnapshot
$changes = CompareSnapshots $previousFiles $currentFiles

& powershell -NoProfile -ExecutionPolicy Bypass -File $observer -Quiet
if ($LASTEXITCODE -ne 0) {
  throw "Observer puntual fallo desde watcher"
}

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$mode = "ONCE"
if ($Watch) {
  $mode = "WATCH"
}

$state = [ordered]@{
  package = $Package
  stage = $Stage
  status = "PASS"
  readonly = $true
  git_write = $false
  external_actions = $false
  created_at = Get-Date -Format s
  root = $Root
  watch_mode = $mode
  tracked_files = $currentFiles.Count
  changes_count = $changes.Count
  changes = $changes
  files = $currentFiles
  latest_observer = J "reports\observer\latest-observer.json"
  next = "REVIEW_CHANGES_OR_KEEP_WATCHER_READY"
}

$report = Join-Path $reportDir ("observer-watch-" + $stamp + ".json")
WriteJson $statePath $state 18
WriteJson $report $state 18

AppendEvent "OBSERVER_WATCH_RUN" ([ordered]@{
  status = "PASS"
  report = $report
  changes_count = $changes.Count
  tracked_files = $currentFiles.Count
})

$line = "- " + (Get-Date -Format s) + " | OBSERVER_WATCH_RUN | changes=" + $changes.Count + " | tracked=" + $currentFiles.Count + " | report=" + $report
Add-Content -LiteralPath $timelinePath -Value $line -Encoding UTF8

if (-not $Quiet) {
  Write-Host "OK observer_watch_run=True status=PASS readonly=True git_write=False tracked=$($currentFiles.Count) changes=$($changes.Count) report=$report state=$statePath"
  foreach ($c in $changes) {
    Write-Host (" - " + $c.change + " :: " + $c.relative)
  }
}

if ($Watch) {
  $end = (Get-Date).AddSeconds($DurationSeconds)
  while ((Get-Date) -lt $end) {
    Start-Sleep -Seconds $PollSeconds
    $oldFiles = $currentFiles
    $currentFiles = BuildSnapshot
    $loopChanges = CompareSnapshots $oldFiles $currentFiles
    if ($loopChanges.Count -gt 0) {
      $loopStamp = Get-Date -Format "yyyyMMdd-HHmmss"
      $loopReport = Join-Path $reportDir ("observer-watch-change-" + $loopStamp + ".json")
      $loopState = [ordered]@{
        package = $Package
        stage = "WATCH_LOOP_CHANGE_DETECTED"
        status = "PASS"
        readonly = $true
        git_write = $false
        created_at = Get-Date -Format s
        changes_count = $loopChanges.Count
        changes = $loopChanges
      }
      WriteJson $loopReport $loopState 12
      AppendEvent "OBSERVER_WATCH_CHANGE_DETECTED" ([ordered]@{
        report = $loopReport
        changes_count = $loopChanges.Count
      })
      Add-Content -LiteralPath $timelinePath -Value ("- " + (Get-Date -Format s) + " | WATCH_CHANGE_DETECTED | changes=" + $loopChanges.Count + " | report=" + $loopReport) -Encoding UTF8
      if (-not $Quiet) {
        Write-Host "OK watch_change_detected=True changes=$($loopChanges.Count) report=$loopReport"
      }
    }
  }
}
