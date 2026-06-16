param([string]$RequestPath="data/controlled-worker-adapters/cline/sample-cline-request.json",[string]$GatePath="data/controlled-worker-adapters/sample-human-gate-decision.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
function Sha([string]$Path){if(Test-Path -LiteralPath $Path -PathType Leaf){return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()}else{return $null}}
$base="data/controlled-worker-adapters"
$receipts=Join-Path $base "receipts"
EnsureDir $receipts
$req=Get-Content -LiteralPath $RequestPath -Raw|ConvertFrom-Json
$gate=Get-Content -LiteralPath $GatePath -Raw|ConvertFrom-Json
$executionAllowed=($gate.decision -eq "APPROVE" -and $gate.human_confirmation -eq $true -and $req.limits.dry_run -eq $false)
$response=[ordered]@{response_id=("RESP-SIM-"+(Get-Date -Format "yyyyMMddHHmmss"));request_id=$req.request_id;worker_id=$req.worker_id;worker_type="simulated_worker";status="SIMULATED_NO_EXECUTION";decision=$gate.decision;no_execution=$true;dry_run=$true;execution_allowed_by_gate=$executionAllowed;output=[ordered]@{summary="Simulacion local generada. No se lanzo Cline ni Ollama.";safe=$true};evidence=[ordered]@{request_path=$RequestPath;gate_path=$GatePath;worker_real_execution=$false;cline_launched=$false;ollama_called=$false;auto_apply=$false;git_write=$false};created_at=(Get-Date).ToString("s")}
$responsePath=Join-Path $base "fake-worker-response.json"
WriteJson $responsePath $response
$receipt=[ordered]@{receipt_id=("RECEIPT-SIM-"+(Get-Date -Format "yyyyMMddHHmmss"));request_id=$req.request_id;worker_id=$req.worker_id;decision=$gate.decision;execution_allowed=$executionAllowed;executed=$false;no_execution=$true;response_path=$responsePath;response_sha256=Sha $responsePath;request_sha256=Sha $RequestPath;gate_sha256=Sha $GatePath;worker_real_execution=$false;auto_apply=$false;git_write=$false;created_at=(Get-Date).ToString("s")}
$receiptPath=Join-Path $receipts "sample-worker-receipt.json"
WriteJson $receiptPath $receipt
Write-Host ("OK worker_execution_simulated=True executed=False no_execution=True response="+$responsePath+" receipt="+$receiptPath+" worker_real_execution=False auto_apply=False git_write=False") -ForegroundColor Green
