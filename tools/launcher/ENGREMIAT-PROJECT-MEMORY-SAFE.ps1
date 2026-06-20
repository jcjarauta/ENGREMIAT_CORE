$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$LauncherDir=Join-Path $Core "tools\launcher"
$RepDir=Join-Path $Core "reports\launcher"
$MemoryPs1=Join-Path $LauncherDir "ENGREMIAT-PROJECT-MEMORY.ps1"
$ErrLog=Join-Path $RepDir "last-memory-error.txt"
$RunLog=Join-Path $RepDir "last-memory-run.txt"

New-Item -ItemType Directory -Force -Path $RepDir | Out-Null

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }

try{
  "==== MEMORY SAFE RUN $(Get-Date -Format s) ====" | Set-Content $RunLog -Encoding UTF8
  "memory_ps1=$MemoryPs1" | Add-Content $RunLog -Encoding UTF8

  if(-not(Test-Path $MemoryPs1)){
    throw "memory_script_missing=$MemoryPs1"
  }

  $parseErrors=$null
  [System.Management.Automation.PSParser]::Tokenize((Get-Content $MemoryPs1 -Raw),[ref]$parseErrors) | Out-Null
  if($parseErrors -and $parseErrors.Count -gt 0){
    $parseErrors | Out-String | Set-Content $ErrLog -Encoding UTF8
    throw "memory_script_parse_failed see=$ErrLog"
  }

  & powershell -NoProfile -ExecutionPolicy Bypass -File $MemoryPs1 *>> $RunLog

  W "==== OK MEMORIA ====" Green
  W "status=PASS" Green
  W "run_log=$RunLog" Green
  W "error_log=$ErrLog" DarkGray
  W "Si se abrió Notepad, la memoria/prompt se generó." Green
}
catch{
  $msg=@()
  $msg += "==== MEMORY ERROR $(Get-Date -Format s) ===="
  $msg += "ERROR: $($_.Exception.Message)"
  $msg += ""
  $msg += "SCRIPT: $MemoryPs1"
  $msg += ""
  $msg += "POSITION:"
  $msg += ($_.InvocationInfo.PositionMessage)
  $msg += ""
  $msg += "STACK:"
  $msg += ($_.ScriptStackTrace)
  $msg += ""
  $msg += "RUN_LOG:"
  if(Test-Path $RunLog){ $msg += (Get-Content $RunLog -Raw) }
  $msg | Set-Content $ErrLog -Encoding UTF8

  W "==== ERR MEMORIA ====" Red
  W "status=FAIL" Red
  W "error_log=$ErrLog" Yellow
  W "run_log=$RunLog" Yellow
  W ""
  W "COPIA este comando para devolverme el error:" Cyan
  W "Get-Content C:\ENGREMIAT_CORE\reports\launcher\last-memory-error.txt -Raw" White
}

[void](Read-Host "Enter")
