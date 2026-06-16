# VISUAL_MEMORY_OPERATOR_GUIDE

## Decisiones
- GO: continuar si dashboard, eventos y mapas están OK.
- NO_GO: reparar antes de avanzar si faltan evidencias, gates o next.
- GATE: pedir autorización humana antes de apply, red, worker real o cambios sensibles.

## Errores
- Si `memory-sync` falla, revisar último reporte en `reports/dev-visual-memory-operative/`.
- Si dashboard no abre, ejecutar `.\eng.ps1 memory-dashboard`.
- Si maps están rotos, ejecutar E02 repair.

## Límites
No activa Graphiti real, no usa red, no ejecuta bases de datos.
