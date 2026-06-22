param([string]$CardPath="C:\ENGREMIAT_CORE\documents\module-cards\module-linked-card.example.json")
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core='C:\ENGREMIAT_CORE'
$ValidatorPath=Join-Path $Core 'tools\module-cards\validate-module-card.ps1'
$MatrixPath=Join-Path $Core 'documents\module-cards\card-to-module-decision-matrix.json'
function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
if(!(Test-Path $ValidatorPath)){throw "Missing validator $ValidatorPath"}
if(!(Test-Path $MatrixPath)){throw "Missing decision matrix $MatrixPath"}
& powershell -NoProfile -ExecutionPolicy Bypass -File $ValidatorPath -CardPath $CardPath
if($LASTEXITCODE -ne 0){throw "Base card validation failed"}
$card=Get-Content $CardPath -Raw|ConvertFrom-Json
$matrix=Get-Content $MatrixPath -Raw|ConvertFrom-Json
$flow_status="PASS"
$warnings=@()
$requires_blueprint="UNKNOWN"
$action="UNKNOWN"
$row=@($matrix.matrix|Where-Object{$_.type -eq $card.type}|Select-Object -First 1)
if($null -eq $row){throw "No decision matrix row for type $($card.type)"}
$requires_blueprint=$row.requires_blueprint
$action=$row.action
if([string]$card.status -eq "PROPOSED"){$warnings+="PROPOSED card cannot execute; proposal only"}
if([string]$card.type -eq "WORKER"){$warnings+="WORKER card must not execute real worker; contract/proposal only"}
if([string]$card.type -eq "MODULO" -and [string]$card.module_id -ne "MODULE_PENDING"){$warnings+="MODULO proposal should normally use module_id=MODULE_PENDING until blueprint is approved"}
if([string]$card.type -ne "MODULO" -and [string]$card.module_id -eq "MODULE_PENDING"){$warnings+="MODULE_PENDING on non-MODULO card requires review"}
if([string]$card.human_gate -ne "SI"){throw "human_gate must be SI for canonical flow"}
if($card.evidence -eq $null -or @($card.evidence).Count -eq 0){throw "evidence is required for card-to-module flow"}
$result=[ordered]@{card_id=$card.card_id;module_id=$card.module_id;type=$card.type;status=$card.status;flow_status=$flow_status;action=$action;requires_blueprint=$requires_blueprint;warnings=$warnings;human_gate=$card.human_gate;decision="READY_FOR_HUMAN_REVIEW_NOT_EXECUTION"}
W ("OK card_to_module_flow card_id="+$card.card_id+" action="+$action+" decision=READY_FOR_HUMAN_REVIEW_NOT_EXECUTION warnings="+$warnings.Count) Green
$result|ConvertTo-Json -Depth 20