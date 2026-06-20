$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_CLINE_KANBAN_BACKLOG_REFRESH_001'
$priority='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001\priority-ranking-output.json'
$report='C:\ENGREMIAT_CORE\reports\cline-kanban-backlog-refresh-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$ranking=Get-Content -Raw $priority|ConvertFrom-Json
$items=@($ranking.ranking|Sort-Object -Property priority_score -Descending|Select-Object -First 50)
$seen=@{};$cards=@();$rank=0
foreach($i in $items){
 $key=("$($i.card_id)|$($i.title)").ToLower()
 if($seen.ContainsKey($key)){continue}
 $seen[$key]=$true;$rank++
 $lane=if($i.column -in @('READY','GATED','VALIDATION','BLOCKED','DONE')){$i.column}else{'BACKLOG'}
 $cards+=[ordered]@{rank=$rank;card_id=$i.card_id;title=$i.title;priority_score=$i.priority_score;lane=$lane;type=$i.type;source_path=$i.source_path;reasons=@($i.reasons);recommended_action='REVIEW_IN_CLINE_KANBAN';status='READY_FOR_MANUAL_IMPORT'}
}
$out=[ordered]@{package_id=$package;status='PASS';cards_count=$cards.Count;deduplicated=$true;manual_export_only=$true;clien_write=$false;browser=$false;api_called=$false;git=$false;cards=$cards}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\backlog-refresh-output.json"
$out|ConvertTo-Json -Depth 100
