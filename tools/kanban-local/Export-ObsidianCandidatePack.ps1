param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [switch]$OpenIndex
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function Slug($s){
  $x=([string]$s).ToLowerInvariant() -replace '[^a-z0-9]+','-'
  $x=$x.Trim('-')
  if(!$x){$x='untitled'}
  if($x.Length -gt 64){$x=$x.Substring(0,64).Trim('-')}
  return $x
}
function ReadFront($txt,$name){
  $line=($txt -split "`r?`n"|Where-Object{$_ -match ("^"+[regex]::Escape($name)+":")}|Select-Object -First 1)
  if(!$line){return ''}
  return (($line -replace ("^"+[regex]::Escape($name)+":\s*"),'').Trim())
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=OBSIDIAN_CANDIDATE_EXPORT_RUN_001'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=EXPORT_OBSIDIAN_CANDIDATES operation=LOCAL_FILE_READ_WRITE risk=LOW mode=DRY_RUN obsidian_real_write=False vault_write=False timeout_seconds=90'

$modelDir=Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model'
$candidateDir=Join-Path $modelDir 'obsidian-candidates'
$cardDir=Join-Path $modelDir 'cards'
$exportRoot=Join-Path $Root 'docs\obsidian-export-candidates'
$exportNotes=Join-Path $exportRoot 'notes'
$reportDir=Join-Path $Root 'reports\obsidian-export-adapter'
New-Item -ItemType Directory -Force -Path $exportRoot,$exportNotes,$reportDir | Out-Null

if(!(Test-Path $candidateDir)){
  LogLine "ERR candidate_dir_missing=$candidateDir" Red
  throw 'CANDIDATE_DIR_MISSING'
}

$candidates=Get-ChildItem $candidateDir -Filter '*.obsidian-candidate.md' -File | Sort-Object LastWriteTime,Name
if($candidates.Count -lt 1){
  LogLine 'ERR no_obsidian_candidates=True' Red
  throw 'NO_CANDIDATES'
}

$stamp=(Get-Date).ToString('yyyyMMdd-HHmmss')
$exported=@()

foreach($cand in $candidates){
  $txt=Get-Content $cand.FullName -Raw
  $titleLine=($txt -split "`r?`n"|Where-Object{$_ -match '^#\s+'}|Select-Object -First 1)
  $title=if($titleLine){($titleLine -replace '^#\s+','').Trim()}else{[IO.Path]::GetFileNameWithoutExtension($cand.Name)}
  $slug=Slug $title
  $dest=Join-Path $exportNotes ($slug+'.md')

  $body=@(
    '---'
    "engremiat_export: true"
    "export_mode: dry_run"
    "obsidian_real_write: false"
    "source_candidate: $($cand.FullName)"
    "exported_at: $((Get-Date).ToString('s'))"
    'tags: [engremiat, candidate, obsidian-export, dry-run]'
    '---'
    ''
    $txt
    ''
    '---'
    ''
    '## ENGREMIAT Export Status'
    ''
    '- Estado: candidato exportable.'
    '- Escritura en vault real: desactivada.'
    '- Revisión humana requerida: true.'
    '- Acción real permitida: false.'
  )

  Set-Content -Path $dest -Value $body -Encoding UTF8
  $exported += [pscustomobject]@{
    title=$title
    source=$cand.FullName
    export=$dest
  }
}

$index=Join-Path $exportRoot 'OBSIDIAN_EXPORT_INDEX.md'
$idx=@(
  '# OBSIDIAN EXPORT CANDIDATES'
  ''
  "generated_at: $((Get-Date).ToString('s'))"
  "mode: DRY_RUN"
  "obsidian_real_write: false"
  "vault_write: false"
  "notes_count: $($exported.Count)"
  ''
  '## Uso'
  'Estas notas son candidatas exportables. No se han escrito en un vault real de Obsidian.'
  ''
  '## Notas'
)
foreach($e in $exported){
  $idx += "- [$($e.title)]($($e.export))"
}
Set-Content -Path $index -Value $idx -Encoding UTF8

$manifest=Join-Path $exportRoot 'obsidian-export-manifest.json'
[pscustomobject]@{
  package='OBSIDIAN_CANDIDATE_EXPORT_RUN_001'
  created_at=(Get-Date).ToString('s')
  mode='DRY_RUN'
  obsidian_real_write=$false
  vault_write=$false
  notes_count=$exported.Count
  notes=$exported
  index=$index
  decision='GO_OBSIDIAN_EXPORT_CANDIDATES_READY'
  next='HUMAN_REVIEW_OBSIDIAN_CANDIDATES_OR_BUILD_VAULT_GATE'
} | ConvertTo-Json -Depth 8 | Set-Content -Path $manifest -Encoding UTF8

$report=Join-Path $reportDir ("obsidian-export-run.$stamp.json")
Copy-Item $manifest $report -Force

$missing=@($index,$manifest,$report)|Where-Object{!(Test-Path $_)}
if($missing.Count -gt 0){
  LogLine ('ERR missing_outputs='+($missing -join ',')) Red
  throw 'MISSING_OUTPUTS'
}

if($OpenIndex){
  Start-Process notepad.exe $index
}

LogLine "OK candidates=$($candidates.Count)" Green
LogLine "OK exported_notes=$($exported.Count)" Green
LogLine "OK index=$index" Green
LogLine "OK manifest=$manifest" Green
LogLine "OK report=$report" Green
LogLine 'DECISION=GO_OBSIDIAN_EXPORT_CANDIDATES_READY' Green
LogLine 'NEXT=HUMAN_REVIEW_OBSIDIAN_CANDIDATES_OR_BUILD_VAULT_GATE' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=EXPORT_OBSIDIAN_CANDIDATES status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=OBSIDIAN_CANDIDATE_EXPORT_RUN_001'
