$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$objective="ENGREMIAT_CONTROLLED_APPLY_OR_REPAIR_014";$base="data/controlled-apply-or-repair-014";$reports="reports/controlled-apply-or-repair-014"
$schemaPath=Join-Path $base "controlled-apply-gate-schema.json"
$samplePath=Join-Path $base "sample-human-gate-decision.json"
$errors=@()
if(-not(Test-Path $schemaPath)){$errors += "missing_schema"}
if(-not(Test-Path $samplePath)){$errors += "missing_sample"}
$schema=if(Test-Path $schemaPath){Get-Content $schemaPath -Raw|ConvertFrom-Json}else{$null}
$sample=if(Test-Path $samplePath){Get-Content $samplePath -Raw|ConvertFrom-Json}else{$null}
if($schema -and $schema.default_decision -ne "DEFER"){$errors += "schema_default_not_defer"}
if($schema -and ($schema.allowed_decisions -notcontains "APPROVE" -or $schema.allowed_decisions -notcontains "DEFER")){$errors += "schema_allowed_decisions_invalid"}
if($sample -and $sample.decision -ne "DEFER"){$errors += "sample_decision_not_defer"}
if($sample -and $sample.execution_allowed -ne $false){$errors += "sample_execution_allowed_not_false"}
$valid=($errors.Count -eq 0)
$rd=if($valid){100}else{70}
$dec=if($valid){"GO_E02_GATE_READY"}else{"NO_GO_REPAIR"}
$nx=if($valid){"E03_DRY_RUN_CONTROLLED"}else{"REPAIR_OR_COMPLETE_E02"}
J ([ordered]@{objective=$objective;stage="E02";readiness=$rd;decision=$dec;next=$nx;validation_ok=$valid;errors=$errors;schema_file=$schemaPath;sample_file=$samplePath;no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}) (Join-Path $reports "e02-gate-validation-report.json")
Write-Host ("OK objective="+$objective+" stage=E02 readiness="+$rd+" decision="+$dec+" next="+$nx) -ForegroundColor Green
