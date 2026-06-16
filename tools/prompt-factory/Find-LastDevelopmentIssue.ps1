param([string]$OutPath="data/prompt-factory/out/last-issue.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$candidates=@();if(Test-Path -LiteralPath "reports"){$files=Get-ChildItem -LiteralPath "reports" -Recurse -File -Filter "*.json" -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending;foreach($f in @($files)){try{$obj=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$obj.status;$valid=$obj.validation_passed;$msg=[string]$obj.message;$isIssue=($status -eq "ERR" -or $status -eq "NO_GO" -or ($null -ne $valid -and $valid -eq $false));if($isIssue){$candidates+=[ordered]@{path=$f.FullName.Replace((Get-Location).Path+"\","").Replace("\","/");status=$status;validation_passed=$valid;message=$msg;next=[string]$obj.next;last_write=$f.LastWriteTime.ToString("s")}}}catch{}}}
$issue=$null;if($candidates.Count -gt 0){$issue=$candidates[0]}else{$issue=[ordered]@{path="NO_CURRENT_ISSUE";status="NO_CURRENT_ISSUE";validation_passed=$true;message="No hay ERR/NO_GO activo. Generar prompt repair preventivo para reparar el ultimo fallo si aparece.";next="USE_PROMPT_REPAIR_WHEN_ERR_OR_NO_GO";last_write=(Get-Date).ToString("s")}}
$payload=[ordered]@{schema="last-development-issue.v1";objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E04";issue=$issue;issue_count=$candidates.Count;created_at=(Get-Date).ToString("s");decision=$(if($candidates.Count -gt 0){"ISSUE_FOUND"}else{"NO_CURRENT_ISSUE"})}
WriteJson $OutPath $payload
Write-Host ("OK find_last_development_issue=True decision="+$payload.decision+" output="+$OutPath)
