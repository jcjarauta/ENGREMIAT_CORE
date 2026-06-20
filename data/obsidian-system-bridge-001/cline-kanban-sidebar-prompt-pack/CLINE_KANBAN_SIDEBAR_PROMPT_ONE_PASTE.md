# DESTINO: CLINE KANBAN SIDEBAR CHAT

Quiero que crees tarjetas Kanban a partir de estas tarjetas aprobadas por revisión humana en Obsidian/Engremiat.

## Reglas estrictas

- No ejecutes comandos.
- No modifiques archivos del proyecto.
- No actives auto-approve.
- No inicies trabajo todavía.
- Solo crea o prepara tarjetas visibles en el tablero Kanban.
- Mantén el ID original de cada tarjeta en el título o descripción.
- Conserva el origen `source_need`.
- Si no puedes crear tarjetas directamente desde este sidebar, responde exactamente: `KANBAN_SIDEBAR_CARD_CREATION_NOT_AVAILABLE`.

## Columnas deseadas

- BACKLOG
- NEXT
- DOING
- DONE

## Tarjetas aprobadas


### CARD-001 · Crear backlog visible

- Columna sugerida: 
NEXT
- Prioridad: 
HIGH
- Origen: 
NEED-001
- Estado Obsidian: 
NEXT

Descripción: tarjeta aprobada en Obsidian/Engremiat para validar si el paso manual hacia Cline/Kanban puede reducirse a un único prompt.

Criterio de terminado:

- La tarjeta aparece visible en el tablero Kanban.
- El ID 
CARD-001
 queda visible.
- El origen 
NEED-001
 queda visible.
- No se ha ejecutado trabajo asociado.

### CARD-003 · Crear evidencia de ejecución

- Columna sugerida: 
DOING
- Prioridad: 
MEDIUM
- Origen: 
NEED-003
- Estado Obsidian: 
DOING

Descripción: tarjeta aprobada en Obsidian/Engremiat para validar si el paso manual hacia Cline/Kanban puede reducirse a un único prompt.

Criterio de terminado:

- La tarjeta aparece visible en el tablero Kanban.
- El ID 
CARD-003
 queda visible.
- El origen 
NEED-003
 queda visible.
- No se ha ejecutado trabajo asociado.

## Respuesta esperada

Cuando termines, responde con una lista de tarjetas creadas o con `KANBAN_SIDEBAR_CARD_CREATION_NOT_AVAILABLE`.
