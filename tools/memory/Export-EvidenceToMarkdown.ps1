param(
  [string]$ReportsRoot = 'reports',
  [string]$OutputRoot = 'ENGREMIAT_MEMORY/evidence'
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
$count=0

if(Test-Path -LiteralPath $ReportsRoot){
  $files=Get-ChildItem -LiteralPath $ReportsRoot -Recurse -File -Filter '*.json' -ErrorAction SilentlyContinue
  foreach($file in @($files)){
    try{
      $obj=Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
      $objectiveId=$(if($obj.objective_id){[string]$obj.objective_id}else{'UNKNOWN_OBJECTIVE'})
      $stageId=$(if($obj.stage_id){[string]$obj.stage_id}else{'UNKNOWN_STAGE'})
      $status=$(if($obj.status){[string]$obj.status}else{'UNKNOWN_STATUS'})
      $name=(SafeName ($objectiveId+'-'+$stageId+'-'+$file.BaseName))+'.md'
      $out=Join-Path $OutputRoot $name
      $lines=@()
      $lines += '# Evidence - '+$file.BaseName
      $lines += ''
      $lines += '- objective_id: '+$objectiveId
      $lines += '- stage_id: '+$stageId
      $lines += '- status: '+$status
      $lines += '- source: '+$file.FullName
      $lines += '- created_at: '+(Get-Date).ToString('s')
      $lines += ''
      $lines += '```json'
      $lines += (Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8)
      $lines += '```'
      Set-Content -LiteralPath $out -Value $lines -Encoding UTF8
      $count++
    } catch {}
  }
}

Write-Host ('OK evidence_exported=True count='+$count+' output='+$OutputRoot)
