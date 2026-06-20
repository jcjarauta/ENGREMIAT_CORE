$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([Parameter(Mandatory=$true)][string]$AuthorizationPhrase)
function EnsureDir($p){if(Test-Path -LiteralPath $p){if(-not(Test-Path -LiteralPath $p -PathType Container)){throw "PATH_EXISTS_BUT_IS_NOT_DIRECTORY_$p"}}else{New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function SetFM($txt,$key,$value){$pattern="(?m)^"+[regex]::Escape($key)+":\s*.*$";if($txt -match $pattern){return [regex]::Replace($txt,$pattern,($key+": "+$value))};if($txt -match "(?s)^---\s*\r?\n"){return [regex]::Replace($txt,"(?s)^---\s*\r?\n","---`n"+$key+": "+$value+"`n",1)};return "---`n"+$key+": "+$value+"`n---`n"+$txt}
function W($m,$c="Cyan"){Write-Host $m -ForegroundColor $c}
$required="AUTORIZO_APLICAR_TRANSICION_DE_CICLO_KANBAN_LOCAL_CON_BACKUP"
if($AuthorizationPhrase -ne $required){throw "AUTHORIZATION_PHRASE_MISMATCH"}
$root=(Get-Location).Path
$base=Join-Path $root "data/local-kanban-execution-cycle-001"
$cycleDir=Join-Path $base "cycles"
$backupDir=Join-Path $base "backups"
$appliedDir=Join-Path $base "applied"
$cardsDir=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
foreach($d in @($backupDir,$appliedDir)){EnsureDir $d}
$activeCyclePath=Join-Path $cycleDir "active-cycle.json"
if(-not(Test-Path -LiteralPath $activeCyclePath -PathType Leaf)){throw "MISSING_ACTIVE_CYCLE_$activeCyclePath"}
$active=Get-Content -LiteralPath $activeCyclePath -Raw -Encoding UTF8|ConvertFrom-Json
$proposalPath=[string]$active.transition_proposal
if(-not(Test-Path -LiteralPath $proposalPath -PathType Leaf)){throw "MISSING_TRANSITION_PROPOSAL_$proposalPath"}
$p=Get-Content -LiteralPath $proposalPath -Raw -Encoding UTF8|ConvertFrom-Json
$cardId=[string]$p.card_id
$cardPath=Join-Path $cardsDir ($cardId+".md")
if(-not(Test-Path -LiteralPath $cardPath -PathType Leaf)){throw "CARD_NOT_FOUND_$cardPath"}
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$backupPath=Join-Path $backupDir ((Split-Path $cardPath -Leaf)+"."+$stamp+".bak.md")
Copy-Item -LiteralPath $cardPath -Destination $backupPath -Force
$txt=Get-Content -LiteralPath $cardPath -Raw -Encoding UTF8
$reason=([string]$p.reason) -replace "`"","'"
$transitionId="CYCLE-TRANSITION-"+$cardId+"-"+$stamp
$txt=SetFM $txt "status" ([string]$p.to_column)
$txt=SetFM $txt "recommended_column" ([string]$p.to_column)
$txt=SetFM $txt "last_cycle_id" ([string]$p.cycle_id)
$txt=SetFM $txt "last_transition_id" $transitionId
$txt=SetFM $txt "last_transition_at" ((Get-Date).ToString("s"))
$txt=SetFM $txt "last_transition_reason" ("`""+$reason+"`"")
Set-Content -Path $cardPath -Encoding UTF8 -Value $txt
$applied=[ordered]@{cycle_id=[string]$p.cycle_id;card_id=$cardId;from=[string]$p.from_column;to=[string]$p.to_column;card_path=$cardPath;backup=$backupPath;transition_id=$transitionId;applied_at=(Get-Date).ToString("s");proposal=$proposalPath}
$appliedPath=Join-Path $appliedDir ("applied-cycle-transition-"+$stamp+".json")
$applied|ConvertTo-Json -Depth 20|Set-Content -Path $appliedPath -Encoding UTF8
$active.state="CYCLE_TRANSITION_APPLIED"
$active.applied_transition=$appliedPath
$active.next="E08_REBUILD_DASHBOARD_AFTER_CYCLE_TRANSITION"
$active|ConvertTo-Json -Depth 20|Set-Content -Path $activeCyclePath -Encoding UTF8
W "OK cycle_transition_applied=True card_id=$cardId from=$($p.from_column) to=$($p.to_column) backup=$backupPath applied=$appliedPath next=E08_REBUILD_DASHBOARD_AFTER_CYCLE_TRANSITION" Green
