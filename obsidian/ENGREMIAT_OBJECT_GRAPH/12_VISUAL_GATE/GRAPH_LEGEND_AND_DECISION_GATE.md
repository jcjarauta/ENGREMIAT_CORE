# Leyenda visual y gate Kanban

## Lectura del grafo

- Núcleo superior: necesidades del sistema importadas desde E02.
- Núcleo inferior: tarjetas candidatas `card-01` a `card-10`.
- Enlaces centrales: índices, matriz de prioridad, revisión humana y paquete Cline/Kanban.
- Nodos amarillos `.tsv/.json`: artefactos de soporte; pueden ignorarse en lectura humana.

## Estado observado

- Bóveda Obsidian creada: PASS.
- 25 necesidades visibles: PASS.
- 10 cards candidatas visibles: PASS.
- Cards enlazadas al grafo: PASS.
- Paquete Kanban preparado sin escritura real: PASS.

## Decisión humana

Marca una decisión después de revisar el TOP 10:

- `KANBAN_GO`: pasar a Cline/Kanban y crear/importar tarjetas manualmente.
- `ADJUST`: ajustar prioridades o nombres antes de pasar a Kanban.
- `STOP`: cerrar aquí y usar Obsidian solo como mapa.

## Archivos que abrir

- [[../START_HERE|START HERE]]
- [[../00_MAPAS/OBJECT_GRAPH_HOME|Entrada principal]]
- [[../07_PRIORIDADES/PRIORITY_MATRIX|Matriz de prioridad]]
- [[../09_CLINE_KANBAN_PACKET/CLINE_CARDS_INDEX|Cards candidatas]]
- [[../09_CLINE_KANBAN_PACKET/CLINE_KANBAN_IMPORT_PROMPT|Prompt Cline/Kanban]]
- [[../10_REVISION_HUMANA/HUMAN_REVIEW_OBSIDIAN_TO_KANBAN|Revisión humana]]
