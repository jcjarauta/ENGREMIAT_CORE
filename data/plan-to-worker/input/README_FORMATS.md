# PLAN_TO_WORKER INPUT FORMATS

Formatos soportados por deteccion: TSV, CSV, JSON, XLSX.

Importacion funcional en E02: TSV, CSV y JSON.

XLSX queda detectado como formato soportado, pero no se importa automaticamente en esta etapa para evitar dependencias externas o API Google. Exportar desde Sheets como TSV o CSV para el flujo estable.

Columnas minimas esperadas: objective_id, stage_id, stage_name, block_id, block_name, step_id, step_title, artifact, depends_on, format, risk, requires_human, priority, status, notes.
