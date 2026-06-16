param([string]$Command="list",[string]$GateId="",[string]$Reason="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$registry="data/gates/gate-registry.jsonl"
$pendingPath="data/gates/pending-gates.json"
function EnsureDir($p){ if(!(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function LoadItems($path){ $items=@(); if(Test-Path -LiteralPath $path){ foreach($line in Get-Content -LiteralPath $path -Encoding UTF8){ if([string]::IsNullOrWhiteSpace($line)){ continue }; try{ $items += ($line | ConvertFrom-Json) }catch{} } }; return @($items) }
function SaveItems($path,$items){ EnsureDir (Split-Path -Parent $path); $out=@(); foreach($it in @($items)){ $out += ($it | ConvertTo-Json -Depth 100 -Compress) }; Set-Content -LiteralPath $path -Value $out -Encoding UTF8 }
function SavePending($items){ $pending=@($items | Where-Object { $_.decision -eq "PENDING" -and $_.status -eq "OPEN" }); $obj=[ordered]@{ updated_at=(Get-Date).ToString("s"); pending_count=$pending.Count; pending=$pending }; EnsureDir "data/gates"; EnsureDir "reports/gates"; $obj | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $pendingPath -Encoding UTF8; $obj | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath "reports/gates/pending-gates.json" -Encoding UTF8 }
function WriteIndex($items){ EnsureDir "docs"; $lines=@("# GATE_INDEX","","Generado desde data/gates/gate-registry.jsonl.","","| Gate | Paso | Acción | Riesgo | Decisión | Estado | Alcance |","|---|---|---|---|---|---|---|"); foreach($g in ($items | Sort-Object created_at,gate_id)){ $lines += "| "+$g.gate_id+" | "+$g.step_id+" | "+$g.action+" | "+$g.risk+" | "+$g.decision+" | "+$g.status+" | "+$g.scope+" |" }; Set-Content -LiteralPath "docs/GATE_INDEX.md" -Value $lines -Encoding UTF8 }
$items=LoadItems $registry
switch($Command){
  "list" { $items | Select-Object gate_id,objective_id,stage_id,block_id,step_id,action,risk,decision,status | Format-Table -AutoSize; break }
  "pending" { $p=@($items | Where-Object { $_.decision -eq "PENDING" -and $_.status -eq "OPEN" }); $p | Select-Object gate_id,step_id,action,risk,scope,created_at | Format-Table -AutoSize; Write-Host ("OK gates_pending="+$p.Count); break }
  "approve" { if([string]::IsNullOrWhiteSpace($GateId)){ throw "Falta GateId" }; $found=$false; foreach($g in $items){ if($g.gate_id -eq $GateId){ $g.decision="APPROVED"; $g.status="CLOSED"; $g.decided_at=(Get-Date).ToString("s"); $g.decision_reason=$Reason; $found=$true } }; if(!$found){ throw "Gate no encontrado: $GateId" }; SaveItems $registry $items; SavePending $items; WriteIndex $items; Write-Host ("OK gate_approved="+$GateId); break }
  "reject" { if([string]::IsNullOrWhiteSpace($GateId)){ throw "Falta GateId" }; $found=$false; foreach($g in $items){ if($g.gate_id -eq $GateId){ $g.decision="REJECTED"; $g.status="CLOSED"; $g.decided_at=(Get-Date).ToString("s"); $g.decision_reason=$Reason; $found=$true } }; if(!$found){ throw "Gate no encontrado: $GateId" }; SaveItems $registry $items; SavePending $items; WriteIndex $items; Write-Host ("OK gate_rejected="+$GateId); break }
  "history" { $items | Select-Object gate_id,step_id,action,risk,decision,status,created_at,decided_at | Format-Table -AutoSize; break }
  "rebuild-index" { SavePending $items; WriteIndex $items; Write-Host "OK gate_index=docs/GATE_INDEX.md pending=reports/gates/pending-gates.json"; break }
  default { Write-Host "Uso: .\tools\eng-gates.ps1 list|pending|approve <GATE_ID>|reject <GATE_ID>|history|rebuild-index" }
}
