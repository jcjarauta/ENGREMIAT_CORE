param([string]$LauncherId="",[string]$Mode="dry-run")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$Registry=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-REGISTRY.json"
$Health=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1"
$ReportDir=Join-Path $Core "reports\launcher"
New-Item -ItemType Directory -Force -Path $ReportDir|Out-Null
function W($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
function J($o,$p){New-Item -ItemType Directory -Force -Path (Split-Path $p -Parent)|Out-Null;$o|ConvertTo-Json -Depth 100|Set-Content $p -Encoding UTF8;$null=Get-Content $p -Raw|ConvertFrom-Json}
if(!(Test-Path $Registry)){throw "Missing registry $Registry"}
$reg=Get-Content $Registry -Raw|ConvertFrom-Json
$items=@($reg.launchers)
if(-not [string]::IsNullOrWhiteSpace($LauncherId)){$items=@($items|Where-Object{$_.id -eq $LauncherId})}
if($items.Count -eq 0){throw "No launcher matched LauncherId=$LauncherId"}
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$checked=@()
foreach($l in $items){$p=Join-Path $Core $l.path;$exists=Test-Path $p;$parse="SKIP";$backup=$null;if($exists){ParseOk $p;$parse="OK";$backup=Join-Path $ReportDir ("launcher-update-helper-backup-"+$l.id+"-"+$stamp+".ps1");if($Mode -ne "dry-run"){Copy-Item $p $backup -Force}};$checked+=[ordered]@{id=$l.id;path=$p;exists=$exists;parse=$parse;backup=$backup;mode=$Mode}}
& powershell -NoProfile -ExecutionPolicy Bypass -File $Health;if($LASTEXITCODE -ne 0){throw "Health failed"}
$report=Join-Path $ReportDir ("launcher-update-helper-"+$Mode+"-"+$stamp+".json")
$obj=[ordered]@{package_id="ENGREMIAT_OPERATOR_LAUNCHER_001";stage="LAUNCHER_UPDATE_HELPER";status="PASS";mode=$Mode;launcher_id=$LauncherId;checked=$checked;health=$Health;report=$report;next="Use Mode=apply only from controlled patch scripts"}
J $obj $report
W ("OK launcher_update_helper mode="+$Mode+" checked="+$checked.Count+" report="+$report) Green
