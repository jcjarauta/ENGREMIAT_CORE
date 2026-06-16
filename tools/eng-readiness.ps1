param([string]$Command="current",[string]$Value="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
$readinessPath="data/dev/readiness.json"
function EnsureDir($p){ if(!(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function LoadJson($p){ if(!(Test-Path -LiteralPath $p)){ throw "Falta archivo requerido: $p" }; return (Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json) }
function WriteReports($r){ EnsureDir "reports/readiness"; $r | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath "reports/readiness/current-readiness.json" -Encoding UTF8; $lines=@("# READINESS","","objective="+$r.objective_id,"scope="+$r.scope,"readiness="+$r.readiness,"decision="+$r.decision,"gates_pending="+$r.gates_pending,"errors_open="+$r.errors_open,"","## Blockers"); if($r.blockers.Count -eq 0){ $lines += "- none" } else { foreach($b in $r.blockers){ $lines += "- "+$b } }; Set-Content -LiteralPath "reports/readiness/current-readiness.md" -Value $lines -Encoding UTF8; $html=@("<!doctype html><html><head><meta charset='utf-8'><title>ENGREMIAT Readiness</title><style>body{font-family:Arial;margin:32px} .ok{color:green}.bad{color:#b00020}.card{border:1px solid #ddd;padding:16px;border-radius:8px;margin:12px 0}</style></head><body>","<h1>ENGREMIAT Readiness</h1>","<div class='card'><b>Objective:</b> "+$r.objective_id+"<br><b>Readiness:</b> "+$r.readiness+"<br><b>Decision:</b> "+$r.decision+"</div>","<div class='card'><b>Gates pending:</b> "+$r.gates_pending+"<br><b>Errors open:</b> "+$r.errors_open+"</div>","<h2>Blockers</h2><ul>"); if($r.blockers.Count -eq 0){ $html += "<li>none</li>" } else { foreach($b in $r.blockers){ $html += "<li>"+$b+"</li>" } }; $html += "</ul></body></html>"; Set-Content -LiteralPath "reports/readiness/index.html" -Value $html -Encoding UTF8 }
$r=LoadJson $readinessPath
switch($Command){
  "current" { Write-Host ("OK tool=readiness objective="+$r.objective_id+" readiness="+$r.readiness+" decision="+$r.decision+" blockers="+$r.blockers.Count+" gates_pending="+$r.gates_pending+" errors_open="+$r.errors_open); break }
  "objective" { if([string]::IsNullOrWhiteSpace($Value)){ $Value=$r.objective_id }; Write-Host ("OK tool=readiness objective="+$Value+" readiness="+$r.readiness+" decision="+$r.decision); break }
  "blockers" { if($r.blockers.Count -eq 0){ Write-Host "OK blockers=0" } else { foreach($b in $r.blockers){ Write-Host ("BLOCKER "+$b) }; Write-Host ("OK blockers="+$r.blockers.Count) }; break }
  "report" { WriteReports $r; Write-Host "OK readiness_reports=reports/readiness/current-readiness.json,reports/readiness/current-readiness.md,reports/readiness/index.html"; break }
  default { Write-Host "Uso: .\tools\eng-readiness.ps1 current|objective <ID>|blockers|report" }
}
