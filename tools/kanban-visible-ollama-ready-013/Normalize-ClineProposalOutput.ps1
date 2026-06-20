$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base="data/kanban-visible-ollama-ready-013"
$rawPath=Join-Path $base "cline-proposal-raw-output.json"
$normPath=Join-Path $base "cline-proposal-normalized.json"
$x=$null
if(Test-Path $rawPath){try{$x=Get-Content $rawPath -Raw|ConvertFrom-Json}catch{$x=$null}}
if(-not $x){$n=[ordered]@{objective="ENGREMIAT_KANBAN_VISIBLE_AND_OLLAMA_READY_013";stage="E05";status="PENDING_OUTPUT";summary="No raw output captured yet";files_affected=@();risks=@();diff_proposed="";evidence=@();recommended_next_step="Await Cline output";no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}}else{$n=[ordered]@{objective="ENGREMIAT_KANBAN_VISIBLE_AND_OLLAMA_READY_013";stage="E05";status=if($x.status){$x.status}else{"PARSED"};summary=if($x.summary){$x.summary}else{"Output received"};files_affected=if($x.files_affected){@($x.files_affected)}else{@()};risks=if($x.risks){@($x.risks)}else{@()};diff_proposed=if($x.diff_proposed){[string]$x.diff_proposed}else{""};evidence=if($x.evidence){@($x.evidence)}else{@()};recommended_next_step=if($x.recommended_next_step){$x.recommended_next_step}else{"Review proposal"};no_apply=$true;git_write=$false;remote_execution=$false;auto_apply=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString("o")}}
J $n $normPath
Write-Host ("OK normalized="+$normPath+" status="+$n.status) -ForegroundColor Green
