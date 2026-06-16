param(
  [string]$MemoryRoot = 'ENGREMIAT_MEMORY',
  [string]$ReportPath = 'reports/dev-visual-memory/e02-templates-capture/memory-integrity-report.json'
)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8

function EnsureDir($p){
  if($p -and !(Test-Path -LiteralPath $p)){
    New-Item -ItemType Directory -Path $p -Force | Out-Null
  }
}
function WriteJson($p,$o){
  EnsureDir (Split-Path -Parent $p)
  $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8
}

$required=@(
  'templates/TEMPLATE_OBJECTIVE.md',
  'templates/TEMPLATE_STEP.md',
  'templates/TEMPLATE_ERROR.md',
  '../tools/memory/Write-MemoryEntry.ps1',
  '../tools/memory/Export-EvidenceToMarkdown.ps1',
  '../tools/memory/Import-RoadmapTsv.ps1'
)

$missing=@()
foreach($rel in $required){
  $p=Join-Path $MemoryRoot $rel
  if($rel -like '../tools/*'){
    $p=$rel.Replace('../','')
  }
  if(!(Test-Path -LiteralPath $p)){ $missing += $p }
}

$notes=@()
if(Test-Path -LiteralPath $MemoryRoot){
  $notes=Get-ChildItem -LiteralPath $MemoryRoot -Recurse -File -Filter '*.md' -ErrorAction SilentlyContinue
}

$report=[ordered]@{
  objective_id='ENGREMIAT_DEV_VISUAL_MEMORY_001'
  stage_id='E02'
  status=$(if($missing.Count -eq 0){'OK'}else{'NO_GO'})
  validation_passed=($missing.Count -eq 0)
  missing=$missing
  markdown_notes=$notes.Count
  checked_at=(Get-Date).ToString('s')
}

WriteJson $ReportPath $report

if($missing.Count -gt 0){
  Write-Host ('ERR memory_integrity=False missing='+($missing -join ','))
  exit 1
}

Write-Host ('OK memory_integrity=True notes='+$notes.Count+' report='+$ReportPath)
