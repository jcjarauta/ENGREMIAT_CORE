# E13 · Opciones restantes tras NO_GO de Cline Kanban sidebar

## Contexto

El objetivo del ejercicio es valorar si Obsidian puede evitar el paso manual hacia Cline/Kanban.

## Evidencia acumulada

- Obsidian guarda propiedades y Markdown: PASS.
- Engremiat puede leer/generar objetos desde Obsidian: PASS.
- Storage interno Cline/Kanban: NO_GO seguro por ahora.
- Cline Kanban sidebar chat: NO_GO para crear tarjetas visibles.
- Markdown Kanban extension instalada: PASS, pendiente validación visual.

## Opciones restantes

| Opción | Estado | Decisión |
|---|---|---|
| Markdown Kanban VS Code/Cursor | Pendiente validación visual | TEST_NOW |
| Obsidian como Kanban principal | Viable | STRONG_OPTION |
| Kanban local Engremiat | Viable y controlable | BEST_FALLBACK |
| Cline CLI como worker | Viable más adelante | DEFER_WITH_GATE |
| MCP Obsidian/Engremiat → Cline | Mejor arquitectura futura | DESIGN_LATER |
| GitHub Issues / Markdown tasks | Fallback robusto | KEEP_AVAILABLE |
| UI automation | Último recurso | DEFER |

## Recomendación

No insistir más en Cline Kanban como tablero importable hasta que exista API/import/storage confirmado.

Seguir con dos pruebas limpias:

1. Validar visualmente el tablero Markdown Kanban ya instalado.
2. Construir un Kanban local Engremiat HTML desde objetos Obsidian como fallback controlado.

## Siguiente recomendado

E14_BUILD_ENGREMIAT_LOCAL_KANBAN_FROM_OBSIDIAN_OBJECTS
