param([string]$EventsPath="ENGREMIAT_MEMORY/operative/events/events.jsonl",[string]$OutRoot="ENGREMIAT_MEMORY/operative/synced")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function ED($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function Safe($s){ $x=[string]$s; $x=$x -replace "[^\w\.-]+","_"; if([string]::IsNullOrWhiteSpace($x)){ return "UNKNOWN" }; return $x }
if(!(Test-Path -LiteralPath $EventsPath -PathType Leaf)){ throw "events missing: $EventsPath" }
ED $OutRoot; $events=@(); foreach($l in Get-Content -LiteralPath $EventsPath -Encoding UTF8){ if([string]::IsNullOrWhiteSpace($l)){continue}; try{$events+=($l|ConvertFrom-Json)}catch{} }
$groups=$events | Group-Object objective_id
foreach($g in @($groups)){ $obj=$g.Name; $out=Join-Path $OutRoot ((Safe $obj)+".md"); $lines=@(); $lines += "# "+$obj; $lines += ""; $lines += "## Live evidence summary"; $lines += "- events_count: "+$g.Count; $lines += "- updated_at: "+(Get-Date).ToString("s"); $lines += ""; $lines += "## Events"; foreach($e in @($g.Group | Select-Object -First 80)){ $lines += "- "+$e.status+" · "+$e.stage_id+" · "+$e.source_path+" · next="+$e.next }; Set-Content -LiteralPath $out -Value $lines -Encoding UTF8 }
$idx=@("# LIVE_MEMORY_INDEX","","- generated_at: "+(Get-Date).ToString("s"),"- events_count: "+$events.Count,"","## Objectives"); foreach($g in @($groups)){ $idx += "- [["+$g.Name+"]] events="+$g.Count }; Set-Content -LiteralPath (Join-Path $OutRoot "LIVE_MEMORY_INDEX.md") -Value $idx -Encoding UTF8
Write-Host ("OK visual_memory_sync=True objectives="+$groups.Count+" events="+$events.Count+" output="+$OutRoot)
