Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$Registry=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-REGISTRY.json"
function W($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
W "==== ENGREMIAT / LAUNCHER HEALTH ====" Cyan
if(!(Test-Path $Registry)){throw "Missing registry $Registry"}
$reg=Get-Content $Registry -Raw|ConvertFrom-Json
$ok=0;$fail=0
foreach($l in $reg.launchers){$p=Join-Path $Core $l.path;if(Test-Path $p){try{ParseOk $p;W ("OK   "+$l.id+" -> "+$l.path) Green;$ok++}catch{W ("FAIL "+$l.id+" -> "+$_.Exception.Message) Red;$fail++}}else{W ("MISS "+$l.id+" -> "+$l.path) Yellow;$fail++}}
W ("RESULT ok="+$ok+" fail="+$fail) $(if($fail -eq 0){"Green"}else{"Red"})
if($fail -gt 0){exit 1}
