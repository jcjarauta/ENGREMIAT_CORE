param([string]$InputPath="data/worker-response-057/worker-response-sample.md")
$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path);Set-Location $Root
$outDir="reports/proposal-quality-058";$receiptDir="data/proposal-quality-058/receipts";New-Item -ItemType Directory -Force -Path $outDir,$receiptDir|Out-Null
if(!(Test-Path $InputPath)){throw "NO_GO proposal input not found: $InputPath"}
$raw=Get-Content $InputPath -Raw
$required=@("proposal_id","summary","suggested_change","risk","required_files","expected_value","safety_flags","rollback_needed","postcheck_needed","recommended_human_decision")
$missing=@();foreach($r in $required){if($raw -notmatch [regex]::Escape($r)){$missing+=$r}}
$unsafe=@();foreach($u in @("auto_apply=true","remote_execution=true","git_write=true","external_network=true")){if($raw -match [regex]::Escape($u)){$unsafe+=$u}}
$score=[Math]::Max(0,100-($missing.Count*10)-($unsafe.Count*30))
$decision="GO_REVIEW";if($unsafe.Count -gt 0){$decision="REJECT_UNSAFE"}elseif($missing.Count -gt 0){$decision="REPAIR_REQUIRED"}elseif($score -lt 80){$decision="DEFER_FOR_HUMAN_REVIEW"}
$report=[ordered]@{objective="ENGREMIAT_CONTROLLED_REAL_WORKER_DAILY_VALUE_LOOP_056_065";stage="E58";input_path=$InputPath;score=$score;missing_fields=$missing;unsafe_flags=$unsafe;decision=$decision;proposal_executed=$false;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;created_at=(Get-Date).ToString("s")}
$reportPath=Join-Path $outDir "proposal-quality-check-report.json";$report|ConvertTo-Json -Depth 12|Set-Content $reportPath -Encoding UTF8
$receiptPath=Join-Path $receiptDir "proposal-quality-check-receipt.json";$report|ConvertTo-Json -Depth 12|Set-Content $receiptPath -Encoding UTF8
Write-Host ("OK stage=E58 proposal_check=ready decision="+$decision+" score="+$score+" apply_executed=false auto_apply=false remote_execution=false git_write=false") -ForegroundColor Green
