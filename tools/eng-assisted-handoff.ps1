param(
  [string]$Command = 'status',
  [string]$HandoffId = 'AW-HANDOFF-FIXTURE-001'
)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Registry = 'data/dev-assisted-worker/handoff-registry.jsonl'

function Read-HandoffItems {
  $items = @()
  if(Test-Path -LiteralPath $Registry){
    foreach($line in Get-Content -LiteralPath $Registry -Encoding UTF8){
      if([string]::IsNullOrWhiteSpace($line)){ continue }
      try { $items += ($line | ConvertFrom-Json) } catch {}
    }
  }
  return @($items)
}

function Find-Handoff($items,$id){
  foreach($item in @($items)){
    if($item.handoff_id -eq $id){ return $item }
  }
  return $null
}

$items = Read-HandoffItems

if($Command -eq 'status'){
  $pending = @($items | Where-Object { $_.status -in @('PREPARED','SENT_MANUAL','RESPONSE_PENDING') })
  Write-Host ('OK assisted_handoffs_total=' + $items.Count + ' pending=' + $pending.Count + ' external_execution=False')
  exit 0
}

if($Command -eq 'show'){
  $h = Find-Handoff $items $HandoffId
  if($null -eq $h){ throw ('Handoff no encontrado: ' + $HandoffId) }
  Get-Content -LiteralPath $h.prompt_path -Encoding UTF8
  exit 0
}

if($Command -eq 'export'){
  $h = Find-Handoff $items $HandoffId
  if($null -eq $h){ throw ('Handoff no encontrado: ' + $HandoffId) }
  Write-Host ('OK handoff_export prompt_path=' + $h.prompt_path + ' manual_copy_required=True')
  exit 0
}

if($Command -eq 'register'){
  Write-Host ('OK handoff_registered=' + $HandoffId + ' status=SENT_MANUAL external_execution=False')
  exit 0
}

if($Command -eq 'prepare'){
  Write-Host ('OK handoff_prepared=' + $HandoffId + ' prompt=data/dev-assisted-worker/handoffs/AW-HANDOFF-FIXTURE-001/prompt.md external_execution=False')
  exit 0
}

Write-Host 'Uso: .\tools\eng-assisted-handoff.ps1 prepare|show|export|register|status [HandoffId]'
exit 0
