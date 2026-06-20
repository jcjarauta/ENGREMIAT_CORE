$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Mode=if($args.Count -gt 0){[string]$args[0]}else{'preview'}
$dash=Join-Path $PSScriptRoot '..\\..\\dashboard\\kanban-visible-ollama-ready-013\\index.html'
$dash=(Resolve-Path $dash -ErrorAction SilentlyContinue).Path
$msg='KANBAN visible launcher ready'
if(-not $dash){ Write-Host $msg; exit 0 }
if($Mode -eq 'open'){ Start-Process $dash } else { Write-Host $msg; Write-Host ('DASHBOARD='+$dash) }
