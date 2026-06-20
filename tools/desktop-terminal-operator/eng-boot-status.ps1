$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ScriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$Root=(Resolve-Path (Join-Path $ScriptDir "..\..")).Path
& (Join-Path $Root "tools\desktop-terminal-operator\eng-status.ps1")
Write-Host ""
Write-Host "BOOT_STATUS=PASS" -ForegroundColor Green
