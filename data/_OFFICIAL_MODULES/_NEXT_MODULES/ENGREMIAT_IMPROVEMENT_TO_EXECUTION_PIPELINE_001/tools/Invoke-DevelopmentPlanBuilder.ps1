$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\improvement-to-execution-pipeline-001'
$p=Get-Content -Raw "$report\technical-proposal.json"|ConvertFrom-Json
$tsv=@('packagestageblockstep_idtaskoutputfiledependencyformatpriorityrequiredowner_statusstatusnotes')
$tsv+=@('ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001','E01','B01.1','P01.1.1','Crear identidad y contrato','Modulo definido','module.json','none','JSON','HIGH','SI','Alta','DONE','Read-only')-join "`t"
$tsv+=@('ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001','E02','B02.1','P02.1.1','Analizar mejora prioritaria','Analisis creado','reports/improvement-analysis.json','P01.1.1','JSON','HIGH','SI','Alta','DONE','Desde ranking real')-join "`t"
$tsv+=@('ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001','E03','B03.1','P03.1.1','Crear propuesta tecnica','Propuesta creada','reports/technical-proposal.json','P02.1.1','JSON','HIGH','SI','Alta','DONE','Sin ejecutar')-join "`t"
$tsv+=@('ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001','E04','B04.1','P04.1.1','Crear paquete dry-run','Paquete creado','reports/execution-package-dry-run.json','P03.1.1','JSON','HIGH','SI','Alta','PENDING','Gate requerido')-join "`t"
$tsv+=@('ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001','E05','B05.1','P05.1.1','Validar pipeline','Reporte validado','reports/improvement-pipeline-validation-report.json','P04.1.1','JSON','HIGH','SI','Alta','PENDING','No source write')-join "`t"
$tsv|Set-Content -Encoding UTF8 "$report\development-plan.tsv"
[ordered]@{package_id='ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001';status='PASS';plan_rows=($tsv.Count-1);source='technical-proposal.json'}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\development-plan-report.json"
