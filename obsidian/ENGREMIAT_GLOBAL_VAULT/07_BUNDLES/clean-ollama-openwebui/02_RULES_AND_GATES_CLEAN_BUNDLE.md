---
type: clean_import_bundle
bundle_id: RULES_AND_GATES_CLEAN_BUNDLE
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/clean, rules, gates, safety]
---
# RULES_AND_GATES_CLEAN_BUNDLE

## Proposito

Recordar a la IA las reglas de gobierno y seguridad de ENGREMIAT.

## Reglas

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

## YAML y tags

```markdown
# YAML_TAGS_TAXONOMY

## YAML base

```yaml
type:
entity_id:
vault_id:
project_id:
status:
risk:
priority:
requires_human:
automation_level:
adapter_targets:
related_capabilities:
evidence:
next:
last_updated:
tags:
```

## Status

PENDING · ACTIVE · READY · GATED · DEFER · WARN · NO_GO · PASS · CLOSED · ARCHIVED

## Tags

#engremiat/core · #engremiat/architecture · #vault/global · #vault/kanban · #vault/skills · #entity/project · #entity/card · #entity/skill · #entity/bundle · #entity/adapter · #entity/module · #entity/gate · #status/pass · #status/closed · #risk/low · #risk/medium · #risk/high · #adapter/openwebui · #adapter/ollama · #adapter/cline · #gate/required

```

## Restricciones para IA

- No ejecutar.
- No proponer Git real.
- No proponer red externa.
- No proponer worker real.
- No proponer apply sin gate humano.
- Responder como analista de arquitectura y priorizacion.
