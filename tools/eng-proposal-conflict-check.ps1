param([string]$InputPath="data/proposal-merge-068/proposal-samples.jsonl")
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$outDir="reports/proposal-merge-068";$receiptDir="data/proposal-merge-068/receipts";New-Item -ItemType Directory -Force -Path $outDir,$receiptDir|Out-Null
if(!(Test-Path $InputPath)){throw "NO_GO proposal samples not found: $InputPath"}
$items=@();Get-Content $InputPath|ForEach-Object{if($_.Trim().Length -gt 0){$items+=($_|ConvertFrom-Json)}}
$conflicts=@();$targets=@{}
foreach($p in $items){foreach($f in $p.target_files){if(!$targets.ContainsKey($f)){$targets[$f]=@()};$targets[$f]+=$p.proposal_id};foreach($flag in $p.safety_flags){if($flag -match "auto_apply=true|remote_execution=true|git_write=true|external_network=true"){$conflicts+=[ordered]@{proposal_id=$p.proposal_id;type="UNSAFE_FLAG";detail=$flag}};if($p.risk -eq "HIGH" -and $p.recommended_human_decision -eq "APPROVE"){$conflicts+=[ordered]@{proposal_id=$p.proposal_id;type="HIGH_RISK_APPROVE";detail="High risk proposal recommends approve"}};if($p.rollback_needed -eq $false -and $p.risk -ne "LOW"){$conflicts+=[ordered]@{proposal_id=$p.proposal_id;type="ROLLBACK_MISSING";detail="Rollback missing for non-low risk"}}}
foreach($k in $targets.Keys){if($targets[$k].Count -gt 1){$conflicts+=[ordered]@{target_file=$k;type="TARGET_FILE_OVERLAP";detail=($targets[$k] -join ",")}}}
$decision="GO_MERGE_REVIEW";if($conflicts.Count -gt 0){$decision="HUMAN_ARBITRATION_REQUIRED"}
$report=[ordered]@{objective="ENGREMIAT_MULTI_WORKER_ORCHESTRATION_AND_REAL_VALUE_PIPELINE_066_075";stage="E68";input_path=$InputPath;proposals_count=$items.Count;conflicts=$conflicts;conflicts_count=$conflicts.Count;decision=$decision;merge_executes=$false;proposal_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}
$reportPath=Join-Path $outDir "proposal-conflict-check-report.json";$report|ConvertTo-Json -Depth 16|Set-Content $reportPath -Encoding UTF8
$receiptPath=Join-Path $receiptDir "proposal-conflict-check-receipt.json";$report|ConvertTo-Json -Depth 16|Set-Content $receiptPath -Encoding UTF8
Write-Host ("OK stage=E68 proposal_conflict_check=ready decision="+$decision+" conflicts="+$conflicts.Count+" apply_executed=false auto_apply=false remote_execution=false git_write=false") -ForegroundColor Green
