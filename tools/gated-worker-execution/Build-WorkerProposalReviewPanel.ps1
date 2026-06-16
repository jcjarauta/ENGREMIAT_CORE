$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$base="data/gated-worker-execution"
$dash="dashboard/gated-worker-execution"
if(!(Test-Path $dash)){New-Item -ItemType Directory -Path $dash -Force|Out-Null}
$proposal=Get-Content (Join-Path $base "worker-proposal.json") -Raw|ConvertFrom-Json
$decisionPath=Join-Path $base "sample-proposal-decision.json"
$decision=if(Test-Path $decisionPath){Get-Content $decisionPath -Raw|ConvertFrom-Json}else{$null}
$d=if($decision){$decision.decision}else{"DEFER"}
$html=@("<!doctype html><html><head><meta charset=""utf-8""><title>ENGREMIAT Worker Proposal Review</title><style>body{font-family:Segoe UI,Arial;margin:24px;background:#10131a;color:#e8eefc}section{border:1px solid #2b3448;border-radius:10px;padding:16px;margin:12px 0;background:#151a24}.ok{color:#62d26f}.warn{color:#ffd166}.bad{color:#ff6b6b}code{background:#0b0e14;padding:2px 5px;border-radius:4px}li{margin:4px 0}</style></head><body>","<h1>Worker proposal review</h1>","<section><h2>Decision actual</h2><p class=""warn""><b>"+$d+"</b></p><p>Sin nueva aprobacion humana no se aplica nada.</p></section>","<section><h2>Resumen</h2><p>"+$proposal.summary+"</p></section>","<section><h2>Riesgos</h2><ul><li>"+(($proposal.risks|ForEach-Object {[string]$_}) -join "</li><li>")+"</li></ul></section>","<section><h2>Siguiente recomendado</h2><p><code>"+$proposal.recommended_next_step+"</code></p></section>","<section><h2>Seguridad</h2><p>apply_recommended=false · write_files=false · auto_apply=false · git_write=false · remote_inference=false</p></section>","</body></html>")
$out=Join-Path $dash "proposal-review.html"
$html|Set-Content -LiteralPath $out -Encoding UTF8
Start-Process $out
Write-Host ("OK worker_proposal_review_panel_created=True path="+$out+" decision="+$d+" apply=False") -ForegroundColor Green
