param(
  [ValidateSet("workspace","cards")]
  [string]$Mode="workspace",
  [string]$ProjectPath=""
)

$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

$Core="C:\ENGREMIAT_CORE"
$LauncherDir=Join-Path $Core "tools\launcher"
$RepDir=Join-Path $Core "reports\launcher"
$ErrLog=Join-Path $RepDir "last-selector-error.txt"
$RunLog=Join-Path $RepDir "last-selector-run.txt"

New-Item -ItemType Directory -Force -Path $RepDir | Out-Null

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

function TestScriptParse($path,$label){
  if(-not(Test-Path $path)){ throw "$label missing: $path" }
  $parseErrors=$null
  [System.Management.Automation.PSParser]::Tokenize((Get-Content $path -Raw),[ref]$parseErrors) | Out-Null
  if($parseErrors -and $parseErrors.Count -gt 0){
    $detail=$parseErrors | Out-String
    $detail | Set-Content $ErrLog -Encoding UTF8
    throw "$label parse_failed see=$ErrLog"
  }
}

try{
  $target=if($Mode -eq "workspace"){
    Join-Path $LauncherDir "ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1"
  }else{
    Join-Path $LauncherDir "ENGREMIAT-SELECT-MODULE-CARDS.ps1"
  }

  "==== SELECTOR SAFE RUN $(Get-Date -Format s) ====" | Set-Content $RunLog -Encoding UTF8
  "mode=$Mode" | Add-Content $RunLog -Encoding UTF8
  "target=$target" | Add-Content $RunLog -Encoding UTF8
  "project=$ProjectPath" | Add-Content $RunLog -Encoding UTF8

  TestScriptParse $target "selector_$Mode"

  W "==== SELECTOR SAFE ====" Cyan
  W "mode=$Mode" DarkCyan
  W "target=$target" DarkGray

  if($ProjectPath -and (Test-Path $ProjectPath)){
    & powershell -NoProfile -ExecutionPolicy Bypass -File $target -ProjectPath $ProjectPath
  }else{
    & powershell -NoProfile -ExecutionPolicy Bypass -File $target
  }

  W "==== OK SELECTOR ====" Green
  W "status=PASS" Green
  W "run_log=$RunLog" Green
}
catch{
  $msg=@()
  $msg += "==== SELECTOR ERROR $(Get-Date -Format s) ===="
  $msg += "ERROR: $($_.Exception.Message)"
  $msg += ""
  $msg += "MODE: $Mode"
  $msg += "PROJECT: $ProjectPath"
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

  W "==== ERR SELECTOR ====" Red
  W "status=FAIL" Red
  W "error_log=$ErrLog" Yellow
  W "run_log=$RunLog" Yellow
  W ""
  W "COPIA este comando para devolverme el error:" Cyan
  W "Get-Content C:\ENGREMIAT_CORE\reports\launcher\last-selector-error.txt -Raw" White
  P
}
