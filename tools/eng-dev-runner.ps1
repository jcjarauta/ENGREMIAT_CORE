param([string]$Command="status")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$activePath="data/dev/active-row.json"
$packagePath="data/dev/next-package.json"
$lastRunPath="data/dev/last-run.json"
function EnsureDir($p){ if(!(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function LoadJson($p){ if(!(Test-Path -LiteralPath $p)){ throw "Falta archivo requerido: $p" }; return (Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json) }
function SaveJson($p,$o){ EnsureDir (Split-Path -Parent $p); $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8 }
function ValidatePackage($pkg){ $bad=@(); foreach($s in $pkg.steps){ if($s.risk -ne "LOW"){ $bad += "risk_not_low:"+$s.step_id }; if($s.agrupable -ne "SI"){ $bad += "agrupable_no:"+$s.step_id } }; foreach($op in $pkg.forbidden_operations){ if($pkg.allowed_operations -contains $op){ $bad += "forbidden_allowed:"+$op } }; return $bad }
switch($Command){
  "status" { $a=LoadJson $activePath; Write-Host ("OK tool=dev-runner command=status objective="+$a.objective_id+" active="+$a.stage_id+"/"+$a.block_id+"/"+$a.step_id+" risk="+$a.risk+" agrupable="+$a.agrupable+" next="+$a.next.step_id); break }
  "next" { $a=LoadJson $activePath; Write-Host ("OK tool=dev-runner command=next step="+$a.next.step_id+" action="+$a.next.action+" target="+$a.next.target); break }
  "package" { $p=LoadJson $packagePath; Write-Host ("OK tool=dev-runner command=package package="+$p.package_id+" steps="+$p.steps.Count+" mode="+$p.mode+" next="+$p.next); break }
  "validate-package" { $p=LoadJson $packagePath; $bad=ValidatePackage $p; if($bad.Count -gt 0){ Write-Host ("ERR tool=dev-runner command=validate-package errors="+($bad -join ",")); exit 1 }; Write-Host ("OK tool=dev-runner command=validate-package package="+$p.package_id+" validation=True"); break }
  "run-safe" { $p=LoadJson $packagePath; $bad=ValidatePackage $p; if($bad.Count -gt 0){ throw ("Paquete no seguro: "+($bad -join ",")) }; $result=[ordered]@{ tool="dev-runner"; command="run-safe"; package_id=$p.package_id; mode=$p.mode; steps=$p.steps.Count; executed_real_actions=$false; external_network=$false; git_remote=$false; validation_passed=$true; created_at=(Get-Date).ToString("s"); next=$p.next }; SaveJson $lastRunPath $result; Write-Host ("OK tool=dev-runner command=run-safe package="+$p.package_id+" steps="+$p.steps.Count+" real_actions=False next="+$p.next); break }
  default { Write-Host "Uso: .\tools\eng-dev-runner.ps1 status|next|package|validate-package|run-safe" }
}
