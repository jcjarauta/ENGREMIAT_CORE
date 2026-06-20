$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Cyan"){Write-Host $m -ForegroundColor $c}
function D($p){if([string]::IsNullOrWhiteSpace($p)){return};if(-not(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
function L($p,[string[]]$a){D(Split-Path $p -Parent);Set-Content -LiteralPath $p -Value $a -Encoding UTF8}
function J($p,$o){D(Split-Path $p -Parent);$o|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $p -Encoding UTF8}
$root=(Get-Location).Path
$kv=Join-Path $root "obsidian\vaults\KANBAN_BACKLOG"
$tsv=Join-Path $kv "03_CARDS\imports\system-needs-25-import-template.tsv"
$cardsDir=Join-Path $kv "03_CARDS\cards"
$rep=Join-Path $root "reports\kanban-backlog-25-cards-materializer"
$ts=(Get-Date).ToString("s")
try{
W "ENGREMIAT_PACKAGE_BEGIN package=ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001 stage=E02_MATERIALIZE_FROM_TSV"
if(-not(Test-Path -LiteralPath $tsv)){throw "TSV_NOT_FOUND $tsv"}
$raw=Get-Content -LiteralPath $tsv -Encoding UTF8
if($raw.Count -lt 26){throw "TSV_EXPECTED_25_ROWS_PLUS_HEADER_FOUND_$($raw.Count)"}
$header=$raw[0].Split("`t")
$required=@("card_id","title","description","system_area","priority","risk","automation_level","required_adapter","required_node","related_skill","input","output","validation","evidence","next")
$missing=@();foreach($r in $required){if($header -notcontains $r){$missing+=$r}};if($missing.Count -gt 0){throw "MISSING_COLUMNS $($missing -join ',')"}
$rows=@();for($i=1;$i -lt $raw.Count;$i++){if([string]::IsNullOrWhiteSpace($raw[$i])){continue};$parts=$raw[$i].Split("`t");$o=[ordered]@{};for($c=0;$c -lt $header.Count;$c++){$o[$header[$c]]=if($c -lt $parts.Count){$parts[$c]}else{""}};$rows+=[pscustomobject]$o}
$bad=$rows|Where-Object{$_.card_id -notmatch "^SYSTEM_NEED_\d{3}$"};if($bad.Count -gt 0){throw "INVALID_CARD_IDS $($bad.card_id -join ',')"}
$pending=$rows|Where-Object{$_.title -like "PENDIENTE_*" -or $_.description -like "PENDIENTE_*"}
$status=if($pending.Count -gt 0){"WARN_PENDING_DETAIL"}else{"PASS"}
foreach($r in $rows){$p=Join-Path $cardsDir "$($r.card_id).md";$tags="[kanban/system_need, autoanalysis/candidate, status/"+$(if($pending.card_id -contains $r.card_id){"pending"}else{"active"})+"]";L $p @("---","type: card","card_id: $($r.card_id)","card_group: SYSTEM_NEEDS","card_type: FUNCTION_OR_NEED_CANDIDATE","status: "+$(if($pending.card_id -contains $r.card_id){"PENDING_DETAIL"}else{"ACTIVE"}),"title: $($r.title)","system_area: $($r.system_area)","priority: $($r.priority)","risk: $($r.risk)","automation_level: $($r.automation_level)","required_adapter: $($r.required_adapter)","required_node: $($r.required_node)","related_skill: $($r.related_skill)","requires_human: true","source: system-needs-25-import-template.tsv","tags: $tags","---","# $($r.card_id) · $($r.title)","","## Descripcion","",$r.description,"","## Clasificacion","","- system_area: $($r.system_area)","- priority: $($r.priority)","- risk: $($r.risk)","- automation_level: $($r.automation_level)","- required_adapter: $($r.required_adapter)","- required_node: $($r.required_node)","- related_skill: $($r.related_skill)","","## Entrada","",$r.input,"","## Salida esperada","",$r.output,"","## Validacion","",$r.validation,"","## Evidencia","",$r.evidence,"","## Next","",$r.next)}
$idx=@("# SYSTEM_NEEDS_INDEX","","| card_id | title | status | system_area | priority | risk | automation_level | adapter | node |","|---|---|---|---|---|---|---|---|---|");foreach($r in $rows){$st=if($pending.card_id -contains $r.card_id){"PENDING_DETAIL"}else{"ACTIVE"};$idx+="| $($r.card_id) | $($r.title) | $st | $($r.system_area) | $($r.priority) | $($r.risk) | $($r.automation_level) | $($r.required_adapter) | $($r.required_node) |"};L (Join-Path $kv "03_CARDS\SYSTEM_NEEDS_INDEX.md") $idx
$auto=$rows|Where-Object{$_.automation_level -match "ASSISTED|SEMI_AUTOMATED|AUTOMATION_READY"};$aidx=@("# AUTOMATION_CANDIDATES_INDEX","","| card_id | title | automation_level | required_adapter | required_node | risk |","|---|---|---|---|---|---|");foreach($r in $auto){$aidx+="| $($r.card_id) | $($r.title) | $($r.automation_level) | $($r.required_adapter) | $($r.required_node) | $($r.risk) |"};L (Join-Path $kv "03_CARDS\AUTOMATION_CANDIDATES_INDEX.md") $aidx
L (Join-Path $kv "04_AUTOANALYSIS\AUTOANALYSIS_REPORT.md") @("# AUTOANALYSIS_REPORT","","status: $status","cards_total: $($rows.Count)","pending_detail: $($pending.Count)","automation_candidates: $($auto.Count)","created_at: $ts","","## Decision","","Si pending_detail > 0, completar tarjetas antes de automatizar. Si automation_candidates > 0, revisar gates antes de cualquier accion real.")
L (Join-Path $kv "06_BUNDLES\KANBAN_BACKLOG_IMPORT_BUNDLE.md") @("# KANBAN_BACKLOG_IMPORT_BUNDLE","","## Estado","- cards_total: $($rows.Count)","- pending_detail: $($pending.Count)","- automation_candidates: $($auto.Count)","- status: $status","","## Regla","Kanban ordena. Autoanalysis propone. El humano decide. Nada real sin gate.","","## Next","Revisar SYSTEM_NEEDS_INDEX y AUTOANALYSIS_REPORT.")
J (Join-Path $rep "materializer-run-report.json") ([ordered]@{package_id="ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001";status=$status;cards_total=$rows.Count;pending_detail=$pending.Count;automation_candidates=$auto.Count;git=$false;network=$false;external_execution=$false;next=if($pending.Count -gt 0){"COMPLETE_PENDING_CARD_DETAILS"}else{"REVIEW_AUTOANALYSIS_AND_PRIORITIES"};created_at=$ts})
if($pending.Count -gt 0){W "WARN package_id=ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001 status=$status cards_total=$($rows.Count) pending_detail=$($pending.Count) next=COMPLETE_PENDING_CARD_DETAILS git=False network=False" Yellow}else{W "OK package_id=ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001 status=PASS cards_total=$($rows.Count) automation_candidates=$($auto.Count) next=REVIEW_AUTOANALYSIS_AND_PRIORITIES git=False network=False" Green}
W "ENGREMIAT_PACKAGE_END package=ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001 status=$status" Green
}catch{W "ERR package_id=ENGREMIAT_KANBAN_BACKLOG_25_CARDS_MATERIALIZER_001 status=FAIL message=$($_.Exception.Message)" Red;throw}
