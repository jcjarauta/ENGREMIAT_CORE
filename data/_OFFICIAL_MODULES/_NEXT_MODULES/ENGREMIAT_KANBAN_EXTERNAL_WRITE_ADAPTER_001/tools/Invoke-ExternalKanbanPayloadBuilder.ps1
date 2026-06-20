$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_EXTERNAL_WRITE_ADAPTER_001'
$priority='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001\priority-ranking-output.json'
$report='C:\ENGREMIAT_CORE\reports\kanban-external-write-adapter-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$rank=Get-Content -Raw $priority|ConvertFrom-Json
$items=@($rank.ranking|Select-Object -First 25)
$payload=@();$i=0
foreach($r in $items){$i++;$payload+=[ordered]@{rank=$i;card_id=$r.card_id;priority_score=$r.priority_score;title=$r.title;type=$r.type;column=$r.column;source_path=$r.source_path;reasons=@($r.reasons);target_status='PREVIEW_ONLY_NO_EXTERNAL_WRITE'}}
$out=[ordered]@{package_id=$package;status='PASS';mode='READ_ONLY_PAYLOAD_BUILD';cards_count=$payload.Count;external_api_write=$false;payload=$payload}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\external-kanban-payload.json"
$out|ConvertTo-Json -Depth 100
