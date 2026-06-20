$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
& powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ToolLinkingSandboxIntake.ps1" -Root "C:\ENGREMIAT_CORE" -RunRecurrentModel -OpenPrompt
