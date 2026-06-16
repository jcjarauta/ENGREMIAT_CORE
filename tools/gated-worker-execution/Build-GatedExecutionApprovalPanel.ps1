$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$base="data/gated-worker-execution"
$dash="dashboard/gated-worker-execution"
if(!(Test-Path $dash)){New-Item -ItemType Directory -Path $dash -Force|Out-Null}
$scope=Get-Content (Join-Path $base "first-gated-execution-scope.json") -Raw|ConvertFrom-Json
$request=Get-Content (Join-Path $base "first-cline-readonly-request.json") -Raw|ConvertFrom-Json
$gate=Get-Content (Join-Path $base "first-human-approve-readonly.json") -Raw|ConvertFrom-Json
$html=@("<!doctype html><html><head><meta charset=""utf-8""><title>ENGREMIAT Gated Execution Approval</title><style>body{font-family:Segoe UI,Arial;margin:24px;background:#10131a;color:#e8eefc}section{border:1px solid #2b3448;border-radius:10px;padding:16px;margin:12px 0;background:#151a24}.ok{color:#62d26f}.warn{color:#ffd166}.bad{color:#ff6b6b}code{background:#0b0e14;padding:2px 5px;border-radius:4px}</style></head><body>","<h1>ENGREMIAT_GATED_WORKER_EXECUTION_006 — Approval</h1>","<section><h2>Gate</h2><p class=""ok"">Decision: <b>"+$gate.decision+"</b></p><p>Human confirmation: <b>"+$gate.human_confirmation+"</b></p><p>Execution allowed: <b>"+$gate.execution_allowed+"</b></p></section>","<section><h2>Request</h2><p><code>"+$request.request_id+"</code></p><p>"+$request.title+"</p></section>","<section><h2>Limits</h2><p>readonly=true · write_files=false · run_commands=false · auto_apply=false · git_write=false · remote_inference=false</p></section>","<section><h2>Blocked</h2><p>write_files · run_shell_commands · auto_apply · git_write · remote_inference</p></section>","</body></html>")
$out=Join-Path $dash "approval.html"
$html|Set-Content -LiteralPath $out -Encoding UTF8
Start-Process $out
Write-Host ("OK gated_execution_approval_panel_created=True path="+$out+" approve_readonly=True") -ForegroundColor Green
