param([string]$MemoryRoot="ENGREMIAT_MEMORY",[string]$OutputRoot="ENGREMIAT_MEMORY/graph/export")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function SafeId($s){ $x=[string]$s; $x=$x -replace "[^\w\.-]+","_"; if([string]::IsNullOrWhiteSpace($x)){ return "UNKNOWN" }; return $x }
EnsureDir $OutputRoot
$nodes=@(); $edges=@(); $now=(Get-Date).ToString("s")
if(Test-Path -LiteralPath $MemoryRoot){ $files=Get-ChildItem -LiteralPath $MemoryRoot -Recurse -File -Filter "*.md" -ErrorAction SilentlyContinue; foreach($f in @($files)){ $rel=$f.FullName.Substring((Resolve-Path $MemoryRoot).Path.Length).TrimStart("\","/"); $id="NODE_"+(SafeId $rel); $type=$(if($rel -like "maps*"){"Map"}elseif($rel -like "errors*"){"Error"}elseif($rel -like "decisions*"){"Decision"}elseif($rel -like "evidence*"){"Evidence"}elseif($rel -like "demo*"){"Demo"}else{"Page"}); $nodes += [ordered]@{ id=$id; type=$type; label=$f.BaseName; path=(Join-Path $MemoryRoot $rel).Replace("\","/"); created_at=$now; metadata=[ordered]@{ extension=$f.Extension; bytes=$f.Length } }; $edges += [ordered]@{ id=("EDGE_ROOT_CONTAINS_"+$id); type="contains"; source="NODE_ENGREMIAT_MEMORY"; target=$id; created_at=$now; metadata=[ordered]@{ reason="file_in_memory_root" } } } }
$nodes = @([ordered]@{ id="NODE_ENGREMIAT_MEMORY"; type="Objective"; label="ENGREMIAT_MEMORY"; path=$MemoryRoot; created_at=$now; metadata=[ordered]@{ objective_id="ENGREMIAT_DEV_VISUAL_MEMORY_001" } }) + $nodes
$nodes | ForEach-Object { $_ | ConvertTo-Json -Depth 50 -Compress } | Set-Content -LiteralPath (Join-Path $OutputRoot "nodes.jsonl") -Encoding UTF8
$edges | ForEach-Object { $_ | ConvertTo-Json -Depth 50 -Compress } | Set-Content -LiteralPath (Join-Path $OutputRoot "edges.jsonl") -Encoding UTF8
Write-Host ("OK memory_graph_export=True nodes="+$nodes.Count+" edges="+$edges.Count+" output="+$OutputRoot)
