# E04 · Bases e índices operativos

## Decisión
Se crean vistas tipo Base preview, especificaciones JSON y fallbacks Markdown para operar Obsidian como panel humano.

## Vistas creadas
- ACTIVE_PROJECTS
- PENDING_GATES
- ACTIVE_CARDS
- BLOCKED_CARDS
- RECENT_EVIDENCE
- WORKER_PROPOSALS

## Reparación aplicada
Se evita sintaxis experimental que pueda romper PowerShell o depender de una versión concreta de Obsidian Bases. La especificación queda estable en JSON + Markdown + .base preview.

## Regla
Las vistas leen propiedades/frontmatter. No ejecutan workers, no escriben Kanban, no hacen Git y no sustituyen reports JSON.

## Siguiente
E05 debe crear Canvas global y Canvas de proyecto para visualizar relaciones.
