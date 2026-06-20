param([string]$InputPath="data/worker-import-049/worker-proposal-sample.json")
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$dir="data/worker-import-049";$receiptDir="data/worker-import-049/receipts";New-Item -ItemType Directory -Force -Path $dir,$receiptDir|Out-Null
if(!(Test-Path $InputPath)){throw "NO_GO worker proposal input not found: $InputPath"}
$raw=Get-Content $InputPath -Raw
$isJson=$false;$proposal=$null;try{$proposal=$raw|ConvertFrom-Json;$isJson=$true}catch{$isJson=$false}
$importId="WORKER-IMPORT-"+(Get-Date -Format "yyyyMMdd-HHmmss")
$outPath=Join-Path $dir ($importId+".imported.json")
if($isJson){$record=[ordered]@{import_id=$importId;input_path=$InputPath;format="JSON";proposal=$proposal;worker_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}}else{$record=[ordered]@{import_id=$importId;input_path=$InputPath;format="MarkdownOrText";content=$raw;worker_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}}
$record|ConvertTo-Json -Depth 20|Set-Content $outPath -Encoding UTF8
$receiptPath=Join-Path $receiptDir "worker-import-receipt.json";$record|ConvertTo-Json -Depth 20|Set-Content $receiptPath -Encoding UTF8
Write-Host ("OK stage=E49 worker_import=ready imported="+$outPath+" apply_executed=false auto_apply=false remote_execution=false git_write=false") -ForegroundColor Green
