param([string]$Command="show")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$snapshotPath="data/dev/context-snapshot.json"
function LoadSnapshot(){ if(!(Test-Path -LiteralPath $snapshotPath)){ throw "No existe context snapshot: $snapshotPath" }; return (Get-Content -LiteralPath $snapshotPath -Raw -Encoding UTF8 | ConvertFrom-Json) }
function WriteCurrentContext($s){ $lines=@("# CURRENT_CONTEXT","","objective="+$s.objective_id,"active_stage="+$s.active_stage,"active_block="+$s.active_block,"active_step="+$s.active_step,"last_validated="+$s.last_validated,"next="+$s.next.step_id+" "+$s.next.action,"","## Normas activas"); foreach($n in $s.norms){ $lines += "- "+$n }; $lines += ""; $lines += "## Artefactos recientes"; foreach($a in $s.artifacts){ $lines += "- "+$a.step_id+" | "+$a.name+" | "+$a.path }; if(!(Test-Path -LiteralPath "docs")){ New-Item -ItemType Directory -Path "docs" -Force | Out-Null }; if(!(Test-Path -LiteralPath "reports/context")){ New-Item -ItemType Directory -Path "reports/context" -Force | Out-Null }; Set-Content -LiteralPath "docs/CURRENT_CONTEXT.md" -Value $lines -Encoding UTF8; Set-Content -LiteralPath "reports/context/last-context.txt" -Value $lines -Encoding UTF8 }
$s=LoadSnapshot
switch($Command){
  "show" { Write-Host ("OK context objective="+$s.objective_id+" active="+$s.active_stage+"/"+$s.active_block+"/"+$s.active_step+" last_validated="+$s.last_validated+" next="+$s.next.step_id) }
  "full" { $s | ConvertTo-Json -Depth 100 }
  "chat" { Write-Host ("Estamos en "+$s.objective_id+". Último paso validado: "+$s.last_validated+". Paso activo: "+$s.active_step+". Siguiente paso: "+$s.next.step_id+" - "+$s.next.action+". Normas activas: "+(($s.norms) -join ", ") ) }
  "rebuild" { WriteCurrentContext $s; Write-Host "OK current_context=docs/CURRENT_CONTEXT.md last_context=reports/context/last-context.txt" }
  default { Write-Host "Uso: .\tools\eng-context.ps1 show|full|chat|rebuild" }
}
