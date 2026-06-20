param([string]$InputPath="data/worker-response-057/worker-response-sample.md")
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$dir="data/worker-response-057";$importDir="data/worker-response-057/imported";$receiptDir="data/worker-response-057/receipts";New-Item -ItemType Directory -Force -Path $dir,$importDir,$receiptDir|Out-Null
if(!(Test-Path $InputPath)){throw "NO_GO worker response input not found: $InputPath"}
$raw=Get-Content $InputPath -Raw
$isJson=$false;$parsed=$null;try{$parsed=$raw|ConvertFrom-Json;$isJson=$true}catch{$isJson=$false}
$importId="WORKER-RESPONSE-"+(Get-Date -Format "yyyyMMdd-HHmmss")
$outPath=Join-Path $importDir ($importId+".imported.json")
if($isJson){$record=[ordered]@{import_id=$importId;input_path=$InputPath;format="JSON";content=$parsed;worker_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}}else{$record=[ordered]@{import_id=$importId;input_path=$InputPath;format="MarkdownOrText";content=$raw;worker_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}}
$record|ConvertTo-Json -Depth 20|Set-Content $outPath -Encoding UTF8
$receiptPath=Join-Path $receiptDir "worker-response-import-receipt.json";$record|ConvertTo-Json -Depth 20|Set-Content $receiptPath -Encoding UTF8
Write-Host ("OK stage=E57 worker_response_imported="+$outPath+" worker_executed=false apply_executed=false auto_apply=false remote_execution=false git_write=false") -ForegroundColor Green
