# E12 · Cline Kanban sidebar result: NO_GO

## Resultado humano

```text
KANBAN_SIDEBAR_CARD_CREATION_NOT_AVAILABLE
```

## Log observado

```text
Cline Kanban running at http://127.0.0.1:3484/engremiat-core
AI SDK Warning: System messages in the prompt or messages fields can be a security risk because they may enable prompt injection attacks.
```

## Interpretación

Cline Kanban está activo como servidor local, pero el sidebar no ha demostrado capacidad para crear tarjetas visibles desde un prompt estructurado generado por Obsidian/Engremiat.

La advertencia AI SDK indica riesgo de diseño de prompt con mensajes de sistema dentro del flujo; no es la causa principal del NO_GO, pero confirma que debemos evitar prompts con instrucciones tipo sistema cuando probemos Cline/Kanban.

## Decisión

CLINE_KANBAN_SIDEBAR_CREATE_CARDS = NO_GO

## Impacto sobre el objetivo

Obsidian puede reducir trabajo manual de decisión, priorización y estructura, pero no evita el paso manual hacia Cline/Kanban mediante sidebar.

## Rutas que siguen vivas

1. MARKDOWN_KANBAN_EXTENSION: usar Markdown como tablero visible editable.
2. CLINE_MCP_SERVER: exponer objetos Obsidian/Engremiat como contexto/herramientas para Cline.
3. CLINE_CLI_HEADLESS: usar Cline como worker sobre una tarea seleccionada, no como tablero.
4. ENGREMIAT_LOCAL_KANBAN: tablero propio local generado desde objetos Obsidian.

## Siguiente recomendado

E13_VALIDATE_MARKDOWN_KANBAN_VISUAL_RESULT_OR_BUILD_LOCAL_KANBAN_FALLBACK
