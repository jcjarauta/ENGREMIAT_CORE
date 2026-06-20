# INITIAL_CLASSIFICATION_RULES

## automation_level

- HUMAN_ONLY: requiere criterio humano completo.
- ASSISTED: la IA puede ayudar a redactar, ordenar o revisar.
- SEMI_AUTOMATED: parte del flujo puede automatizarse con gate.
- AUTOMATION_READY: patrón repetible, bajo riesgo y validable.
- BLOCKED: falta dato, herramienta, gate o evidencia.

## risk

- LOW: documentación, clasificación, índice, bundle, lectura.
- MEDIUM: escritura local controlada, generación de scripts, cambios sobre estructura.
- HIGH: ejecución externa, workers reales, red, Git, OpenClaw, apply o automatización.

## refresh_status

- NEW
- ACTIVE
- STALE
- MERGE_CANDIDATE
- ARCHIVED
