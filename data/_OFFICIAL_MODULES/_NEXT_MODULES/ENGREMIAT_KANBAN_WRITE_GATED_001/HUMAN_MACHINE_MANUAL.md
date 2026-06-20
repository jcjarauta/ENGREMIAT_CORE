# HUMAN_MACHINE_MANUAL — ENGREMIAT_KANBAN_WRITE_GATED_001

## Proposito
Preparar y ejecutar escritura gobernada solo a artefacto local desde el seed Kanban.

## Resultado
Se generó kanban-written-board.json como copia local autorizada. No se escribió en Sheets, Cline ni Kanban externo.

## Comandos
Dry-run: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_WRITE_GATED_001\tools\Invoke-KanbanWriteDryRun.ps1"
Local write gated: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_WRITE_GATED_001\tools\Invoke-KanbanLocalWriteGated.ps1" -Authorization "AUTORIZO_KANBAN_LOCAL_WRITE_GATED"
Validator: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_WRITE_GATED_001\tools\Invoke-KanbanWriteGatedValidator.ps1"

## Archivos clave
reports/kanban-write-selection-preview.json
reports/kanban-write-review.tsv
reports/kanban-write-plan.json
reports/kanban-written-board.json
reports/kanban-write-evidence.json
reports/external-kanban-export-preview.tsv

## Seguridad
Escritura externa bloqueada. Escritura real limitada a artefacto local. Git false.
