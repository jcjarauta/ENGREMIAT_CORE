param([string]$Command="list",[string]$Value="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir($p){ if(!(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function LoadItems($path){ $items=@(); if(Test-Path -LiteralPath $path){ foreach($line in Get-Content -LiteralPath $path -Encoding UTF8){ if([string]::IsNullOrWhiteSpace($line)){ continue }; try{ $items += ($line | ConvertFrom-Json) }catch{} } }; return @($items) }
function WriteIndex($items){ EnsureDir "docs"; $lines=@("# ARTIFACT_INDEX","","Generado desde data/registry/artifact-registry.jsonl.",""); foreach($obj in ($items | Group-Object objective_id | Sort-Object Name)){ $lines += "## "+$obj.Name; $lines += ""; $lines += "| Paso | Artefacto | Ruta | Tipo | Estado |"; $lines += "|---|---|---|---|---|"; foreach($a in ($obj.Group | Sort-Object stage_id,block_id,step_id,name)){ $lines += "| "+$a.step_id+" | "+$a.name+" | "+$a.path+" | "+$a.artifact_type+" | "+$a.status+" |" }; $lines += "" }; Set-Content -LiteralPath "docs/ARTIFACT_INDEX.md" -Value $lines -Encoding UTF8 }
$registry="data/registry/artifact-registry.jsonl"
$items=LoadItems $registry
switch($Command){
  "list" { $items | Select-Object objective_id,stage_id,block_id,step_id,name,path,status | Format-Table -AutoSize; break }
  "latest" { $items | Select-Object -Last 20 objective_id,stage_id,block_id,step_id,name,path,status | Format-Table -AutoSize; break }
  "step" { $items | Where-Object { $_.step_id -eq $Value } | Select-Object objective_id,stage_id,block_id,step_id,name,path,status | Format-Table -AutoSize; break }
  "objective" { $items | Where-Object { $_.objective_id -eq $Value } | Select-Object objective_id,stage_id,block_id,step_id,name,path,status | Format-Table -AutoSize; break }
  "find" { $items | Where-Object { ($_.name -like "*$Value*") -or ($_.path -like "*$Value*") -or ($_.description -like "*$Value*") } | Select-Object objective_id,stage_id,block_id,step_id,name,path,status | Format-Table -AutoSize; break }
  "rebuild-index" { WriteIndex $items; Write-Host "OK artifacts_index=docs/ARTIFACT_INDEX.md count=$($items.Count)"; break }
  default { Write-Host "Uso: .\tools\eng-artifacts.ps1 list|latest|step <ID>|objective <ID>|find <text>|rebuild-index" }
}
