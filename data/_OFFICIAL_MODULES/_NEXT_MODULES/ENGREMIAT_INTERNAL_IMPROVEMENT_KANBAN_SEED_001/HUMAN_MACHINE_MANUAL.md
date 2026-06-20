# HUMAN_MACHINE_MANUAL — ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001

## Proposito
Convertir reportes reales del sistema en seed Kanban local read-only.

## Flujo
1. Escanear reports y _NEXT_MODULES.
2. Extraer señales.
3. Generar tarjetas.
4. Exportar TSV Markdown HTML.
5. Validar trazabilidad.
6. Proponer mejoras internas.

## Comandos
Scanner: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001\tools\Invoke-KanbanSourceScanner.ps1"
Generator: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001\tools\Invoke-KanbanSeedGenerator.ps1"
Validator: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001\tools\Invoke-KanbanSeedValidator.ps1"

## Salidas
reports/kanban-board.tsv
reports/kanban-board.md
reports/dashboard/index.html

## Seguridad
Read-only. No escribe Kanban real. No Git. No red.
