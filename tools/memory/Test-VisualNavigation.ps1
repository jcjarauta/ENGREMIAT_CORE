param([string]$MemoryRoot="ENGREMIAT_MEMORY",[string]$ReportPath="reports/dev-visual-memory-operative/e02-live-maps-navigation/visual-navigation-smoke-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function ED($p){ if($p -and !(Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function WJ($p,$o){ ED (Split-Path -Parent $p); $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8 }
$required=@("logseq/pages/Home.md","maps/OPERATIVE_OVERVIEW.md","maps/ENGREMIAT_CORE_MVP_MAP.md","maps/ERRORS_MAP.md","maps/DECISIONS_MAP.md","maps/GATES_MAP.md","maps/WORKERS_MAP.md")
$missing=@(); foreach($r in $required){ $p=Join-Path $MemoryRoot $r; if(!(Test-Path -LiteralPath $p -PathType Leaf)){ $missing+=$p } }
$orphans=@(); $md=@(); if(Test-Path -LiteralPath $MemoryRoot){$md=Get-ChildItem -LiteralPath $MemoryRoot -Recurse -File -Filter "*.md" -ErrorAction SilentlyContinue}; foreach($f in @($md)){ $txt=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8; if($txt -notmatch "\[\["){$orphans+=$f.FullName.Replace((Get-Location).Path+"\","").Replace("\","/")} }
$ok=($missing.Count -eq 0 -and $md.Count -gt 0); $rep=[ordered]@{objective_id="ENGREMIAT_DEV_VISUAL_MEMORY_OPERATIVE_002";stage_id="E02";step_id="P02.3.2";status=$(if($ok){"OK"}else{"NO_GO"});validation_passed=$ok;required=$required;missing=$missing;markdown_notes=$md.Count;orphan_without_wikilink_count=$orphans.Count;orphan_without_wikilink_sample=@($orphans|Select-Object -First 20);checked_at=(Get-Date).ToString("s")}; WJ $ReportPath $rep; if(-not $ok){Write-Host ("ERR visual_navigation=False missing="+($missing -join ",")); exit 1}; Write-Host ("OK visual_navigation=True notes="+$md.Count+" report="+$ReportPath)
