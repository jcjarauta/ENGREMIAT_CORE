$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([string]$ProposalPath='data\worker-proposal-intake-078\worker-proposal-intake-v2-sample.json')
$objective='ENGREMIAT_NEXT_REAL_VALUE_OPERATIONALIZATION_076_085'
$stage='E78'
if(-not (Test-Path $ProposalPath)){throw "Proposal not found: $ProposalPath"}
$p=Get-Content $ProposalPath -Raw|ConvertFrom-Json
$required=@('proposal_id','worker_role','title','summary','target_artifacts','risk','requires_human_decision','expected_evidence','safety_flags')
$missing=@()
foreach($r in $required){if(-not ($p.PSObject.Properties.Name -contains $r)){$missing+=$r}}
$sf=$p.safety_flags
$unsafe=@()
foreach($k in @('worker_executed','apply_executed','auto_apply','remote_execution','git_write','external_network','kanban_real_write')){if($sf.$k -ne $false){$unsafe+=$k}}
$ok=($missing.Count -eq 0 -and $unsafe.Count -eq 0 -and $p.requires_human_decision -eq $true)
$outDir='reports\worker-proposal-intake-078'
New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$report=[ordered]@{objective=$objective;stage=$stage;proposal_path=$ProposalPath;valid=$ok;missing_fields=$missing;unsafe_flags=$unsafe;requires_human_decision=$p.requires_human_decision;worker_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;kanban_real_write=$false;checked_utc=(Get-Date).ToUniversalTime().ToString('o')}
$reportPath=Join-Path $outDir 'worker-proposal-intake-v2-validation-report.json'
$report|ConvertTo-Json -Depth 20|Set-Content $reportPath -Encoding UTF8
if($ok){Write-Host 'OK objective=ENGREMIAT_NEXT_REAL_VALUE_OPERATIONALIZATION_076_085 stage=E78 intake_validation=passed worker_executed=false apply_executed=false git_write=false kanban_real_write=false'}else{Write-Host ('NO_GO objective=ENGREMIAT_NEXT_REAL_VALUE_OPERATIONALIZATION_076_085 stage=E78 intake_validation=failed missing_fields='+$missing.Count+' unsafe_flags='+$unsafe.Count+' worker_executed=false apply_executed=false git_write=false kanban_real_write=false')}
