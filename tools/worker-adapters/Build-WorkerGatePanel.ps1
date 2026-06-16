$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$base="data/controlled-worker-adapters"
$dash="dashboard/worker-gates"
if(!(Test-Path $dash)){New-Item -ItemType Directory -Path $dash -Force|Out-Null}
$decisionPath=Join-Path $base "sample-human-gate-decision.json"
$schemaPath=Join-Path $base "worker-execution-gate-schema.json"
$d=Get-Content $decisionPath -Raw|ConvertFrom-Json
$s=Get-Content $schemaPath -Raw|ConvertFrom-Json
$statusClass=if($d.decision -eq "APPROVE" -and $d.human_confirmation -eq $true){"ok"}else{"warn"}
$html=@("<!doctype html><html><head><meta charset=""utf-8""><title>ENGREMIAT Worker Gates</title><style>body{font-family:Segoe UI,Arial;margin:24px;background:#10131a;color:#e8eefc}section{border:1px solid #2b3448;border-radius:10px;padding:16px;margin:12px 0;background:#151a24}.ok{color:#62d26f}.warn{color:#ffd166}.bad{color:#ff6b6b}code{background:#0b0e14;padding:2px 5px;border-radius:4px}</style></head><body>","<h1>ENGREMIAT Worker Gate Panel</h1>","<section><h2>Decision actual</h2><p class="""+$statusClass+"""><b>"+$d.decision+"</b></p><p>Execution allowed: <b>"+$d.execution_allowed+"</b></p><p>Human confirmation: <b>"+$d.human_confirmation+"</b></p></section>","<section><h2>Request</h2><p>Request: <code>"+$d.request_id+"</code></p><p>Worker: <code>"+$d.worker_id+"</code></p></section>","<section><h2>Regla</h2><p>Default decision: <code>"+$s.default_decision+"</code></p><p>Sin APPROVE explicito no hay ejecucion real.</p></section>","</body></html>")
$out=Join-Path $dash "index.html"
$html|Set-Content -LiteralPath $out -Encoding UTF8
Start-Process $out
Write-Host ("OK worker_gate_panel_created=True path="+$out+" execution_allowed="+$d.execution_allowed) -ForegroundColor Green
