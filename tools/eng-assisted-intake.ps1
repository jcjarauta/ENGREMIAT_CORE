param([string]$Command="validate",[string]$InputPath="data/dev-assisted-worker/agent-result-proposal.fixture.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function WriteJson($p,$o){ EnsureDir (Split-Path -Parent $p); $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8 }
function LoadJson($p){ if(!(Test-Path -LiteralPath $p)){ throw "Falta input: $p" }; return (Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json) }
function ValidateProposal($p){ $bad=@(); foreach($k in @("task_id","summary","proposed_changes","files_touched","evidence","risks","validation_suggested","apply_recommendation","created_at")){ if(-not $p.PSObject.Properties.Name.Contains($k)){ $bad += "missing:"+$k } }; if($p.apply_recommendation -eq "AUTO_APPLY"){ $bad += "auto_apply_forbidden" }; foreach($f in @($p.files_touched)){ if(([string]$f) -like ".git/*" -or ([string]$f) -like "secrets/*" -or ([string]$f) -eq ".env"){ $bad += "forbidden_path:"+([string]$f) } }; return $bad }
switch($Command){
  "validate" { $p=LoadJson $InputPath; $bad=ValidateProposal $p; if($bad.Count -gt 0){ Write-Host ("ERR assisted_intake_validate errors="+($bad -join ",")); exit 1 }; Write-Host ("OK assisted_intake_validate=True task_id="+$p.task_id+" recommendation="+$p.apply_recommendation); break }
  "import" { $p=LoadJson $InputPath; $bad=ValidateProposal $p; if($bad.Count -gt 0){ throw ("Proposal invalid: "+($bad -join ",")) }; $dir="data/dev-assisted-worker/results/"+$p.task_id; EnsureDir $dir; WriteJson ($dir+"/agent-result-proposal.json") $p; Write-Host ("OK assisted_intake_imported=True path="+$dir+"/agent-result-proposal.json"); break }
  "summarize" { $p=LoadJson $InputPath; Write-Host ("OK assisted_intake_summary task_id="+$p.task_id+" changes="+$p.proposed_changes.Count+" risks="+$p.risks.Count+" recommendation="+$p.apply_recommendation); break }
  "create-review-request" { $p=LoadJson $InputPath; $review=[ordered]@{ task_id=$p.task_id; summary=$p.summary; files_touched=$p.files_touched; risks=$p.risks; validation_suggested=$p.validation_suggested; options=@("APPROVE","REJECT","REQUEST_CHANGES"); apply_allowed=$false; human_gate_required=$true; created_at=(Get-Date).ToString("s") }; WriteJson "data/dev-assisted-worker/results/assisted-worker-review-request.json" $review; Write-Host "OK review_request=data/dev-assisted-worker/results/assisted-worker-review-request.json"; break }
  default { Write-Host "Uso: .\tools\eng-assisted-intake.ps1 validate|import|summarize|create-review-request [InputPath]" }
}
