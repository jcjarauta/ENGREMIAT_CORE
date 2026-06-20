# ENGREMIAT_FIRST_OPERATIONAL_SELECTION_CONTEXT

## Proposito

Este pack sirve para que Ollama/OpenWebUI analice las 3 primeras tarjetas operativas seleccionadas desde KANBAN_BACKLOG.

## Reglas de seguridad

- No proponer apply real.
- No proponer Git.
- No proponer red externa.
- No proponer worker real.
- No proponer automatizacion sin gate humano.
- La IA consulta, ordena y recomienda. El humano decide.

## Arquitectura resumida

ENGREMIAT funciona como sistema local-first: Obsidian organiza, Kanban ordena, OpenWebUI/Ollama consultan, Cline propone con gates, PowerShell materializa solo acciones locales controladas y el humano decide.

## Seleccion operativa

```markdown
# FIRST_OPERATIONAL_SELECTION

## Decision

Seleccion inicial de 3 tarjetas operativas para revisar antes de cualquier automatizacion real.

## Tarjetas seleccionadas

| order | card_id | title | area | priority | risk | automation | adapter | decision |
|---|---|---|---|---|---|---|---|---|
| 1 | SYSTEM_NEED_001 | Arquitectura Obsidian visible | vaults | Alta | LOW | ASSISTED | OBSIDIAN | DEFER |
| 2 | SYSTEM_NEED_004 | Bundles limpios para Ollama | ollama | Alta | LOW | ASSISTED | OPENWEBUI | DEFER |
| 3 | SYSTEM_NEED_005 | Registry de skills OpenWebUI | skills | Alta | LOW | ASSISTED | OPENWEBUI | DEFER |

## Regla

Esta seleccion no autoriza ejecucion real, Git, red, workers, apply ni escritura Kanban real. Solo prepara revision humana.

## Siguiente paso recomendado

Crear bundle de trabajo para Ollama/OpenWebUI con estas 3 tarjetas y pedir analisis de orden, dependencias, riesgos y primera accion segura.

```

## Bundle de seleccion

```markdown
# FIRST_OPERATIONAL_SELECTION_BUNDLE

## Proposito

Contexto compacto para Ollama/OpenWebUI: analizar las 3 primeras tarjetas operativas y recomendar orden sin ejecutar acciones reales.

## Tarjetas

| card_id | title | area | priority | risk | automation | adapter |
|---|---|---|---|---|---|---|
| SYSTEM_NEED_001 | Arquitectura Obsidian visible | vaults | Alta | LOW | ASSISTED | OBSIDIAN |
| SYSTEM_NEED_004 | Bundles limpios para Ollama | ollama | Alta | LOW | ASSISTED | OPENWEBUI |
| SYSTEM_NEED_005 | Registry de skills OpenWebUI | skills | Alta | LOW | ASSISTED | OPENWEBUI |

## Instruccion para IA

Analiza estas tarjetas como memoria de arquitectura ENGREMIAT. Recomienda cual abordar primero, por que, que evidencia revisar, que riesgo existe y que salida local seria util. No propongas apply, Git, red ni worker real.

```

## Architecture index

```markdown
---
type: architecture_index
status: ACTIVE
tags: [index/architecture, ollama/entrypoint]
---
# ARCHITECTURE_INDEX

## Leer primero para Ollama/OpenWebUI

1. [[../07_BUNDLES/GLOBAL_OVERVIEW_BUNDLE|GLOBAL_OVERVIEW_BUNDLE]]
2. [[../08_MANUALES/OBSIDIAN_ARCHITECTURE_RULES|OBSIDIAN_ARCHITECTURE_RULES]]
3. [[../03_MAPAS/MAPA_ARQUITECTURA_ENGREMIAT|MAPA_ARQUITECTURA_ENGREMIAT]]
4. [[../07_BUNDLES/NEXT_OBJECTIVE_BUNDLE|NEXT_OBJECTIVE_BUNDLE]]

## Bovedas funcionales

- VAULT_KANBAN_BACKLOG
- VAULT_OPENWEBUI_SKILLS
- VAULT_DEV_SYSTEM
- VAULT_WORKERS_AND_ADAPTERS
- VAULT_MODULE_REGISTRY
- VAULT_VISUAL_MEMORY
- VAULT_RESOURCE_LIBRARY

## Principio

Obsidian es el sistema nervioso visible. Kanban es cola viva. Ollama/OpenWebUI consumen bundles. Cline propone. El humano decide.

```

## Rules

```markdown
---
type: manual
status: ACTIVE
tags: [manual/global, obsidian/rules, engremiat/architecture]
---
# OBSIDIAN_ARCHITECTURE_RULES

## Reglas

- La boveda global dirige; no almacena todo el detalle.
- Cada boveda dedicada tiene HOME, ESTADO, NEXT, IMPORT_BUNDLE y MASTER_INDEX.
- Kanban Backlog contiene las 25 tarjetas y el autoanalisis de necesidades.
- OpenWebUI Skills contiene skills oficiales/candidatas y sus pruebas.
- Workers and Adapters define Cline/Ollama/OpenClaw como herramientas gobernadas, no como autoridad.
- Module Registry ordena los modulos oficializados y capacidades.
- Visual Memory recoge eventos, dashboards, grafo, decisiones y evidencias.
- Resource Library guarda recursos reutilizables, plantillas y workflows.
- Todo objeto importante debe tener status, next, risk y evidencia.
- Nada real sin gate humano cuando hay riesgo.

```

## Architecture map

```markdown
---
type: architecture_map
status: ACTIVE
tags: [engremiat/architecture, obsidian/map]
---
# MAPA_ARQUITECTURA_ENGREMIAT

```text
ENGREMIAT_GLOBAL_VAULT
├── KANBAN_BACKLOG        -> necesidades, tarjetas, autoanalisis, prioridades
├── OPENWEBUI_SKILLS      -> skills, candidatas, pruebas, bundles RAG
├── DEV_SYSTEM            -> comandos, gates, readiness, errores, contexto
├── WORKERS_AND_ADAPTERS  -> Cline, Ollama, OpenWebUI, OpenClaw, PowerShell
├── MODULE_REGISTRY       -> modulos oficiales, familias, capacidades
├── VISUAL_MEMORY         -> eventos, dashboards, grafo, decisiones
└── RESOURCE_LIBRARY      -> plantillas, manuales, workflows, recursos reutilizables
```

## Regla de gobierno

CORE gobierna. Obsidian organiza. Kanban ordena. OpenWebUI/Ollama consultan. Cline propone con gates. El humano decide.

```
