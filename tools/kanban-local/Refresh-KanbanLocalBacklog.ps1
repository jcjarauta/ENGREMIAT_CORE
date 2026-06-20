param(
  [string]$Root = 'C:\ENGREMIAT_CORE',
  [switch]$OpenBoard
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function HtmlEscape($s){[System.Security.SecurityElement]::Escape([string]$s)}
function ReadField($Text,$Name){
  $line=($Text -split "`r?`n" | Where-Object {$_ -match ("^"+[regex]::Escape($Name)+":")} | Select-Object -First 1)
  if(!$line){return ''}
  return (($line -replace ("^"+[regex]::Escape($Name)+":\s*"),'').Trim())
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=KANBAN_LOCAL_BACKLOG_REFRESHER_RUN_002'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=REFRESH operation=LOCAL_FILE_READ_WRITE risk=LOW input=docs\kanban-backlog output=ORCHESTRATION_BOARD validation=BOARD_EXISTS rollback=NONE timeout_seconds=60'

$backlog=Join-Path $Root 'docs\kanban-backlog'
$seed=Join-Path $backlog 'seed-25'
if(!(Test-Path $seed)){LogLine "ERR seed_missing=$seed" Red;throw 'SEED_MISSING'}

$cardFiles=Get-ChildItem $seed -Filter 'KANBAN-SEED-*.md' -File | Sort-Object Name
if($cardFiles.Count -lt 1){LogLine 'ERR no_cards=True' Red;throw 'NO_CARDS'}

$cards=@()
foreach($f in $cardFiles){
  $txt=Get-Content $f.FullName -Raw
  $cards += [pscustomobject]@{
    id=$f.BaseName
    file=$f.FullName
    title=ReadField $txt 'Titulo'
    state=ReadField $txt 'Estado'
    lane=ReadField $txt 'Lane'
    type=ReadField $txt 'Tipo'
    priority=ReadField $txt 'Prioridad'
    status=ReadField $txt 'Status'
    agent=ReadField $txt 'Agente'
    risk=ReadField $txt 'Riesgo'
  }
}

$index=Join-Path $seed 'INDEX.md'
$idx=@(
  '# KANBAN SEED 25 INDEX'
  ''
  'Uso: estas tarjetas son la foto inicial del sistema para apoyo visual y orquestacion humana.'
  ''
  "Actualizado: $((Get-Date).ToString('s'))"
  ''
  '## Tarjetas'
)
foreach($c in $cards){
  $idx += "- [$($c.id)] ./$($c.id).md - $($c.title) - lane=$($c.lane) - priority=$($c.priority) - status=$($c.status)"
}
Set-Content -Path $index -Value $idx -Encoding UTF8

$manifest=Join-Path $seed 'seed-25-manifest.json'
[pscustomobject]@{
  package='KANBAN_LOCAL_BACKLOG_REFRESHER_RUN_002'
  updated_at=(Get-Date).ToString('s')
  root=$Root
  cards_count=$cards.Count
  storage='docs/kanban-backlog/seed-25/*.md'
  visual_board='docs/kanban-backlog/seed-25/ORCHESTRATION_BOARD.html'
  kanban_native_write='disabled'
  automation='disabled'
  role='local_visual_orchestrator'
  cards=$cards
} | ConvertTo-Json -Depth 8 | Set-Content -Path $manifest -Encoding UTF8

$html=Join-Path $seed 'ORCHESTRATION_BOARD.html'
$rows=''
foreach($c in $cards){
  $rows += "<tr><td>$(HtmlEscape $c.id)</td><td>$(HtmlEscape $c.lane)</td><td>$(HtmlEscape $c.priority)</td><td>$(HtmlEscape $c.type)</td><td>$(HtmlEscape $c.title)</td><td>$(HtmlEscape $c.status)</td><td>$(HtmlEscape $c.risk)</td></tr>`n"
}

$htmlText=@"
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>ENGREMIAT Backlog Orquestador Local</title>
<style>
body{font-family:Segoe UI,Arial;margin:24px;background:#111;color:#eee}
h1{margin-bottom:4px}
.grid{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin:18px 0}
.card{background:#1b1b1b;border:1px solid #444;border-radius:10px;padding:12px}
.ok{color:#7ee787}.warn{color:#f2cc60}.muted{color:#aaa}
table{border-collapse:collapse;width:100%;margin-top:20px}
td,th{border:1px solid #444;padding:8px;vertical-align:top}
th{background:#222}
</style>
</head>
<body>
<h1>ENGREMIAT Backlog Orquestador Local</h1>
<p class="ok">Fuente de verdad local: docs/kanban-backlog/seed-25/*.md</p>
<p class="warn">Kanban nativo write: disabled. Automatizacion: disabled. Uso: apoyo visual y orquestacion humana.</p>
<div class="grid">
<div class="card"><b>Tarjetas</b><br>$($cards.Count)</div>
<div class="card"><b>Lane principal</b><br>VALIDATION</div>
<div class="card"><b>Modo</b><br>READONLY_FIRST</div>
<div class="card"><b>Actualizado</b><br>$((Get-Date).ToString('s'))</div>
</div>
<table>
<thead>
<tr><th>ID</th><th>Lane</th><th>Prioridad</th><th>Tipo</th><th>Titulo</th><th>Status</th><th>Riesgo</th></tr>
</thead>
<tbody>
$rows
</tbody>
</table>
<p class="muted">Siguiente uso recomendado: pedir a Cline/Kanban que lea tarjetas por lotes pequeños y devuelva Review sin modificar archivos.</p>
</body>
</html>
"@
Set-Content -Path $html -Value $htmlText -Encoding UTF8

if(!(Test-Path $html)){LogLine 'ERR board_missing=True' Red;throw 'BOARD_MISSING'}
if(!(Test-Path $manifest)){LogLine 'ERR manifest_missing=True' Red;throw 'MANIFEST_MISSING'}
if(!(Test-Path $index)){LogLine 'ERR index_missing=True' Red;throw 'INDEX_MISSING'}

LogLine "OK cards=$($cards.Count)" Green
LogLine "OK index=$index" Green
LogLine "OK manifest=$manifest" Green
LogLine "OK board=$html" Green
if($OpenBoard){Start-Process $html}
LogLine 'DECISION=GO_LOCAL_ORCHESTRATION_BOARD_REFRESHED' Green
LogLine 'NEXT=CLINE_READ_BATCH_1_5_OR_CREATE_BACKLOG_REFRESH_MODEL' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=REFRESH status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=KANBAN_LOCAL_BACKLOG_REFRESHER_RUN_002'
