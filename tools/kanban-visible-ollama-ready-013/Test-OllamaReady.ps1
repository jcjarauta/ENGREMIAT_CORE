$ErrorActionPreference="Stop";[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$objective="ENGREMIAT_KANBAN_VISIBLE_AND_OLLAMA_READY_013";$base="data/kanban-visible-ollama-ready-013";$reports="reports/kanban-visible-ollama-ready-013"
$policyPath=Join-Path $base "ollama-safe-policy.json"
$policy=if(Test-Path $policyPath){Get-Content $policyPath -Raw|ConvertFrom-Json}else{$null}
$errors=@()
$ollamaCmd=Get-Command ollama -ErrorAction SilentlyContinue
$ollamaAvailable=[bool]$ollamaCmd
$ollamaVersion="";$modelsRaw="";$models=@()
if($ollamaAvailable){try{$ollamaVersion=((& ollama --version)|Out-String).Trim()}catch{$errors+="version_failed"};try{$modelsRaw=((& ollama list)|Out-String).Trim();if($modelsRaw){$models=@($modelsRaw -split "\r?\n" | Where-Object { $_ -and $_.Trim() })}}catch{$errors+="list_failed"}}
if(-not $policy){$errors+="missing_policy"};if($policy){if($policy.inference_executed -ne $false){$errors+="policy_inference_not_false"};if(-not($policy.allowed_actions -contains "detect_service")){$errors+="policy_missing_detect"}}
$ready=($ollamaAvailable -and $errors.Count -eq 0);$rd=70;$dec="NO_GO_REPAIR";$nx="REPAIR_OR_COMPLETE_E03";if($ready){$rd=100;$dec="GO_OLLAMA_READY";$nx="E04_CONTEXT_INTEGRATION"}
J ([ordered]@{objective=$objective;stage="E03";ollama_required=$true;ollama_available=$ollamaAvailable;ollama_version=$ollamaVersion;models=$models;models_raw=$modelsRaw;policy_file=$policyPath;validation_ok=$ready;errors=$errors;readiness=$rd;decision=$dec;next=$nx;inference_executed=$false;auto_apply=$false;git_write=$false;remote_execution=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}) (Join-Path $reports "e03-ollama-ready-report.json")
Write-Host ("OK objective="+$objective+" stage=E03 readiness="+$rd+" decision="+$dec+" next="+$nx) -ForegroundColor Green
