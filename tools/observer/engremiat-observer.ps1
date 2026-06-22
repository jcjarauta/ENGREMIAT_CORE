param(
  [string]$Root = "C:\ENGREMIAT_CORE",
  [switch]$Quiet
)
$ErrorActionPreference = "Stop"
$Package = "ENGREMIAT_PERMANENT_OBSERVER"
$Stage = "RUN_READONLY_OBSERVER"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

function S($v) {
  if ($null -eq $v) { return "" }
  return [string]$v
}
function J($p) {
  return (Join-Path $Root $p)
}
function EnsureDir($p) {
  New-Item -ItemType Directory -Force -Path $p | Out-Null
}
function ReadJson($p) {
  try {
    if (Test-Path -LiteralPath $p) {
      return (Get-Content -LiteralPath $p -Raw | ConvertFrom-Json)
    }
  } catch {}
  return $null
}
function ReadText($p) {
  try {
    if (Test-Path -LiteralPath $p) {
      return Get-Content -LiteralPath $p -Raw -ErrorAction Stop
    }
  } catch {}
  return ""
}
function Sha256($p) {
  try {
    if (Test-Path -LiteralPath $p) {
      return (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    }
  } catch {}
  return ""
}
function ParseOk($p) {
  try {
    if (!(Test-Path -LiteralPath $p)) { return $false }
    if (([IO.Path]::GetExtension($p)).ToLowerInvariant() -ne ".ps1") { return $null }
    $tokens = $null
    $errors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$tokens,[ref]$errors) | Out-Null
    return ($errors.Count -eq 0)
  } catch {
    return $false
  }
}
function FunctionsOf($p) {
  try {
    if (!(Test-Path -LiteralPath $p)) { return @() }
    if (([IO.Path]::GetExtension($p)).ToLowerInvariant() -ne ".ps1") { return @() }
    $tokens = $null
    $errors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$tokens,[ref]$errors)
    $found = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
    return @($found | ForEach-Object { $_.Name } | Sort-Object -Unique)
  } catch {
    return @()
  }
}
function Rel($p) {
  try {
    return (Resolve-Path -LiteralPath $p).Path.Replace($Root,"").TrimStart("\")
  } catch {
    return (S $p)
  }
}

$observerReportDir = J "reports\observer"
$observerMemDir = J "memory\development"
$observerDiagDir = J "documents\diagnostics"
EnsureDir $observerReportDir
EnsureDir $observerMemDir
EnsureDir $observerDiagDir

$masterContractPath = J "documents\launcher-contracts\MASTER_ENTRY_CONTRACT.json"
$navigationContractPath = J "documents\launcher-contracts\NAVIGATION_CONTRACT.json"
$canonicalMapPath = J "documents\diagnostics\DIAGNOSTIC_CANONICAL_MAP.json"

$masterContract = ReadJson $masterContractPath
$navContract = ReadJson $navigationContractPath
$canonicalMap = ReadJson $canonicalMapPath

$freezerRoot = J "freezers"
$freezerJsonObj = $null
$freezerMdObj = $null
if (Test-Path -LiteralPath $freezerRoot) {
  $freezerJsonObj = Get-ChildItem -LiteralPath $freezerRoot -Filter "FREEZER.json" -Recurse -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $freezerMdObj = Get-ChildItem -LiteralPath $freezerRoot -Filter "FREEZER.md" -Recurse -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

$freezer = $null
if ($freezerJsonObj) {
  $freezer = ReadJson $freezerJsonObj.FullName
}

$legend = ""
if ($navContract -and $navContract.common_command_legend) {
  $legend = S $navContract.common_command_legend
} elseif ($masterContract -and $masterContract.common_command_legend) {
  $legend = S $masterContract.common_command_legend
} else {
  $legend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
}

$targets = @{}
if ($navContract -and $navContract.targets) {
  foreach ($prop in $navContract.targets.PSObject.Properties) {
    $targets[$prop.Name] = S $prop.Value
  }
}
if ($targets.Count -eq 0) {
  $targets["master"] = J "ENGREMIAT.ps1"
}

$snapshotMap = @{}
if ($freezer -and $freezer.screens) {
  foreach ($screen in @($freezer.screens)) {
    if ($screen.key -and $screen.snapshot) {
      $snapshotMap[(S $screen.key)] = S $screen.snapshot
    }
  }
}

$screens = @()
foreach ($key in ($targets.Keys | Sort-Object)) {
  $path = S $targets[$key]
  $exists = Test-Path -LiteralPath $path
  $txt = ReadText $path
  $snapshot = ""
  if ($snapshotMap.ContainsKey($key)) {
    $snapshot = S $snapshotMap[$key]
  }

  $currentHash = Sha256 $path
  $snapshotHash = Sha256 $snapshot
  $changedSinceFreezer = $false
  if ($snapshot -and $currentHash -and $snapshotHash -and ($currentHash -ne $snapshotHash)) {
    $changedSinceFreezer = $true
  }

  $length = 0
  $lastWrite = ""
  if ($exists) {
    $item = Get-Item -LiteralPath $path
    $length = $item.Length
    $lastWrite = $item.LastWriteTime.ToString("s")
  }

  $screens += [ordered]@{
    key = $key
    path = $path
    relative = Rel $path
    exists = [bool]$exists
    parse_ok = ParseOk $path
    has_common_legend = $txt.Contains($legend)
    has_engremiat_title = ($txt -match "ENGREMIAT")
    functions = @(FunctionsOf $path)
    length = $length
    last_write = $lastWrite
    snapshot = $snapshot
    snapshot_exists = if ($snapshot) { Test-Path -LiteralPath $snapshot } else { $false }
    changed_since_freezer = $changedSinceFreezer
  }
}

$needs = @()
foreach ($s in $screens) {
  if (-not $s.exists) {
    $needs += "HIGH: missing screen $($s.key) -> $($s.path)"
  } elseif ($s.parse_ok -eq $false) {
    $needs += "HIGH: parse fail $($s.key) -> $($s.path)"
  } elseif ($s.has_common_legend -eq $false) {
    $needs += "MEDIUM: normalizar leyenda comun en $($s.key) -> $($s.path)"
  }

  if ($s.changed_since_freezer) {
    $needs += "INFO: changed since freezer $($s.key) -> $($s.path)"
  }
}

$highNeeds = @($needs | Where-Object { $_ -like "HIGH:*" })
$status = "PASS"
if ($highNeeds.Count -gt 0) {
  $status = "WARN"
}

$freezerJsonPath = ""
$freezerMdPath = ""
if ($freezerJsonObj) { $freezerJsonPath = $freezerJsonObj.FullName }
if ($freezerMdObj) { $freezerMdPath = $freezerMdObj.FullName }

$next = "OBSERVER_BASELINE_OK"
if ($needs.Count -gt 0) {
  $next = "REVIEW_NEEDS_BEFORE_APPLY"
}

$payload = [ordered]@{
  package = $Package
  stage = $Stage
  status = $status
  readonly = $true
  git_write = $false
  external_actions = $false
  created_at = (Get-Date -Format s)
  root = $Root
  master_contract = $masterContractPath
  navigation_contract = $navigationContractPath
  canonical_map = $canonicalMapPath
  freezer_json = $freezerJsonPath
  freezer_md = $freezerMdPath
  common_command_legend = $legend
  screens = $screens
  needs = $needs
  next = $next
}

$json = Join-Path $observerReportDir ("engremiat-observer-" + $Stamp + ".json")
$md = Join-Path $observerReportDir ("engremiat-observer-" + $Stamp + ".md")
$latestJson = Join-Path $observerReportDir "latest-observer.json"
$latestMd = Join-Path $observerReportDir "latest-observer.md"

$payload | ConvertTo-Json -Depth 18 | Set-Content -LiteralPath $json -Encoding UTF8
$payload | ConvertTo-Json -Depth 18 | Set-Content -LiteralPath $latestJson -Encoding UTF8

$out = @()
$out += "# ENGREMIAT OBSERVER READONLY"
$out += ""
$out += "Estado: $status"
$out += "Fecha: " + (Get-Date -Format s)
$out += "Root: $Root"
$out += ""
$out += "## Contracts"
$out += "- Master: $masterContractPath"
$out += "- Navigation: $navigationContractPath"
$out += "- Canonical map: $canonicalMapPath"
$out += "- Freezer JSON: $freezerJsonPath"
$out += "- Freezer MD: $freezerMdPath"
$out += ""
$out += "## Screens"
foreach ($s in $screens) {
  $out += "- $($s.key): exists=$($s.exists) parse=$($s.parse_ok) legend=$($s.has_common_legend) changed_since_freezer=$($s.changed_since_freezer) path=$($s.path)"
}
$out += ""
$out += "## Needs"
if ($needs.Count -eq 0) {
  $out += "- NONE"
} else {
  foreach ($need in $needs) {
    $out += "- $need"
  }
}
$out += ""
$out += "## Next"
$out += $next

$out | Set-Content -LiteralPath $md -Encoding UTF8
$out | Set-Content -LiteralPath $latestMd -Encoding UTF8

$eventPath = Join-Path $observerMemDir "events.jsonl"
$event = [ordered]@{
  ts = (Get-Date -Format s)
  type = "OBSERVER_RUN"
  status = $status
  report = $json
  needs_count = $needs.Count
  readonly = $true
  git_write = $false
}
$event | ConvertTo-Json -Compress -Depth 8 | Add-Content -LiteralPath $eventPath -Encoding UTF8

$latestState = Join-Path $observerMemDir "latest-state.json"
$payload | ConvertTo-Json -Depth 18 | Set-Content -LiteralPath $latestState -Encoding UTF8

if (-not $Quiet) {
  Write-Host "OK observer_run=True status=$status readonly=True git_write=False report=$json latest=$latestJson needs=$($needs.Count)"
  foreach ($need in $needs) {
    Write-Host (" - " + $need)
  }
}
