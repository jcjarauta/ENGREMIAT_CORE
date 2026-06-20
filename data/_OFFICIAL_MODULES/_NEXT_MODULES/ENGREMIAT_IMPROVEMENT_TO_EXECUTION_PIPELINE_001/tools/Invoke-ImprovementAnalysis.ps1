$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001'
$priority='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001\top-priority-recommendations.json'
$report='C:\ENGREMIAT_CORE\reports\improvement-to-execution-pipeline-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$top=Get-Content -Raw $priority|ConvertFrom-Json
$item=@($top.recommendations|Select-Object -First 1)[0]
$analysis=[ordered]@{package_id=$package;status='PASS';card_id=$item.card_id;title=$item.title;priority_score=$item.priority_score;source_path=$item.source_path;problem='La tarjeta prioritaria necesita convertirse en trabajo tecnico accionable antes de ejecutar nada.';why_now=@($item.reasons);expected_value='Reducir friccion entre mejora detectada y desarrollo ejecutable.';risk='Ejecutar sin plan o sin gate podria romper gobernanza.';constraints=@('readonly','dry-run','no source write','no git','no api')}
$analysis|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\improvement-analysis.json"
$analysis|ConvertTo-Json -Depth 100
