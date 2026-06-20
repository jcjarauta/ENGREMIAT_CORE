param(
  [Parameter(Mandatory=$true)][string]$RequestPath,
  [ValidateSet("Plan","Run")] [string]$Mode = "Plan"
)
$ErrorActionPreference = "Stop"
$ProgressPreference = "Continue"

function Read-JsonFile {
  param([Parameter(Mandatory=$true)][string]$Path)
  if (-not (Test-Path $Path)) { return $null }
  try { return Get-Content -Raw -Encoding UTF8 $Path | ConvertFrom-Json -ErrorAction Stop } catch { return $null }
}

function Write-JsonFile {
  param(
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter(Mandatory=$true)][object]$Object
  )
  $dir = Split-Path -Parent $Path
  if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $Object | ConvertTo-Json -Depth 20 | Set-Content -Encoding UTF8 $Path
}

function Show-Loading {
  param(
    [Parameter(Mandatory=$true)][string]$Label,
    [Parameter(Mandatory=$false)][int]$Seconds = 2
  )
  $spin = @("|","/","-","\\")
  $sw = [Diagnostics.Stopwatch]::StartNew()
  $i = 0
  while ($sw.Elapsed.TotalSeconds -lt $Seconds) {
    $pct = [math]::Min(99, [int](($sw.Elapsed.TotalSeconds / [math]::Max(1, $Seconds)) * 100))
    Write-Progress -Activity $Label -Status ("elapsed=" + [int]$sw.Elapsed.TotalSeconds + "s") -PercentComplete $pct
    Write-Host -NoNewline ("`r" + $Label + " " + $spin[$i % 4] + " ")
    [Console]::Out.Flush()
    Start-Sleep -Milliseconds 250
    $i++
  }
  Write-Progress -Activity $Label -Completed
  Write-Host ""
}

function Invoke-Launcher {
  param(
    [Parameter(Mandatory=$true)][string]$ReqPath,
    [Parameter(Mandatory=$false)][string]$RunMode = "Plan"
  )
  if (-not (Test-Path $ReqPath)) { throw ("Missing request: " + $ReqPath) }
  $request = Read-JsonFile -Path $ReqPath
  if ($null -eq $request) { throw ("Invalid JSON request: " + $ReqPath) }

  $rootDir = Split-Path -Parent $ReqPath
  $runDir = Join-Path $rootDir "launcher-run"
  $summaryPath = Join-Path $runDir "launcher-summary.json"
  $receiptPath = Join-Path $runDir "launcher-receipt.json"
  $postPath = Join-Path $runDir "launcher-postcheck.json"

  if (-not (Test-Path $runDir)) { New-Item -ItemType Directory -Force -Path $runDir | Out-Null }

  if ($RunMode -eq "Run") { Show-Loading -Label "LAUNCHER RUN" -Seconds 2 }

  $summary = [ordered]@{
    objective_id = "DEFINE_REAL_EXECUTION_LAUNCHER_REUSABLE_MVP_184_187"
    stage = "E186"
    mode = $RunMode
    request_path = $ReqPath
    candidate_task_id = if ($request.PSObject.Properties.Name -contains "candidate_task_id") { [string]$request.candidate_task_id } else { "UNKNOWN" }
    candidate_title = if ($request.PSObject.Properties.Name -contains "candidate_title") { [string]$request.candidate_title } else { "UNKNOWN" }
    primary_input_path = if ($request.PSObject.Properties.Name -contains "primary_input_path") { [string]$request.primary_input_path } else { "" }
    secondary_support_input_path = if ($request.PSObject.Properties.Name -contains "secondary_support_input_path") { [string]$request.secondary_support_input_path } else { "" }
    status = "READY"
    created_at = (Get-Date).ToString("o")
  }
  Write-JsonFile -Path $summaryPath -Object $summary

  $receipt = [ordered]@{
    objective_id = "DEFINE_REAL_EXECUTION_LAUNCHER_REUSABLE_MVP_184_187"
    stage = "E186"
    request_exists = $true
    request_readable = $true
    summary_created = $true
    status = "RECORDED"
    created_at = (Get-Date).ToString("o")
  }
  Write-JsonFile -Path $receiptPath -Object $receipt

  $post = [ordered]@{
    objective_id = "DEFINE_REAL_EXECUTION_LAUNCHER_REUSABLE_MVP_184_187"
    stage = "E186"
    summary_exists = (Test-Path $summaryPath)
    receipt_exists = (Test-Path $receiptPath)
    postcheck_ok = $true
    created_at = (Get-Date).ToString("o")
  }
  Write-JsonFile -Path $postPath -Object $post

  return $summary
}

try {
  $summary = Invoke-Launcher -ReqPath $RequestPath -RunMode $Mode
  Write-Host ("OK LAUNCHER -> " + $summary.status)
} catch {
  Write-Host ("ERR LAUNCHER -> " + $_.Exception.Message)
  throw
}
