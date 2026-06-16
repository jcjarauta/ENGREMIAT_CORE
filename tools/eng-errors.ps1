param([string]$Command="known",[string]$Signature="",[string]$Where="",[string]$RootCause="",[string]$Repair="",[string]$Rule="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$registry="data/errors/error-memory.jsonl"
$lastPath="data/errors/last-error.json"
function EnsureDir($p){ if(!(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function LoadItems($path){ $items=@(); if(Test-Path -LiteralPath $path){ foreach($line in Get-Content -LiteralPath $path -Encoding UTF8){ if([string]::IsNullOrWhiteSpace($line)){ continue }; try{ $items += ($line | ConvertFrom-Json) }catch{} } }; return @($items) }
function SaveItems($path,$items){ EnsureDir (Split-Path -Parent $path); $out=@(); foreach($it in @($items)){ $out += ($it | ConvertTo-Json -Depth 100 -Compress) }; Set-Content -LiteralPath $path -Value $out -Encoding UTF8 }
function WritePlaybook($items){ EnsureDir "docs"; $lines=@("# ERROR_PLAYBOOK","","Generado desde data/errors/error-memory.jsonl.","","| Error | Firma | Causa | Reparación | Prevención | Estado |","|---|---|---|---|---|---|"); foreach($e in ($items | Sort-Object error_id)){ $lines += "| "+$e.error_id+" | "+$e.signature+" | "+$e.root_cause+" | "+$e.repair_used+" | "+$e.prevention_rule+" | "+$e.status+" |" }; Set-Content -LiteralPath "docs/ERROR_PLAYBOOK.md" -Value $lines -Encoding UTF8 }
$items=LoadItems $registry
switch($Command){
  "known" { $items | Select-Object error_id,signature,status,prevention_rule | Format-Table -AutoSize; Write-Host ("OK known_errors="+$items.Count); break }
  "last" { if(Test-Path -LiteralPath $lastPath){ Get-Content -LiteralPath $lastPath -Raw -Encoding UTF8 } else { Write-Host "OK last_error=null" }; break }
  "hints" { foreach($e in $items){ Write-Host ("HINT "+$e.error_id+" signature="+$e.signature+" prevention="+$e.prevention_rule) }; Write-Host ("OK hints="+$items.Count); break }
  "add" { if([string]::IsNullOrWhiteSpace($Signature)){ throw "Falta -Signature" }; $id="ERR-USER-"+(Get-Date -Format "yyyyMMddHHmmss"); $rec=[ordered]@{ error_id=$id; signature=$Signature; where=$Where; root_cause=$RootCause; repair_used=$Repair; files_affected=@(); prevention_rule=$Rule; status="OPEN"; created_at=(Get-Date).ToString("s"); tags=@("manual") }; $items += $rec; SaveItems $registry $items; $last=[ordered]@{ updated_at=(Get-Date).ToString("s"); last_error=$rec; open_count=@($items | Where-Object { $_.status -eq "OPEN" }).Count; known_count=$items.Count; registry=$registry }; $last | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $lastPath -Encoding UTF8; WritePlaybook $items; Write-Host ("OK error_added="+$id); break }
  "rebuild-playbook" { WritePlaybook $items; Write-Host "OK error_playbook=docs/ERROR_PLAYBOOK.md count=$($items.Count)"; break }
  default { Write-Host "Uso: .\tools\eng-errors.ps1 known|last|hints|add -Signature ...|rebuild-playbook" }
}
