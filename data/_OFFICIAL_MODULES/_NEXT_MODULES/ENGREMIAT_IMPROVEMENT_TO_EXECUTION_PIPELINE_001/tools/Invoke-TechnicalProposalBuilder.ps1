$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001'
$report='C:\ENGREMIAT_CORE\reports\improvement-to-execution-pipeline-001'
$a=Get-Content -Raw "$report\improvement-analysis.json"|ConvertFrom-Json
$proposal=[ordered]@{package_id=$package;proposal_id='TECH-PROP-001';status='PASS';title="Convertir mejora $($a.card_id) en bloque tecnico gobernado";objective='Generar un paquete dry-run que pueda convertirse en desarrollo real solo tras gate humano.';candidate_files=@('contracts/*.json','schemas/*.json','rules/*.json','tools/*.ps1','reports/*.json','HUMAN_MACHINE_MANUAL.md','README.md','NEXT_OBJECTIVE.md');steps=@('analizar mejora','definir propuesta tecnica','crear plan TSV','preparar paquete dry-run','crear gate humano','validar sin ejecutar');gates=@('GO','DEFER','BLOCK');expected_evidence=@('analysis','proposal','plan','dry-run package','validation report');real_execution=$false}
$proposal|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\technical-proposal.json"
$proposal|ConvertTo-Json -Depth 100
