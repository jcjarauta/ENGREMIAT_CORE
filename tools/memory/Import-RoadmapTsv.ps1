param(
  [string]$InputPath = 'ENGREMIAT_MEMORY/roadmap/roadmap.tsv',
  [string]$OutputRoot = 'ENGREMIAT_MEMORY/roadmap'
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

EnsureDir $OutputRoot

if(!(Test-Path -LiteralPath $InputPath)){
  Set-Content -LiteralPath $InputPath -Value 'objective_id    stage_id    stage_name    stage_description    stage_deliverable    block_id    block_name    block_description    block_deliverable    step_id    step_name    step_description    step_deliverable    artifact    dependency    format    risk    automatable    priority    status    notes' -Encoding UTF8
  Write-Host ('OK roadmap_tsv_template_created=True path='+$InputPath)
  exit 0
}

$lines=Get-Content -LiteralPath $InputPath -Encoding UTF8
if($lines.Count -lt 2){
  Write-Host ('OK roadmap_rows=0 output='+$OutputRoot)
  exit 0
}

$headers=$lines[0] -split "`t"
$count=0

for($i=1; $i -lt $lines.Count; $i++){
  if([string]::IsNullOrWhiteSpace($lines[$i])){ continue }
  $cells=$lines[$i] -split "`t",-1
  $row=[ordered]@{}
  for($j=0; $j -lt $headers.Count; $j++){
    $val=''
    if($j -lt $cells.Count){ $val=$cells[$j] }
    $row[$headers[$j]]=$val
  }

  $objectiveId=$row['objective_id']
  $stageId=$row['stage_id']
  $blockId=$row['block_id']
  $stepId=$row['step_id']
  $dir=Join-Path $OutputRoot (SafeName $objectiveId)
  EnsureDir $dir
  $out=Join-Path $dir ((SafeName $stepId)+'.md')

  $md=@()
  $md += '# '+$stepId+' - '+$row['step_name']
  $md += ''
  foreach($k in $headers){
    $md += '- '+$k+': '+$row[$k]
  }
  $md += ''
  $md += '## Links'
  $md += '- [['+$objectiveId+']]'
  $md += '- [['+$stageId+']]'
  $md += '- [['+$blockId+']]'
  $md += '- [['+$stepId+']]'

  Set-Content -LiteralPath $out -Value $md -Encoding UTF8
  $count++
}

Write-Host ('OK roadmap_imported=True rows='+$count+' output='+$OutputRoot)
