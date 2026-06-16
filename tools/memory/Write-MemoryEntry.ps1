param(
  [string]$Type = 'step',
  [string]$ObjectiveId = 'UNKNOWN_OBJECTIVE',
  [string]$StageId = 'UNKNOWN_STAGE',
  [string]$BlockId = 'UNKNOWN_BLOCK',
  [string]$StepId = 'UNKNOWN_STEP',
  [string]$Title = 'Memory Entry',
  [string]$Status = 'PENDING',
  [string]$Evidence = '',
  [string]$OutputPath = ''
)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8

function EnsureDir($p){
  if($p -and !(Test-Path -LiteralPath $p)){
    New-Item -ItemType Directory -Path $p -Force | Out-Null
  }
}
function SafeName($s){
  $x=[string]$s
  $x=$x -replace '[^\w\.-]+','_'
  if([string]::IsNullOrWhiteSpace($x)){ return 'UNKNOWN' }
  return $x
}

if([string]::IsNullOrWhiteSpace($OutputPath)){
  $base='ENGREMIAT_MEMORY'
  if($Type -eq 'objective'){
    $OutputPath = Join-Path (Join-Path $base 'objectives') ((SafeName $ObjectiveId)+'.md')
  } elseif($Type -eq 'error'){
    $OutputPath = Join-Path (Join-Path $base 'errors') ((SafeName $StepId)+'-error.md')
  } else {
    $OutputPath = Join-Path (Join-Path $base 'steps') ((SafeName $StepId)+'.md')
  }
}

EnsureDir (Split-Path -Parent $OutputPath)

$lines=@()
$lines += '# '+$Title
$lines += ''
$lines += '## Metadata'
$lines += '- objective_id: '+$ObjectiveId
$lines += '- stage_id: '+$StageId
$lines += '- block_id: '+$BlockId
$lines += '- step_id: '+$StepId
$lines += '- type: '+$Type
$lines += '- status: '+$Status
$lines += '- created_at: '+(Get-Date).ToString('s')
$lines += ''
$lines += '## Evidence'
$lines += $Evidence
$lines += ''
$lines += '## Links'
$lines += '- [['+$ObjectiveId+']]'
$lines += '- [['+$StageId+']]'
$lines += '- [['+$BlockId+']]'
$lines += '- [['+$StepId+']]'

Set-Content -LiteralPath $OutputPath -Value $lines -Encoding UTF8
Write-Host ('OK memory_entry_created=True path='+$OutputPath)
