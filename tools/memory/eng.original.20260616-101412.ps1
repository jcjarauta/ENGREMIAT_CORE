param([string]$Command="status",[string]$Value="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function RunTool($path,[string[]]$args){ if(!(Test-Path -LiteralPath $path)){ throw "Falta herramienta: $path" }; & powershell -NoProfile -ExecutionPolicy Bypass -File $path @args }
switch($Command){
  "status" { if(Test-Path -LiteralPath "tools/eng-dev-runner.ps1"){ RunTool "tools/eng-dev-runner.ps1" @("status") } else { Write-Host "OK status fallback=True" }; break }
  "next" { RunTool "tools/eng-dev-runner.ps1" @("next"); break }
  "artifacts" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-artifacts.ps1" @("latest") } else { RunTool "tools/eng-artifacts.ps1" @("find",$Value) }; break }
  "context" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-context.ps1" @("show") } else { RunTool "tools/eng-context.ps1" @($Value) }; break }
  "gates" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-gates.ps1" @("pending") } else { RunTool "tools/eng-gates.ps1" @($Value) }; break }
  "readiness" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-readiness.ps1" @("current") } else { RunTool "tools/eng-readiness.ps1" @($Value) }; break }
  "errors" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-errors.ps1" @("known") } else { RunTool "tools/eng-errors.ps1" @($Value) }; break }
  "docs" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-doc-sync.ps1" @("status") } else { RunTool "tools/eng-doc-sync.ps1" @($Value) }; break }
  "dashboard" { $p="reports/dev-dashboard/index.html"; if(Test-Path -LiteralPath $p){ Write-Host ("OK dashboard="+$p) } else { throw "Falta dashboard" }; break }
  "assisted-task" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-assisted-task-builder.ps1" @("validate-fixture") } else { RunTool "tools/eng-assisted-task-builder.ps1" @($Value) }; break }
  "assisted-handoff" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-assisted-handoff.ps1" @("status") } else { RunTool "tools/eng-assisted-handoff.ps1" @($Value) }; break }
  "assisted-intake" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-assisted-intake.ps1" @("summarize","data/dev-assisted-worker/agent-result-proposal.fixture.json") } else { RunTool "tools/eng-assisted-intake.ps1" @($Value) }; break }
  "assisted-review" { if([string]::IsNullOrWhiteSpace($Value)){ RunTool "tools/eng-assisted-review.ps1" @("status") } else { RunTool "tools/eng-assisted-review.ps1" @($Value) }; break }
  "assisted-state" { if(Test-Path -LiteralPath "data/dev-assisted-worker/assisted-worker-state.json"){ Get-Content -LiteralPath "data/dev-assisted-worker/assisted-worker-state.json" -Raw -Encoding UTF8 } else { throw "Falta assisted-worker-state" }; break }
  "help" { Write-Host "Comandos: status,next,artifacts,context,gates,readiness,errors,docs,dashboard,assisted-task,assisted-handoff,assisted-intake,assisted-review,assisted-state,help" }
  default { Write-Host "Uso: .\eng.ps1 status|next|artifacts|context|gates|readiness|errors|docs|dashboard|assisted-task|assisted-handoff|assisted-intake|assisted-review|assisted-state|help" }
}
