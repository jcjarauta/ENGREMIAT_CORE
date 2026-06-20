$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root="C:\ENGREMIAT_CORE"
$Freeze=Join-Path $Root "data\operator-navigation-freeze\operator-baseline-freeze.v1.json"
$State=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
function Write-Line([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Get-FileSha256([string]$Path){if(!(Test-Path -LiteralPath $Path)){return ""};$sha=[System.Security.Cryptography.SHA256]::Create();$fs=[System.IO.File]::OpenRead($Path);try{return ([BitConverter]::ToString($sha.ComputeHash($fs))).Replace("-","").ToLowerInvariant()}finally{$fs.Dispose();$sha.Dispose()}}
if(!(Test-Path -LiteralPath $Freeze)){throw "missing_freeze=$Freeze"}
$f=Get-Content -LiteralPath $Freeze -Raw -Encoding UTF8|ConvertFrom-Json
$bad=@()
foreach($of in $f.operator_files){if(!(Test-Path -LiteralPath ([string]$of.path))){$bad+="missing_operator_file="+$of.path;continue};$now=Get-FileSha256 -Path ([string]$of.path);if($now -ne [string]$of.sha256){$bad+="changed_operator_file="+$of.path}}
if(!(Test-Path -LiteralPath $State)){$bad+="missing_state"}else{$s=Get-Content -LiteralPath $State -Raw -Encoding UTF8|ConvertFrom-Json;if([string]::IsNullOrWhiteSpace([string]$s.active_project)){$bad+="missing_active_project"}}
if($f.official_master_in_project -and !(Test-Path -LiteralPath ([string]$f.official_master_in_project))){$bad+="missing_official_master_in_project"}
if($f.module_inicio -and !(Test-Path -LiteralPath ([string]$f.module_inicio))){$bad+="missing_module_inicio"}
if($bad.Count -eq 0){Write-Line "FREEZE VALIDATION PASS" Green;exit 0}else{Write-Line "FREEZE VALIDATION WARN" Yellow;foreach($x in $bad){Write-Line $x Yellow};exit 1}
