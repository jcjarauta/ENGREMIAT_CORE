param([string]$Command="tool-status")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
powershell -NoProfile -ExecutionPolicy Bypass -File "tools/toolchain/Invoke-ToolchainCommand.ps1" $Command
