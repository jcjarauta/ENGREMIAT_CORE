param([string]$ScanPath="ENGREMIAT_MEMORY/operative/sources/evidence-scan.json",[string]$OutPath="ENGREMIAT_MEMORY/operative/events/events.jsonl")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function ED($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function Safe($s){ $x=[string]$s; $x=$x -replace "[^\w\.-]+","_"; if([string]::IsNullOrWhiteSpace($x)){ return "UNKNOWN" }; return $x }
if(!(Test-Path -LiteralPath $ScanPath -PathType Leaf)){ throw "scan missing: $ScanPath" }
$scan=Get-Content -LiteralPath $ScanPath -Raw -Encoding UTF8 | ConvertFrom-Json
$events=@()
foreach($it in @($scan.items)){ $obj="UNKNOWN_OBJECTIVE"; $st="UNKNOWN_STAGE"; $status="UNKNOWN"; $next=""; $risk="LOW"; if($it.extension -eq ".json" -and (Test-Path -LiteralPath $it.path -PathType Leaf)){ try{ $j=Get-Content -LiteralPath $it.path -Raw -Encoding UTF8 | ConvertFrom-Json; if($j.objective_id){$obj=[string]$j.objective_id}; if($j.stage_id){$st=[string]$j.stage_id}; if($j.status){$status=[string]$j.status}; if($j.decision -and $status -eq "UNKNOWN"){$status=[string]$j.decision}; if($j.next){$next=[string]$j.next}; if($j.risk){$risk=[string]$j.risk} } catch{} }; if($obj -eq "UNKNOWN_OBJECTIVE" -and $it.path -like "*dev-visual-memory*"){$obj="ENGREMIAT_DEV_VISUAL_MEMORY_001"}; $id="EVT_"+(Safe ($obj+"_"+$st+"_"+$it.sha256)); $events += [ordered]@{ event_id=$id; objective_id=$obj; stage_id=$st; block_id=""; step_id=""; status=$status; source_path=$it.path; evidence_sha256=$it.sha256; artifact=$it.path; risk=$risk; next=$next; created_at=(Get-Date).ToString("s"); metadata=[ordered]@{ source_id=$it.source_id; kind=$it.kind; bytes=$it.bytes; last_write=$it.last_write } } }
ED (Split-Path -Parent $OutPath); $events | ForEach-Object { $_ | ConvertTo-Json -Depth 50 -Compress } | Set-Content -LiteralPath $OutPath -Encoding UTF8
Write-Host ("OK development_events=True count="+$events.Count+" output="+$OutPath)
