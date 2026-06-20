param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [string]$InputFile='',
  [switch]$OpenPrompt
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function SafeName($s){
  $x=([string]$s).ToUpperInvariant()
  $x=$x -replace '[^A-Z0-9]+','-'
  $x=$x.Trim('-')
  if(!$x){$x='UNTITLED'}
  if($x.Length -gt 48){$x=$x.Substring(0,48).Trim('-')}
  return $x
}
function MdEscape($s){
  return ([string]$s) -replace '\|','/' -replace "`r",' ' -replace "`n",' '
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=ENGREMIAT_RECURRENT_CARD_REFRESH_RUN_001'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=RUN_RECURRENT_REFRESH operation=LOCAL_FILE_READ_WRITE risk=LOW mode=DRY_RUN no_exec=True native_kanban_write=False obsidian_real_write=False openwebui_real=False timeout_seconds=90'

$base=Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model'
$inputDir=Join-Path $base 'inputs'
$cardDir=Join-Path $base 'cards'
$obsDir=Join-Path $base 'obsidian-candidates'
$batchDir=Join-Path $base 'inline-batches'
$reportDir=Join-Path $Root 'reports\recurrent-card-refresh-model'
New-Item -ItemType Directory -Force -Path $inputDir,$cardDir,$obsDir,$batchDir,$reportDir | Out-Null

if(!$InputFile){
  $InputFile=Join-Path $inputDir 'detected-inputs.sample.json'
}
if(!(Test-Path $InputFile)){
  LogLine "ERR input_missing=$InputFile" Red
  throw 'INPUT_MISSING'
}

$items=Get-Content $InputFile -Raw | ConvertFrom-Json
if($null -eq $items){throw 'EMPTY_INPUT'}
if($items -isnot [System.Collections.IEnumerable] -or $items -is [string]){$items=@($items)}

$createdCards=@()
$createdNotes=@()
$rows=@()
$now=Get-Date
$stamp=$now.ToString('yyyyMMdd-HHmmss')

$i=0
foreach($item in $items){
  $i++
  foreach($field in @('id','source','kind','title','summary','priority','risk')){
    if(!$item.PSObject.Properties.Name.Contains($field) -or [string]::IsNullOrWhiteSpace([string]$item.$field)){
      LogLine "ERR missing_field=$field item_index=$i" Red
      throw 'BAD_INPUT'
    }
  }

  $num='{0:d4}' -f $i
  $slug=SafeName $item.title
  $cardId="ENG-CARD-RECURRENT-$stamp-$num"
  $cardFile=Join-Path $cardDir ($cardId+'.md')
  $noteFile=Join-Path $obsDir ($cardId+'.obsidian-candidate.md')
  $consumers=@($item.target_consumers) -join ', '

  $state='READY'
  if([string]$item.risk -eq 'HIGH'){$state='BACKLOG'}

  $cardLines=@(
    "---"
    "id: $cardId"
    "source_input: $($item.id)"
    "source: $($item.source)"
    "kind: $($item.kind)"
    "state: $state"
    "lane: RECURRENT_INPUT"
    "type: $($item.kind)"
    "priority: $($item.priority)"
    "risk: $($item.risk)"
    "status: READY_FOR_HUMAN_REVIEW"
    "native_kanban_write: disabled"
    "execution_allowed: false"
    "human_review_required: true"
    "---"
    ""
    "# $($item.title)"
    ""
    "## Resumen"
    "$($item.summary)"
    ""
    "## Consumidores previstos"
    "$consumers"
    ""
    "## Reglas"
    "- No ejecutar acciones reales."
    "- No escribir en Kanban nativo."
    "- No escribir en Obsidian real todavia."
    "- No llamar OpenWebUI real."
    "- Requiere revision humana."
    ""
    "## Criterio de exito"
    "La entrada recurrente queda convertida en tarjeta consumible local, nota candidata y prompt inline revisable."
    ""
    "## Siguiente decision humana"
    "PASS / WARN / NO_GO"
  )
  Set-Content -Path $cardFile -Value $cardLines -Encoding UTF8

  $noteLines=@(
    "# $($item.title)"
    ""
    "tags: #engremiat #candidate #$($item.source) #$($item.kind)"
    ""
    "## Origen"
    "- input_id: $($item.id)"
    "- card_id: $cardId"
    "- source: $($item.source)"
    "- kind: $($item.kind)"
    "- risk: $($item.risk)"
    "- priority: $($item.priority)"
    ""
    "## Resumen"
    "$($item.summary)"
    ""
    "## Estado"
    "Nota candidata. No escrita en vault real. Requiere revision humana."
    ""
    "## Relacion ENGREMIAT"
    "Esta nota procede del modelo recurrente detected-input -> consumable-card -> obsidian-note-candidate."
  )
  Set-Content -Path $noteFile -Value $noteLines -Encoding UTF8

  $createdCards += $cardFile
  $createdNotes += $noteFile
  $rows += [pscustomobject]@{
    card_id=$cardId
    title=[string]$item.title
    source=[string]$item.source
    kind=[string]$item.kind
    priority=[int]$item.priority
    risk=[string]$item.risk
    status='READY_FOR_HUMAN_REVIEW'
    card_file=$cardFile
    obsidian_candidate=$noteFile
  }
}

$index=Join-Path $base 'INDEX.md'
$idx=@(
  "# RECURRENT CARD REFRESH MODEL"
  ""
  "generated_at: $($now.ToString('s'))"
  "cards_count: $($rows.Count)"
  "mode: DRY_RUN"
  "native_kanban_write: disabled"
  "obsidian_real_write: disabled"
  "openwebui_real: disabled"
  ""
  "| Card | Source | Kind | Priority | Risk | Status |"
  "|---|---|---|---:|---|---|"
)
foreach($r in $rows){
  $idx += "| $($r.card_id) | $($r.source) | $($r.kind) | $($r.priority) | $($r.risk) | $($r.status) |"
}
Set-Content -Path $index -Value $idx -Encoding UTF8

$batchFile=Join-Path $batchDir ("RECURRENT_INLINE_BATCH_$stamp.md")
$batchLines=@(
  "ENGREMIAT_RECURRENT_CARD_REFRESH_INLINE_BATCH"
  ""
  "Objetivo:"
  "Revisar tarjetas recurrentes generadas en dry-run desde detected-inputs."
  ""
  "Reglas estrictas:"
  "- No modificar archivos."
  "- No crear archivos."
  "- No ejecutar comandos."
  "- No generar codigo."
  "- No escribir en Kanban nativo."
  "- No escribir en Obsidian real."
  "- Solo revisar la tabla incluida en este mensaje."
  ""
  "Decision esperada:"
  "PASS solo si el lote contiene $($rows.Count) tarjetas recurrentes listas para revision humana."
  ""
  "| Card | Source | Kind | Priority | Risk | Title |"
  "|---|---|---|---:|---|---|"
)
foreach($r in $rows){
  $batchLines += "| $($r.card_id) | $($r.source) | $($r.kind) | $($r.priority) | $($r.risk) | $(MdEscape $r.title) |"
}
$batchLines += @(
  ""
  "Responder exactamente:"
  ""
  "DECISION: PASS/WARN/NO_GO"
  "FILES_VISIBLE: inline_content"
  "CARD_COUNT: numero"
  "COMMON_PATTERN: una frase"
  "FIRST_REVIEW_RECOMMENDATION: ID y razon breve"
  "HUMAN_DECISION_REQUIRED: una frase"
  "RISKS: una frase"
  "NO_MODIFICATION_CONFIRMATION: Confirmo que no he modificado, creado ni ejecutado nada."
)
Set-Content -Path $batchFile -Value $batchLines -Encoding UTF8

$manifest=Join-Path $base 'recurrent-card-refresh-manifest.json'
[pscustomobject]@{
  package='ENGREMIAT_RECURRENT_CARD_REFRESH_RUN_001'
  generated_at=$now.ToString('s')
  input_file=$InputFile
  cards_count=$rows.Count
  cards=$rows
  index=$index
  inline_batch=$batchFile
  mode='DRY_RUN'
  native_kanban_write='disabled'
  obsidian_real_write='disabled'
  openwebui_real='disabled'
  decision='GO_RECURRENT_CARD_REFRESH_DRY_RUN_READY'
  next='PASTE_INLINE_BATCH_TO_CLINE_OR_BUILD_OPENCLAW_INPUT_ADAPTER'
} | ConvertTo-Json -Depth 8 | Set-Content -Path $manifest -Encoding UTF8

$report=Join-Path $reportDir ("recurrent-card-refresh-run-$stamp.json")
Copy-Item $manifest $report -Force

$missing=@($index,$batchFile,$manifest,$report) | Where-Object {!(Test-Path $_)}
if($missing.Count -gt 0){
  LogLine ('ERR missing_outputs='+($missing -join ',')) Red
  throw 'MISSING_OUTPUTS'
}

if($OpenPrompt){
  Start-Process notepad.exe $batchFile
}

LogLine "OK input=$InputFile" Green
LogLine "OK cards=$($rows.Count)" Green
LogLine "OK index=$index" Green
LogLine "OK inline_batch=$batchFile" Green
LogLine "OK manifest=$manifest" Green
LogLine "OK report=$report" Green
LogLine 'DECISION=GO_RECURRENT_CARD_REFRESH_DRY_RUN_READY' Green
LogLine 'NEXT=PASTE_INLINE_BATCH_TO_CLINE_OR_BUILD_OPENCLAW_INPUT_ADAPTER' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=RUN_RECURRENT_REFRESH status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=ENGREMIAT_RECURRENT_CARD_REFRESH_RUN_001'
