param([string]$Command="tool-status")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$reports="reports/open-source-toolchain-bootstrap"
$dashboard="dashboard/open-source-toolchain/index.html"
switch($Command){
  "tool-status" { Get-ChildItem -LiteralPath $reports -Filter "*.json" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 12 | ForEach-Object { Write-Host $_.FullName }; break }
  "tool-plan" { if(Test-Path "data/open-source-toolchain-bootstrap/install-plan.safe.json"){ Get-Content "data/open-source-toolchain-bootstrap/install-plan.safe.json" -Raw } else { Write-Host "NO_GO install-plan.safe.json missing" }; break }
  "tool-validate" { if(Test-Path "$reports/e07-dashboard-smoke-report.json"){ Get-Content "$reports/e07-dashboard-smoke-report.json" -Raw } else { Write-Host "NO_GO e07-dashboard-smoke-report missing" }; break }
  "tool-open" { if(Test-Path $dashboard){ Start-Process $dashboard; Write-Host "OK dashboard_opened=True path=$dashboard" } else { Write-Host "NO_GO dashboard_missing=True path=$dashboard" }; break }
  default { Write-Host "Uso: tool-status | tool-plan | tool-validate | tool-open" }
}
