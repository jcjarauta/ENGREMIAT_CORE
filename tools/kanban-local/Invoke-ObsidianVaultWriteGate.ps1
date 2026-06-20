param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [string]$VaultPath='',
  [switch]$Apply
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function SafeRel($s){
  $x=[string]$s
  $x=$x -replace '[\\/:*?"<>|]+','-'
  $x=$x.Trim()
  if(!$x){$x='untitled.md'}
  return $x
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=OBSIDIAN_VAULT_WRITE_GATE_RUN_001'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=VAULT_WRITE_GATE operation=LOCAL_VALIDATE_OR_COPY risk=MEDIUM mode=GATED obsidian_real_write_requires_apply=True timeout_seconds=90'

$exportRoot=Join-Path $Root 'docs\obsidian-export-candidates'
$notesDir=Join-Path $exportRoot 'notes'
$gateDir=Join-Path $exportRoot 'vault-write-gate'
$reportDir=Join-Path $Root 'reports\obsidian-vault-write-gate'
New-Item -ItemType Directory -Force -Path $gateDir,$reportDir | Out-Null

if(!(Test-Path $notesDir)){
  LogLine "ERR notes_dir_missing=$notesDir" Red
  throw 'NOTES_DIR_MISSING'
}

$notes=Get-ChildItem $notesDir -Filter '*.md' -File | Sort-Object Name
if($notes.Count -lt 1){
  LogLine 'ERR no_export_notes=True' Red
  throw 'NO_EXPORT_NOTES'
}

$stamp=(Get-Date).ToString('yyyyMMdd-HHmmss')
$plan=Join-Path $gateDir ("vault-write-plan.$stamp.json")
$preview=Join-Path $gateDir ("vault-write-preview.$stamp.md")
$report=Join-Path $reportDir ("vault-write-gate-run.$stamp.json")

$resolvedVault=''
$targetDir=''
$ready=$false

if($VaultPath){
  $resolvedVault=[IO.Path]::GetFullPath($VaultPath)
  $targetDir=Join-Path $resolvedVault 'ENGREMIAT\Inbox'
  if(Test-Path $resolvedVault){$ready=$true}
}

$items=@()
foreach($n in $notes){
  $destName=SafeRel $n.Name
  $dest=if($targetDir){Join-Path $targetDir $destName}else{''}
  $items += [pscustomobject]@{
    source=$n.FullName
    destination=$dest
    filename=$destName
  }
}

[pscustomobject]@{
  package='OBSIDIAN_VAULT_WRITE_GATE_RUN_001'
  created_at=(Get-Date).ToString('s')
  mode=if($Apply){'APPLY_REQUESTED'}else{'DRY_RUN'}
  apply_requested=[bool]$Apply
  vault_path=$resolvedVault
  target_dir=$targetDir
  vault_path_exists=$ready
  notes_count=$notes.Count
  items=$items
  authorization_required=$true
  required_phrase='AUTORIZO_OBSIDIAN_VAULT_WRITE_GATE_001'
  obsidian_real_write=if($Apply){'requested'}else{'disabled'}
  decision=if($Apply -and $ready){'READY_TO_APPLY_IF_AUTHORIZED'}else{'GO_VAULT_WRITE_PREVIEW_READY'}
} | ConvertTo-Json -Depth 8 | Set-Content -Path $plan -Encoding UTF8

$previewLines=@(
  '# OBSIDIAN VAULT WRITE GATE PREVIEW'
  ''
  "generated_at: $((Get-Date).ToString('s'))"
  "notes_count: $($notes.Count)"
  "apply_requested: $([bool]$Apply)"
  "vault_path: $resolvedVault"
  "target_dir: $targetDir"
  ''
  '## Política'
  '- Este gate NO escribe en vault real salvo que se ejecute con -Apply y ruta de vault válida.'
  '- La autorización humana requerida es: AUTORIZO_OBSIDIAN_VAULT_WRITE_GATE_001'
  '- Por defecto solo genera plan y preview.'
  ''
  '## Notas previstas'
)
foreach($it in $items){
  $previewLines += "- $($it.filename)"
  $previewLines += "  - source: $($it.source)"
  $previewLines += "  - destination: $($it.destination)"
}
Set-Content -Path $preview -Value $previewLines -Encoding UTF8

$copied=@()
if($Apply){
  if(!$VaultPath){
    LogLine 'ERR apply_requested_but_vault_path_missing=True' Red
    throw 'VAULT_PATH_REQUIRED_FOR_APPLY'
  }
  if(!(Test-Path $resolvedVault)){
    LogLine "ERR vault_path_not_found=$resolvedVault" Red
    throw 'VAULT_PATH_NOT_FOUND'
  }

  New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

  foreach($it in $items){
    Copy-Item -Path $it.source -Destination $it.destination -Force
    if(!(Test-Path $it.destination)){
      LogLine "ERR copy_failed=$($it.destination)" Red
      throw 'COPY_FAILED'
    }
    $copied += $it.destination
  }
}

[pscustomobject]@{
  package='OBSIDIAN_VAULT_WRITE_GATE_RUN_001'
  created_at=(Get-Date).ToString('s')
  plan=$plan
  preview=$preview
  notes_count=$notes.Count
  apply_requested=[bool]$Apply
  copied_count=$copied.Count
  copied=$copied
  vault_path=$resolvedVault
  target_dir=$targetDir
  authorization_required=$true
  required_phrase='AUTORIZO_OBSIDIAN_VAULT_WRITE_GATE_001'
  decision=if($Apply){'GO_OBSIDIAN_VAULT_WRITE_APPLIED'}else{'GO_OBSIDIAN_VAULT_WRITE_GATE_PREVIEW_READY'}
  next=if($Apply){'OPEN_OBSIDIAN_AND_REVIEW_IMPORTED_NOTES'}else{'HUMAN_REVIEW_PREVIEW_AND_OPTIONALLY_AUTHORIZE_APPLY'}
} | ConvertTo-Json -Depth 8 | Set-Content -Path $report -Encoding UTF8

if(!(Test-Path $plan)){throw 'PLAN_MISSING'}
if(!(Test-Path $preview)){throw 'PREVIEW_MISSING'}
if(!(Test-Path $report)){throw 'REPORT_MISSING'}

Start-Process notepad.exe $preview

LogLine "OK notes_count=$($notes.Count)" Green
LogLine "OK plan=$plan" Green
LogLine "OK preview=$preview" Green
LogLine "OK report=$report" Green
if($Apply){
  LogLine "OK copied_count=$($copied.Count)" Green
  LogLine 'DECISION=GO_OBSIDIAN_VAULT_WRITE_APPLIED' Green
  LogLine 'NEXT=OPEN_OBSIDIAN_AND_REVIEW_IMPORTED_NOTES' Magenta
}else{
  LogLine 'DECISION=GO_OBSIDIAN_VAULT_WRITE_GATE_PREVIEW_READY' Green
  LogLine 'NEXT=HUMAN_REVIEW_PREVIEW_AND_OPTIONALLY_AUTHORIZE_APPLY' Magenta
}
LogLine 'ENGREMIAT_STEP_END step_id=VAULT_WRITE_GATE status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=OBSIDIAN_VAULT_WRITE_GATE_RUN_001'
