# NEXT OBJECTIVE · ENGREMIAT_LOCAL_KANBAN_WORKER_LOOP_001

## Objetivo

Construir un loop operativo repetible entre Kanban local Engremiat, worker y evidencia.

## Fases propuestas

### E01 · Selección de tarjeta

Permitir seleccionar una card GO/reviewed desde el dataset local.

### E02 · Prompt worker automático

Generar prompt worker desde la tarjeta seleccionada.

### E03 · Inbox de respuesta

Preparar inbox por card y validar marcadores de respuesta.

### E04 · Análisis de respuesta

Convertir respuesta worker en evidencia estructurada.

### E05 · Actualización de estado

Actualizar card/estado local: NEXT → DOING → REVIEW/DONE, sin tocar Cline Kanban.

### E06 · Refresh dashboard

Refrescar HTML y mostrar evidencia asociada.

### E07 · Gate para automatización futura

Diseñar el camino hacia MCP/CLI sin activarlo todavía.

## Política de seguridad

- No escribir en Cline/Kanban.
- No ejecutar worker sin autorización.
- No git automático en esta etapa.
- Local-first.
- Evidencia antes de automatización.
