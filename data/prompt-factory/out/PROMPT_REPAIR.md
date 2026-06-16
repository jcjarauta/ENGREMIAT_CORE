# PROMPT_REPAIR - ENGREMIAT CONTROLLED REPAIR

## ROL
Actúa como worker local controlado para reparar un fallo de ENGREMIAT. No avances de fase. Repara solo la causa detectada y devuelve evidencia.

## ISSUE DETECTADO
- decision: NO_CURRENT_ISSUE
- status: NO_CURRENT_ISSUE
- report_path: NO_CURRENT_ISSUE
- message: No hay ERR/NO_GO activo. Generar prompt repair preventivo para reparar el ultimo fallo si aparece.
- next: USE_PROMPT_REPAIR_WHEN_ERR_OR_NO_GO

## OBJETIVO
- objective_id: ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001
- stage_id: E04
- repair_mode: controlled_local_repair

## LÍMITES DE SEGURIDAD
- external_network=False
- git_write=False
- commit=False
- push=False
- fetch=False
- merge=False
- browser=False
- clipboard=False
- apply_sensible=False sin gate humano explícito
- Si no puedes validar la reparación, responde NO_GO.

## ARCHIVOS PERMITIDOS
- data/prompt-factory/**
- tools/prompt-factory/**
- reports/prompt-factory/**
- docs/prompt-factory/**

## ARCHIVOS PROHIBIDOS
- .git/**
- node_modules/**
- backend/node_modules/**
- secretos, tokens o credenciales
- cambios fuera de la frontera técnica actual

## TAREA DE REPARACIÓN
1. Leer la evidencia indicada.
2. Identificar causa raíz mínima.
3. Corregir solo lo necesario.
4. Ejecutar validación local.
5. Generar o actualizar reporte JSON.
6. Devolver GO solo con evidencia.

## FORMATO DE SALIDA WORKEROUTPUT
- worker_id: cline_or_ollama
- task_id: PROMPT_REPAIR
- decision: GO|NO_GO|REQUEST_CHANGES|BLOCKED
- summary: resumen breve
- files_touched: lista de archivos
- tests_executed: lista de pruebas
- risks: lista de riesgos
- evidence: rutas de reportes o artefactos
- validation_report: ruta del reporte
- external_network: false
- git_write: false
- next: siguiente paso lógico

## CRITERIO GO / NO_GO
GO solo si el fallo queda reparado y validado. NO_GO si falta evidencia, si el cambio excede el alcance o si requiere gate humano.
