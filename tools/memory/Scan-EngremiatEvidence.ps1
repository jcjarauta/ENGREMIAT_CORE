param([string]$SourceIndex="ENGREMIAT_MEMORY/operative/sources/visual-memory-source-index.json",[string]$OutPath="ENGREMIAT_MEMORY/operative/sources/evidence-scan.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function ED($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function Sha($p){ try{ if(!(Test-Path -LiteralPath $p -PathType Leaf)){ return $null }; $h=Get-FileHash -LiteralPath $p -Algorithm SHA256 -ErrorAction Stop; return ([string]$h.Hash).ToLowerInvariant() } catch { return $null } }
function Rel($p){ try{ return $p.Replace((Get-Location).Path+"\","").Replace("\","/") } catch { return $p.Replace("\","/") } }
if(!(Test-Path -LiteralPath $SourceIndex -PathType Leaf)){ throw "source index missing: $SourceIndex" }
$idx=Get-Content -LiteralPath $SourceIndex -Raw -Encoding UTF8 | ConvertFrom-Json
$items=@()
foreach($s in @($idx.sources)){ if(-not $s.exists){ continue }; if(Test-Path -LiteralPath $s.path -PathType Leaf){ $f=Get-Item -LiteralPath $s.path; $items += [ordered]@{ source_id=$s.source_id; kind=$s.kind; path=(Rel $f.FullName); name=$f.Name; extension=$f.Extension; bytes=$f.Length; last_write=$f.LastWriteTime.ToString("s"); sha256=(Sha $f.FullName) } } elseif(Test-Path -LiteralPath $s.path){ $patterns=@("*.json","*.jsonl","*.html"); foreach($pat in $patterns){ foreach($f in @(Get-ChildItem -LiteralPath $s.path -Recurse -File -Filter $pat -ErrorAction SilentlyContinue)){ $items += [ordered]@{ source_id=$s.source_id; kind=$s.kind; path=(Rel $f.FullName); name=$f.Name; extension=$f.Extension; bytes=$f.Length; last_write=$f.LastWriteTime.ToString("s"); sha256=(Sha $f.FullName) } } } } }
$report=[ordered]@{ objective_id="ENGREMIAT_DEV_VISUAL_MEMORY_OPERATIVE_002"; stage_id="E01"; status="OK"; scanned_at=(Get-Date).ToString("s"); items_count=$items.Count; items=$items; read_only=$true; external_network=$false }
ED (Split-Path -Parent $OutPath); $report | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $OutPath -Encoding UTF8
Write-Host ("OK evidence_scan=True items="+$items.Count+" output="+$OutPath)
