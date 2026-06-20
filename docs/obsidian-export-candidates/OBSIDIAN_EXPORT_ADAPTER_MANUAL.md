# OBSIDIAN_CANDIDATE_EXPORT_ADAPTER_001

## Objetivo
Convertir notas Obsidian candidatas generadas por ENGREMIAT en un paquete exportable local, sin escribir todavía en un vault real.

## Estado
DRY_RUN.

## Entrada
docs/kanban-backlog/recurrent-card-refresh-model/obsidian-candidates/*.obsidian-candidate.md

## Salida
docs/obsidian-export-candidates/notes/*.md
docs/obsidian-export-candidates/OBSIDIAN_EXPORT_INDEX.md
docs/obsidian-export-candidates/obsidian-export-manifest.json

## Comando
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Export-ObsidianCandidatePack.ps1 -Root C:\ENGREMIAT_CORE -OpenIndex

## Seguridad
- No escribe en vault real.
- No abre Obsidian.
- No ejecuta acciones externas.
- No modifica Kanban nativo.
- Human review first.

## Siguiente paso
Crear gate de exportación a vault real cuando el humano autorice.
