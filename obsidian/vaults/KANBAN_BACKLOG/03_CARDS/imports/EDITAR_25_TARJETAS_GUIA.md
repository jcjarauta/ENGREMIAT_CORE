# GUIA RAPIDA · COMPLETAR 25 TARJETAS KANBAN

## Objetivo

Completar las 25 tarjetas funcionales del backlog para que ENGREMIAT pueda convertirlas en notas Markdown, indices, autoanalisis y bundles consumibles por Ollama/OpenWebUI.

## Archivo que debes editar

```text
obsidian\vaults\KANBAN_BACKLOG\03_CARDS\imports\system-needs-25-import-template.tsv
```

## Idea sencilla

Cada fila es una tarjeta. No hace falta escribir una ficha perfecta: basta con sustituir los marcadores pendientes por contenido util y clasificable.

## Campos que debes sustituir

Cambia todos los valores de este tipo:

```text
PENDIENTE_*
TO_CLASSIFY
HUMAN_ONLY|ASSISTED|SEMI_AUTOMATED|AUTOMATION_READY|BLOCKED
core|vaults|skills|bundles|adapters|nodes|kanban|openwebui|ollama|cline|visual_memory|resources
```

por un unico valor real en cada celda.

## Valores recomendados

### system_area

Usa uno:

```text
core
vaults
skills
bundles
adapters
nodes
kanban
openwebui
ollama
cline
visual_memory
resources
```

### priority

Usa uno:

```text
Alta
Media
Baja
```

### risk

Usa uno:

```text
LOW
MEDIUM
HIGH
```

### automation_level

Usa uno:

```text
HUMAN_ONLY
ASSISTED
SEMI_AUTOMATED
AUTOMATION_READY
BLOCKED
```

### required_adapter

Usa uno:

```text
MANUAL
OBSIDIAN
KANBAN
OPENWEBUI
OLLAMA
CLINE
POWERSHELL
OPENCLAW_FUTURE
NONE
```

## Ejemplo de fila válida

```text
SYSTEM_NEED_001Refrescar backlog desde evidenciasDetectar necesidades nuevas a partir de reports, errores y decisiones NEXT.kanbanAltaMEDIUMASSISTEDPOWERSHELLNONETO_CLASSIFYreports y estados recientespropuesta de tarjetas nuevasvalidar sin cambios realesevidence reportrevisar propuesta humana
```

## Regla práctica

Puedes editar en tandas. Mientras queden marcadores pendientes, el dispatcher devolverá WAIT_HUMAN_EDIT. Cuando no queden marcadores, materializará las 25 tarjetas Markdown.

## Después de editar

Ejecuta de nuevo el bloque `EDIT_OR_MATERIALIZE`.

Resultado esperado si ya está completo:

```text
status=PASS materialized=True
```

Resultado esperado si aún quedan pendientes:

```text
status=WAIT_HUMAN_EDIT
```

## Seguridad

Este flujo no usa Git, no usa red, no ejecuta workers y no aplica cambios reales. Solo transforma el TSV en notas Markdown locales dentro de la bóveda KANBAN_BACKLOG.
