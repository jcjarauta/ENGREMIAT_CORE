param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [string]$CardDir='docs\kanban-backlog\seed-25',
  [int]$From=21,
  [int]$To=25,
  [int]$BatchNumber=5,
  [switch]$OpenPrompt
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function ReadField($Text,$Name){
  $line=($Text -split "`r?`n"|Where-Object{$_ -match ("^"+[regex]::Escape($Name)+":")}|Select-Object -First 1)
  if(!$line){return ''}
  return (($line -replace ("^"+[regex]::Escape($Name)+":\s*"),'').Trim())
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=KANBAN_INLINE_BATCH_PROMPT_RUN_001'
LogLine "ENGREMIAT_STEP_BEGIN step_id=GENERATE_INLINE_BATCH operation=LOCAL_FILE_READ_WRITE risk=LOW input=$CardDir output=cline-inline-batches validation=PROMPT_EXISTS rollback=DELETE_PROMPT timeout_seconds=60"

$absCardDir=Join-Path $Root $CardDir
$outDir=Join-Path $Root 'docs\kanban-backlog\cline-inline-batches'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

if(!(Test-Path $absCardDir)){
  LogLine "ERR card_dir_missing=$absCardDir" Red
  throw 'CARD_DIR_MISSING'
}

$ids=$From..$To|ForEach-Object{'KANBAN-SEED-{0:d4}' -f $_}
$cards=@()

foreach($id in $ids){
  $file=Join-Path $absCardDir ($id+'.md')
  if(!(Test-Path $file)){
    LogLine "ERR missing_card=$file" Red
    throw 'CARD_MISSING'
  }
  $txt=Get-Content $file -Raw
  $cards += [pscustomobject]@{
    id=$id
    lane=ReadField $txt 'Lane'
    priority=ReadField $txt 'Prioridad'
    type=ReadField $txt 'Tipo'
    title=ReadField $txt 'Titulo'
    status=ReadField $txt 'Status'
    risk=ReadField $txt 'Riesgo'
  }
}

if($cards.Count -ne (($To-$From)+1)){
  LogLine "ERR bad_card_count=$($cards.Count)" Red
  throw 'BAD_CARD_COUNT'
}

$batchId='BATCH_{0:d3}' -f $BatchNumber
$promptFile=Join-Path $outDir ("CLINE_SEED_25_$batchId`_INLINE_PROMPT.md")
$reportFile=Join-Path $outDir ("CLINE_SEED_25_$batchId`_INLINE_PROMPT.report.json")

$first=$ids[0]
$last=$ids[-1]

$lines=@(
  "ENGREMIAT_CLINE_$batchId`_INLINE_READONLY"
  ''
  'Objetivo:'
  "Revisar el lote $BatchNumber del backlog orquestador local sin leer archivos externos y sin modificar nada."
  ''
  'Reglas estrictas:'
  '- No modificar archivos.'
  '- No crear archivos.'
  '- No ejecutar comandos.'
  '- No generar codigo.'
  '- No generar HTML.'
  '- No inventar rutas.'
  '- No proponer integracion.'
  '- Solo revisar la tabla incluida en este mensaje.'
  ''
  'Decision esperada:'
  "PASS solo si este mensaje contiene exactamente $($cards.Count) tarjetas desde $first hasta $last."
  ''
  "## LOTE $BatchNumber"
  ''
  '| ID | Lane | Prioridad | Tipo | Titulo | Status | Riesgo |'
  '|---|---|---:|---|---|---|---|'
)

foreach($c in $cards){
  $lines += "| $($c.id) | $($c.lane) | $($c.priority) | $($c.type) | $($c.title) | $($c.status) | $($c.risk) |"
}

$lines += @(
  ''
  'Responder exactamente:'
  ''
  'DECISION: PASS/WARN/NO_GO'
  ''
  'FILES_VISIBLE: inline_content'
  ''
  'CARD_COUNT: numero'
  ''
  "FIRST_CARD: $first true/false"
  ''
  "LAST_CARD: $last true/false"
  ''
  'COMMON_PATTERN: una frase'
  ''
  'FIRST_REVIEW_RECOMMENDATION: ID y razon breve'
  ''
  'HUMAN_DECISION_REQUIRED: una frase'
  ''
  'RISKS: una frase'
  ''
  'NO_MODIFICATION_CONFIRMATION: Confirmo que no he modificado, creado ni ejecutado nada.'
)

Set-Content -Path $promptFile -Value $lines -Encoding UTF8

[pscustomobject]@{
  package='KANBAN_INLINE_BATCH_PROMPT_RUN_001'
  created_at=(Get-Date).ToString('s')
  batch=$batchId
  from=$From
  to=$To
  cards_count=$cards.Count
  first=$first
  last=$last
  prompt=$promptFile
  mode='inline_for_same_cline_session'
  kanban_native_write='disabled'
  automation='human_copy_paste_only'
  decision='GO_INLINE_BATCH_PROMPT_READY'
} | ConvertTo-Json -Depth 6 | Set-Content -Path $reportFile -Encoding UTF8

if(!(Test-Path $promptFile)){
  LogLine 'ERR prompt_missing=True' Red
  throw 'PROMPT_MISSING'
}

LogLine "OK batch=$batchId" Green
LogLine "OK cards=$($cards.Count)" Green
LogLine "OK first=$first" Green
LogLine "OK last=$last" Green
LogLine "OK prompt=$promptFile" Green
LogLine "OK report=$reportFile" Green

if($OpenPrompt){
  Start-Process notepad.exe $promptFile
}

LogLine 'DECISION=GO_INLINE_BATCH_PROMPT_READY' Green
LogLine 'NEXT=PASTE_GENERATED_PROMPT_IN_SAME_CLINE_SESSION' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=GENERATE_INLINE_BATCH status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=KANBAN_INLINE_BATCH_PROMPT_RUN_001'
