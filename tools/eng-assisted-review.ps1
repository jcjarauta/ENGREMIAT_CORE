param([string]$Command="status")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
switch($Command){
  "review" { Get-Content -LiteralPath "data/dev-assisted-worker/review/assisted-worker-review-request.md" -Encoding UTF8; break }
  "gate" { Get-Content -LiteralPath "data/dev-assisted-worker/review/assisted-worker-apply-gate.json" -Raw -Encoding UTF8; break }
  "apply-plan" { Get-Content -LiteralPath "data/dev-assisted-worker/apply/assisted-worker-apply-plan.json" -Raw -Encoding UTF8; break }
  "status" { Write-Host "OK assisted_review status=PENDING_HUMAN_DECISION apply_allowed=False gate=AW-APPLY-GATE-001" }
  default { Write-Host "Uso: .\tools\eng-assisted-review.ps1 review|gate|apply-plan|status" }
}
