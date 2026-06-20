$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$objective="ENGREMIAT_CONTROLLED_ACTION_REPLICATION_016";$base="data/controlled-action-replication-016";$reports="reports/controlled-action-replication-016"
$Mode=if($args.Count -gt 0){[string]$args[0]}else{"preview"}
$requestPath=Join-Path $base "controlled-action-replication-request-preview.json"
$reportPath=Join-Path $reports "e03-dry-run-report.json"
$req=$null
if(Test-Path $requestPath){try{$req=Get-Content $requestPath -Raw|ConvertFrom-Json}catch{$req=$null}}
$result=[ordered]@{objective=$objective;stage="E03";mode=$Mode;request_file=$requestPath;request_present=[bool]$req;preview_only=$true;apply_executed=$false;git_write=$false;remote_execution=$false;auto_apply=$false;dry_run_ok=$true;notes="No-op seguro.";timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}
J $result $reportPath
$modeLabel=if($Mode -eq "preview"){"PREVIEW"}else{"EXECUTE"}
Write-Host ("OK objective="+$objective+" stage=E03 mode="+$modeLabel+" dry_run_ok="+$result.dry_run_ok) -ForegroundColor Green
