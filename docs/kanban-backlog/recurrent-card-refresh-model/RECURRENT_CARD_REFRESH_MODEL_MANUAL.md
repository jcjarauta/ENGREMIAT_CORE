# ENGREMIAT_RECURRENT_CARD_REFRESH_MODEL_001

## Objetivo
Crear el primer modelo recurrente local para convertir entradas detectadas en tarjetas consumibles, notas Obsidian candidatas y prompts inline revisables.

## Estado
DRY_RUN. No ejecuta acciones externas.

## Flujo
detected-input -> consumable-card markdown -> obsidian-note-candidate -> inline batch -> human review

## Archivos
- Tool: tools/kanban-local/Invoke-RecurrentCardRefreshModel.ps1
- Sample input: docs/kanban-backlog/recurrent-card-refresh-model/inputs/detected-inputs.sample.json
- Cards: docs/kanban-backlog/recurrent-card-refresh-model/cards
- Obsidian candidates: docs/kanban-backlog/recurrent-card-refresh-model/obsidian-candidates
- Inline batches: docs/kanban-backlog/recurrent-card-refresh-model/inline-batches
- Manifest: docs/kanban-backlog/recurrent-card-refresh-model/recurrent-card-refresh-manifest.json

## Comando de prueba
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-RecurrentCardRefreshModel.ps1 -Root C:\ENGREMIAT_CORE -OpenPrompt

## Reglas
- LOCAL_ONLY
- DRY_RUN
- NO_EXEC
- NO_NATIVE_KANBAN_WRITE
- NO_OBSIDIAN_REAL_WRITE
- NO_OPENWEBUI_REAL_CALL
- HUMAN_REVIEW_FIRST

## Siguiente paso
Construir adapter OpenWebUI/OpenClaw dry-run hacia detected-input.
