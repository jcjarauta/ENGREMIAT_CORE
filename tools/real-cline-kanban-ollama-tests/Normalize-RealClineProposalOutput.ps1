$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([string]$InputPath='data/real-cline-kanban-ollama-tests/cline-proposal-raw-output.json',[string]$OutputPath='data/real-cline-kanban-ollama-tests/real-cline-proposal-normalized.json')
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
if(-not(Test-Path $InputPath)){throw "Missing input: $InputPath"}
$raw=Get-Content $InputPath -Raw | ConvertFrom-Json
$norm=[ordered]@{objective='ENGREMIAT_REAL_CLINE_KANBAN_OLLAMA_TESTS_011';stage='E05';normalized=$true;status=$raw.status;captured=$raw.captured;summary=if($raw.raw_text){$raw.raw_text}else{'PENDING_OUTPUT'};risks=@();files=@();actions=@();apply_executed=$false;git_write=$false;remote_execution=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')}
J $norm $OutputPath
Write-Host ('NORMALIZED '+$OutputPath) -ForegroundColor Green
