$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$Config=Join-Path $Core "documents\worker-sync\worker-signals-config.json"
New-Item -ItemType Directory -Force -Path (Split-Path $Config -Parent)|Out-Null
$arg=if($args.Count -gt 0){[string]$args[0]}else{""}
$current=$null
try{if(Test-Path $Config){$current=Get-Content $Config -Raw|ConvertFrom-Json}}catch{}
if($null -eq $current){$current=[pscustomobject]@{worker_signals_enabled=$true}}
if($arg -eq "on" -or $arg -eq "ON" -or $arg -eq "1"){$enabled=$true;$mode="ON";$reason="manual_on"}elseif($arg -eq "off" -or $arg -eq "OFF" -or $arg -eq "0"){$enabled=$false;$mode="OFF";$reason="manual_off"}else{$enabled=-not [bool]$current.worker_signals_enabled;$mode=if($enabled){"ON"}else{"OFF"};$reason="manual_toggle"}
$obj=[ordered]@{schema_version="1.0";worker_signals_enabled=$enabled;mode=$mode;reason=$reason;updated_at=(Get-Date).ToString("s")}
$obj|ConvertTo-Json -Depth 50|Set-Content $Config -Encoding UTF8
Write-Host ("OK worker_signals="+$mode+" config="+$Config) -ForegroundColor Green
