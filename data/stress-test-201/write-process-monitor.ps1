$ErrorActionPreference='Stop'
param(
  [Parameter(Mandatory=$false)][string]$WatchRoot = (Get-Location).Path,
  [Parameter(Mandatory=$false)][int]$IntervalSeconds = 1
)

function Log([string]$m){ Write-Host ('[WRITE-PROCESS] ' + $m) }

Log ("MONITOR_START root=" + $WatchRoot)

$paths = @(
  'data\stress-test-200\stress-test-contract.json',
  'data\stress-test-200\hardware-baseline.json',
  'data\stress-test-201\write-process-contract.json',
  'data\stress-test-201\write-process-monitor.ps1',
  'data\stress-test-201\benchmark-runner.json',
  'data\stress-test-201\benchmark-execution-gate.json'
)

while($true){
  Clear-Host
  Log ("heartbeat=" + (Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))

  $procs = Get-CimInstance Win32_Process | Where-Object {
    $_.CommandLine -match 'stress-test|unified-entry|official-entry|launcher-run|Plan|Run' -or
    $_.Name -match '^(powershell|pwsh|node|cmd)\.exe?$'
  } | Select-Object ProcessId,ParentProcessId,Name,CommandLine

  if($procs){
    Log ("processes_detected=" + @($procs).Count)
    $procs | Format-Table -AutoSize
  } else {
    Log 'no_matching_processes'
  }

  ''
  $rows = foreach($p in $paths){
    $full = Join-Path $WatchRoot $p
    [pscustomobject]@{
      Exists = Test-Path $full
      LastWriteTime = if(Test-Path $full){ (Get-Item $full).LastWriteTime } else { $null }
      Path = $full
    }
  }
  $rows | Format-Table -AutoSize

  Start-Sleep -Seconds $IntervalSeconds
}
