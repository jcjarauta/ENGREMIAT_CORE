# E06A · Cline/Kanban EMFILE NO_GO

## Incidente observado

```text
Could not read JSON file at C:\Users\pc\.cline\kanban\workspaces\index.json
EMFILE: too many open files, open C:\Users\pc\.cline\kanban\workspaces\index.json
```

## Interpretación

Cline/Kanban ha fallado leyendo su índice interno de workspace. Esto confirma que no conviene usar Cline/Kanban como tablero directo ni como destino de sincronización en esta fase.

## Decisión

```text
CLINE_KANBAN_DIRECT_WORKER_OR_BOARD = NO_GO_NOW
```

## Ruta que se mantiene

```text
Obsidian Markdown/YAML
→ Engremiat Local Kanban
→ bridge localhost
→ dispatcher
→ Ollama worker local gated
→ response/evidence
```

## Motivo

La ruta local de Engremiat ya validó mock y Ollama. Cline/Kanban introduce errores de watcher/storage/archivos abiertos y aumenta fricción humana.

## Siguiente recomendado

Continuar con E06/E07 sobre el botón Ollama real gated y cerrar la arquitectura local worker loop sin depender de Cline/Kanban.
