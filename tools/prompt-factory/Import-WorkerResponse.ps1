param([string]$InboxRoot="prompts/inbox",[string]$ReportPath="reports/prompt-factory/e05-outbox-inbox-handoff/worker-response-import-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
EnsureDir $InboxRoot;$files=@();$items=@()
if(Test-Path -LiteralPath $InboxRoot){$files=Get-ChildItem -LiteralPath $InboxRoot -File -ErrorAction SilentlyContinue|Where-Object{$_.Extension -in @(".json",".md",".txt")}|Sort-Object LastWriteTime -Descending}
foreach($f in @($files)){if($f.Name -eq "PROMPT_INBOX_CONTRACT.md"){continue};$raw=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8;$decision="UNKNOWN";$parsed=$null;if($f.Extension -eq ".json"){try{$parsed=$raw|ConvertFrom-Json;if($parsed.decision){$decision=[string]$parsed.decision}}catch{$decision="INVALID_JSON"}}else{if($raw -match "NO_GO"){$decision="NO_GO"}elseif($raw -match "GO"){$decision="GO"}else{$decision="TEXT"}};$items+=[ordered]@{path=$f.FullName.Replace((Get-Location).Path+"\","").Replace("\","/");decision=$decision;size=$f.Length;last_write=$f.LastWriteTime.ToString("s")}}
$rep=[ordered]@{schema="worker-response-import-report.v1";objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E05";status="OK";validation_passed=$true;responses_count=$items.Count;responses=$items;apply_executed=$false;git_write=$false;external_network=$false;imported_at=(Get-Date).ToString("s");next="HUMAN_REVIEW_OR_PROMPT_NEXT"}
WriteJson $ReportPath $rep
Write-Host ("OK import_worker_response=True responses="+$items.Count+" report="+$ReportPath)
