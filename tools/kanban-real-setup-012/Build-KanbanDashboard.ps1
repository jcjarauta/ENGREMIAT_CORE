$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function HtmlEsc([string]$s){[System.Net.WebUtility]::HtmlEncode($s)}
$boardPath='data/kanban-real-setup-012/kanban-board.json'
$outPath='dashboard/kanban-real-setup-012/index.html'
if(-not(Test-Path $boardPath)){throw "Missing board: $boardPath"}
$board=Get-Content $boardPath -Raw | ConvertFrom-Json
$cards=@($board.cards)
$counts=@{BACKLOG=0;READY=0;GATED=0;RUNNING=0;REVIEW=0;DONE=0;BLOCKED=0}
if($board.counts){foreach($p in $board.counts.PSObject.Properties){if($counts.ContainsKey($p.Name)){$counts[$p.Name]=[int]$p.Value}}}
$sb=New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<!doctype html>')
[void]$sb.AppendLine('<html lang="es">')
[void]$sb.AppendLine('<head>')
[void]$sb.AppendLine('<meta charset="utf-8">')
[void]$sb.AppendLine('<title>ENGREMIAT Kanban Real Setup 012</title>')
[void]$sb.AppendLine('<style>body{font-family:Segoe UI,Arial,sans-serif;margin:24px;background:#0f172a;color:#e2e8f0}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:14px}.card{background:#111827;border:1px solid #334155;border-radius:12px;padding:16px}table{width:100%;border-collapse:collapse;margin-top:16px}th,td{border:1px solid #334155;padding:8px;vertical-align:top}h1{color:#67e8f9}.ok{color:#86efac}.warn{color:#fde68a}.muted{color:#94a3b8}code{background:#020617;padding:2px 6px;border-radius:6px}</style>')
[void]$sb.AppendLine('</head>')
[void]$sb.AppendLine('</body>')
[void]$sb.AppendLine('<h1>ENGREMIAT Kanban Real Setup 012</h1>')
[void]$sb.AppendLine('<p class="muted">Dashboard humano local sin servidor, sin apply y sin Git write.</p>')
[void]$sb.AppendLine('<div class="grid">')
foreach($k in 'BACKLOG','READY','GATED','RUNNING','REVIEW','DONE','BLOCKED'){[void]$sb.AppendLine('<div class="card"><h2>'+(HtmlEsc $k)+'</h2><p class="ok">'+(HtmlEsc $counts[$k])+' tarjetas</p></div>')}
[void]$sb.AppendLine('</div>')
[void]$sb.AppendLine('<div class="card" style="margin-top:16px"><h2>Resumen</h2><p><b>Board:</b> '+(HtmlEsc $board.objective)+'</p><p><b>Stage:</b> '+(HtmlEsc $board.stage)+'</p><p><b>Browser opened:</b> false</p><p><b>Remote execution:</b> false</p><p><b>Git write:</b> false</p><p><b>Auto apply:</b> false</p></div>')
[void]$sb.AppendLine('<div class="card" style="margin-top:16px"><h2>Tarjetas</h2><table><thead><tr><th>ID</th><th>Stage</th><th>Block</th><th>Step</th><th>State</th><th>Status</th><th>Next action</th></tr></thead><tbody>')
foreach($c in $cards){[void]$sb.AppendLine('<tr><td><code>'+(HtmlEsc $c.id)+'</code></td><td>'+(HtmlEsc $c.stage)+'</td><td>'+(HtmlEsc $c.block)+'</td><td>'+(HtmlEsc $c.step)+'</td><td>'+(HtmlEsc $c.state)+'</td><td>'+(HtmlEsc $c.status)+'</td><td>'+(HtmlEsc $c.next_action)+'</td></tr>')}
[void]$sb.AppendLine('</tbody></table></div>')
[void]$sb.AppendLine('</body>')
[void]$sb.AppendLine('</html>')
Set-Content -LiteralPath $outPath -Value $sb.ToString() -Encoding UTF8
Write-Host ('BUILDER_OK board=' + $boardPath + ' out=' + $outPath) -ForegroundColor Green
