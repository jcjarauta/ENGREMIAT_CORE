param([ValidateSet("APPROVE","REPAIR","DEFER","REJECT")][string]$Decision="DEFER",[string]$Reason="Decision humana no especificada: default DEFER",[string]$ProposalId="E38_ROUNDTRIP_IMPORTED_SAMPLE",[string]$Operator=$env:USERNAME)
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$dir="data/decision-console-039";$receiptDir="data/decision-console-039/receipts";New-Item -ItemType Directory -Force -Path $dir,$receiptDir|Out-Null
$receipt=[ordered]@{objective="ENGREMIAT_MVP_HUMAN_USABLE_036_045";stage="E39";decision_id=("DECISION-"+(Get-Date -Format "yyyyMMdd-HHmmss"));proposal_id=$ProposalId;decision=$Decision;reason=$Reason;operator=$Operator;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}
$path=Join-Path $receiptDir "human-decision-console-receipt.json";$receipt|ConvertTo-Json -Depth 10|Set-Content $path -Encoding UTF8
$gatePath=Join-Path $dir "active-decision-gate.json";if(Test-Path $gatePath){$gate=Get-Content $gatePath -Raw|ConvertFrom-Json;$gate.current_decision=$Decision;$gate.reason=$Reason;$gate.status="DECIDED";$gate.updated_at=(Get-Date).ToString("s");$gate|ConvertTo-Json -Depth 10|Set-Content $gatePath -Encoding UTF8}
$msg="OK stage=E39 decision="+$Decision+" receipt="+$path+" apply_executed=false auto_apply=false remote_execution=false git_write=false";Write-Host $msg -ForegroundColor Green
