$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_INTERNAL_PRIORITY_ENGINE_001'
$source='C:\ENGREMIAT_CORE\reports\kanban-write-gated-001\kanban-written-board.json'
$report='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$board=Get-Content -Raw $source|ConvertFrom-Json
$cards=@($board.cards)
$signals=@()
foreach($c in $cards){
 $col=[string]$c.column;$typ=[string]$c.type
 $signals+=[ordered]@{card_id=$c.card_id;title=$c.title;type=$typ;column=$col;source_path=$c.source_path;impact_signal=if($col -eq 'READY'){80}elseif($col -eq 'GATED'){75}elseif($col -eq 'BLOCKED'){70}elseif($col -eq 'VALIDATION'){65}else{50};risk_signal=if($col -eq 'BLOCKED'){90}elseif($col -eq 'GATED'){80}else{40};readiness_signal=if($col -eq 'READY'){90}elseif($col -eq 'VALIDATION'){75}else{50};dependency_signal=if($typ -eq 'NEXT_OBJECTIVE'){85}elseif($typ -eq 'VALIDATION'){70}else{55};benefit_signal=if($typ -eq 'IMPROVEMENT'){80}elseif($typ -eq 'NEXT_OBJECTIVE'){85}else{60}}
}
[ordered]@{package_id=$package;status='PASS';readonly=$true;signals_count=$signals.Count;signals=$signals}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\priority-signals-report.json"
