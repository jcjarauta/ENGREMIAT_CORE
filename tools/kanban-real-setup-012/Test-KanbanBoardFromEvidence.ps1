$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/kanban-real-setup-012'
$reports='reports/kanban-real-setup-012'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$sources=Get-Content "$base/evidence-sources.json" -Raw | ConvertFrom-Json
$inv=Get-Content "$base/evidence-inventory.json" -Raw | ConvertFrom-Json
$cards=Get-Content "$base/cards.json" -Raw | ConvertFrom-Json
$board=Get-Content "$base/kanban-board.json" -Raw | ConvertFrom-Json
$errors=@()
if($sources.Count -lt 5){$errors+="sources_missing"}
if($inv.counts.files -lt 1){$errors+="inventory_empty"}
if($cards.Count -lt 4){$errors+="cards_missing"}
if($board.columns.Count -lt 7){$errors+="board_columns_missing"}
if($board.cards.Count -lt 4){$errors+="board_cards_missing"}
if(($board.cards | Select-Object -ExpandProperty id | Sort-Object | Get-Unique).Count -ne $board.cards.Count){$errors+="duplicate_card_ids"}
if($board.generated_from -notmatch 'evidence-inventory\.json$'){$errors+="board_generated_from_invalid"}
$ok=($errors.Count -eq 0)
$readiness=70
$decision="NO_GO_KANBAN_BOARD_REPAIR_REQUIRED"
$next="REPAIR_KANBAN_BOARD"
if($ok){$readiness=100;$decision="GO_KANBAN_BOARD_READY";$next="E04_VISTA_HTML_HUMANA_LOCAL"}
$report=[ordered]@{objective="ENGREMIAT_KANBAN_REAL_SETUP_012";stage="E03";sources_count=$sources.Count;inventory_files=$inv.counts.files;cards_count=$cards.Count;board_cards_count=$board.cards.Count;columns_count=$board.columns.Count;errors=$errors;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next;board_path="$base/kanban-board.json";cards_path="$base/cards.json"}
J $report "$reports/e03-kanban-board-generation-report.json"
Write-Host ('RESULT objective=ENGREMIAT_KANBAN_REAL_SETUP_012 stage=E03 readiness=' + $readiness + ' decision=' + $decision + ' cards=' + $cards.Count + ' next=' + $next) -ForegroundColor Green
