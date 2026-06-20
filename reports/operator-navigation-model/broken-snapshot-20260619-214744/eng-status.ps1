param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$nav=Join-Path $PSScriptRoot "eng-navigation.ps1"
$navRaw=Get-Content $nav -Raw
$navBlock=[scriptblock]::Create($navRaw)
. $navBlock
function LastReport([string]$Dir){if(!(Test-Path $Dir)){return ""};$f=@(Get-ChildItem $Dir -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1);if($f.Count -gt 0){return $f[0].FullName};return ""}
function Draw-EngStatus{
  $launcher=Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
  $lab=Join-Path $Root "reports\system-simulation-lab"
  Eng-L "ENGREMIAT STATUS" Cyan
  Eng-L ("workspace="+$Root) Gray
  Eng-L ("desktop_launcher_exists="+[string](Test-Path -LiteralPath $launcher)) Green
  Eng-L ("simulation_lab_exists="+[string](Test-Path -LiteralPath $lab)) Green
  Eng-L ("last_operator_report="+(LastReport (Join-Path $Root "reports\desktop-terminal-operator"))) Gray
  Eng-L ("last_simulation_lab_report="+(LastReport (Join-Path $Root "reports\system-simulation-lab"))) Gray
  Eng-L "next=E04_COMMAND_ROUTER" Magenta
  Eng-L ""
  Eng-L " [b] Atras" Yellow
}
Eng-InvokeScreenLoop -Draw ${function:Draw-EngStatus} | Out-Null
