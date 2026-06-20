# E02 · ¿Puede Obsidian evitar el paso manual a Cline/Kanban?

## Objetivo real

Evaluar si Obsidian puede evitar que el humano tenga que pasar manualmente tarjetas a Cline/Kanban.

## Respuesta provisional

Obsidian sí puede evitar trabajo manual de decisión, priorización y estructuración. Pero todavía no puede evitar por completo el paso manual a Cline/Kanban porque no tenemos una vía segura para crear una tarjeta visible en esa UI.

## Evidencia acumulada

- Obsidian guarda propiedades automáticamente: PASS.
- Engremiat lee YAML/Markdown de Obsidian: PASS.
- Engremiat genera export/prompt/paquete manual: PASS.
- Cline respondió `KANBAN_UI_NOT_AVAILABLE`: UI Kanban no manipulable por prompt.
- `.cline\kanban` existe pero está vacío.
- El mejor candidato file-based no es JSON seguro.
- Escritura directa a storage Cline/Kanban: NO_GO por ahora.

## Matriz de rutas

| Ruta | Objetivo | Decisión |
|---|---|---|
| A · File-based Cline/Kanban | Escribir tarjetas en storage real | NO_GO_NOW |
| B · API/import Cline/Kanban | Usar importador oficial o comando | SEARCH_REQUIRED |
| C · Obsidian Kanban como tablero | Usar Obsidian como tablero operativo | BEST_NEXT_TEST |
| D · Kanban local Engremiat | Generar tablero propio local | STRONG_FALLBACK |
| E · UI automation | Automatizar UI con AHK/navegador | DEFER |

## Decisión estratégica

No seguir intentando escribir en Cline/Kanban a ciegas. La siguiente prueba útil es comprobar si podemos usar Obsidian como tablero Kanban operativo mínimo, o generar un Kanban local propio desde los objetos Obsidian.

## Siguiente test recomendado

E03_OBSIDIAN_AS_KANBAN_BOARD_MICRO_TEST

Objetivo: crear una vista Kanban dentro de la bóveda Obsidian usando Markdown/YAML y columnas como carpetas o notas índice. Si eso funciona, Obsidian puede sustituir temporalmente el paso manual a Cline/Kanban para organización visual, y Cline queda como worker de tareas concretas.
