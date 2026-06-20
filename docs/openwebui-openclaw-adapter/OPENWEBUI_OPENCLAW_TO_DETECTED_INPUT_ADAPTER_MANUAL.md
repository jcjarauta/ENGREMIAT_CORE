# OPENWEBUI_OPENCLAW_TO_DETECTED_INPUT_ADAPTER_001

## Objetivo
Convertir una conversación/resumen de OpenWebUI, pasando conceptualmente por OpenClaw, en detected-input consumible por ENGREMIAT.

## Estado
DRY_RUN. No conecta con OpenWebUI real. No conecta con OpenClaw real. No escribe en Obsidian real.

## Flujo
openwebui-thread-summary -> openclaw-normalized-intent -> detected-input.json -> recurrent-card-refresh-model -> tarjeta consumible -> nota candidata -> prompt inline.

## Tool
tools/kanban-local/Convert-OpenWebUIOpenClawToDetectedInput.ps1

## Input sample
docs/openwebui-openclaw-adapter/inputs/openwebui-thread.sample.json

## Output
docs/openwebui-openclaw-adapter/outputs/detected-input.from-openwebui-openclaw.*.json

## Comando básico
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Convert-OpenWebUIOpenClawToDetectedInput.ps1 -Root C:\ENGREMIAT_CORE

## Comando con ciclo completo recurrente
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Convert-OpenWebUIOpenClawToDetectedInput.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Seguridad
- LOCAL_ONLY
- DRY_RUN
- NO_EXEC
- NO_OPENWEBUI_REAL
- NO_OPENCLAW_REAL
- NO_OBSIDIAN_REAL_WRITE
- NO_NATIVE_KANBAN_WRITE
- HUMAN_REVIEW_FIRST
