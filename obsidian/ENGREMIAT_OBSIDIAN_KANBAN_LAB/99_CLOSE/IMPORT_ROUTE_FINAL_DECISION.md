---
object_type: import_route_final_decision
lab_id: ENGREMIAT_OBSIDIAN_KANBAN_LAB_001
status: CLOSED
final_decision: MANUAL_IMPORT_PACKAGE_GO
file_based_import: NO_GO_UNSAFE_FORMAT
manual_import_package: PASS
next_recommended_objective: ENGREMIAT_OBSIDIAN_SYSTEM_BRIDGE_001
tags: [engremiat_lab, import_route, final_decision]
---

# Decisión final ruta de importación Obsidian → Cline/Kanban

## Veredicto

No hay todavía una ruta segura para escribir directamente en Cline/Kanban.

## Motivos

- Cline respondió `KANBAN_UI_NOT_AVAILABLE`.
- `.cline\kanban` existe pero está vacío.
- El mejor candidato file-based no es JSON seguro.
- E14 devolvió `FORMAT_NOT_SAFE_FOR_WRITE_YET`.

## Ruta adoptada

MANUAL_IMPORT_PACKAGE_GO

Obsidian genera tarjetas aprobadas y Engremiat crea un paquete manual/importable. El humano copia o importa la tarjeta en Kanban cuando exista una vía UI/import clara.

## Paquete generado

- [[../11_MANUAL_IMPORT_PACKAGE/CARD-001.manual-kanban-card|Tarjeta Markdown]]
- [[../11_MANUAL_IMPORT_PACKAGE/CARD-001.copy-paste.txt|Texto copiar/pegar]]
- [[../11_MANUAL_IMPORT_PACKAGE/CARD-001.manual-import.json|JSON para futuro adapter]]

## Siguiente objetivo recomendado

ENGREMIAT_OBSIDIAN_SYSTEM_BRIDGE_001

## Regla aprendida

No escribir en storage Cline/Kanban sin formato confirmado, backup y autorización explícita.
