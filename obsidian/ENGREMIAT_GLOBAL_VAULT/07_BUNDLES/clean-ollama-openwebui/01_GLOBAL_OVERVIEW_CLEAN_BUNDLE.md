---
type: clean_import_bundle
bundle_id: GLOBAL_OVERVIEW_CLEAN_BUNDLE
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/clean, ollama, openwebui, engremiat/global]
---
# GLOBAL_OVERVIEW_CLEAN_BUNDLE

## Proposito

Dar a Ollama/OpenWebUI una vista limpia de la arquitectura ENGREMIAT.

## Regla central

Obsidian organiza. Kanban ordena. OpenWebUI/Ollama consultan. Cline propone con gates. PowerShell materializa solo acciones locales controladas. El humano decide.

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

## NEXT global

```markdown
# NEXT_GLOBAL

Siguiente paso recomendado: ENGREMIAT_OBSIDIAN_ARCHITECTURE_READONLY_AUDIT_001.

Objetivo: auditar HOME, ESTADO y MASTER_INDEX de la boveda global y las bovedas dedicadas antes de modificar bundles, registry o automatizaciones.

Estado: analysis_only=True, human_decision=DEFER, git=False, network=False, worker_real_execution=False.

```
