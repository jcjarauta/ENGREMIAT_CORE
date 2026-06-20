---
type: clean_import_bundle
bundle_id: ENGREMIAT_MINIMAL_KANBAN_OPERATIONAL_CONTEXT
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/minimal, kanban, ollama, openwebui]
---
# ENGREMIAT_MINIMAL_KANBAN_OPERATIONAL_CONTEXT

## Proposito

Este bundle minimo sustituye al pack anterior demasiado ruidoso. Sirve para responder solo a: que tarjeta operativa abordar primero, por que, con que riesgos y cual es la primera accion segura.

## Reglas minimas

- Analisis only.
- No Git.
- No red externa.
- No worker real.
- No apply.
- No automatizacion sin gate humano.
- El humano decide.

## Contexto esencial

Ollama ya recomendo empezar por SYSTEM_NEED_001 porque la arquitectura Obsidian visible es base para bundles y registry. La auditoria read-only de arquitectura Obsidian ya paso con GO_READONLY_AUDIT_PASS. Por tanto, el siguiente foco es SYSTEM_NEED_004: limpiar bundles para Ollama/OpenWebUI.

## Bundle Kanban operativo

```markdown
---
type: clean_import_bundle
bundle_id: KANBAN_FIRST_OPERATIONAL_CLEAN_BUNDLE
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/clean, kanban, first-selection]
---
# KANBAN_FIRST_OPERATIONAL_CLEAN_BUNDLE

## Proposito

Contexto limpio para razonar sobre las primeras tarjetas operativas.

## Priority review

```markdown
# PRIORITY_REVIEW · 25 SYSTEM NEEDS

## Resumen

| metric | value |
|---|---|
| cards_total | 25 |
| automation_candidates | 24 |
| high_risk | 6 |
| quick_wins_low_risk | 10 |
| blocked |  |

## Por area

| area | count |
|---|---|
| core | 5 |
| adapters | 3 |
| kanban | 3 |
| cline | 2 |
| visual_memory | 2 |
| bundles | 2 |
| ollama | 2 |
| vaults | 2 |
| nodes | 1 |
| resources | 1 |
| openwebui | 1 |
| skills | 1 |

## Por riesgo

| risk | count |
|---|---|
| HIGH | 6 |
| LOW | 10 |
| MEDIUM | 9 |

## Por nivel de automatizacion

| automation_level | count |
|---|---|
| ASSISTED | 20 |
| BLOCKED | 1 |
| SEMI_AUTOMATED | 4 |

## Por adapter requerido

| adapter | count |
|---|---|
| OBSIDIAN | 11 |
| POWERSHELL | 7 |
| OPENWEBUI | 3 |
| OLLAMA | 1 |
| OPENCLAW_FUTURE | 1 |
| KANBAN | 1 |
| CLINE | 1 |

## Quick wins candidatos

| card_id | title | area | adapter | automation | risk |
|---|---|---|---|---|---|
| SYSTEM_NEED_001 | Arquitectura Obsidian visible | vaults | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_004 | Bundles limpios para Ollama | ollama | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_005 | Registry de skills OpenWebUI | skills | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_010 | OpenWebUI Knowledge Base | openwebui | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_012 | Resource Library reusable | resources | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_016 | Evidence First universal | core | POWERSHELL | ASSISTED | LOW |
| SYSTEM_NEED_017 | Estado y NEXT global | core | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_018 | Taxonomia YAML y tags | vaults | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_020 | Dashboard humano Obsidian-Kanban | kanban | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_025 | Cierre y handoff de contexto | bundles | OBSIDIAN | ASSISTED | LOW |

## Riesgo alto: revisar con gate antes de tocar

| card_id | title | adapter | automation |
|---|---|---|---|
| SYSTEM_NEED_006 | Governance de gates humanos | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_007 | Worker adapters gobernados | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_008 | Cline proposal-only | CLINE | SEMI_AUTOMATED |
| SYSTEM_NEED_021 | Control de un solo escritor | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_022 | OpenClaw adapter futuro | OPENCLAW_FUTURE | BLOCKED |
| SYSTEM_NEED_023 | Controlled Apply reusable | POWERSHELL | SEMI_AUTOMATED |

## Decision recomendada

1. Empezar por quick wins LOW/MEDIUM con adapter OBSIDIAN, OPENWEBUI o POWERSHELL.
2. Mantener HIGH en revision humana/gate.
3. No ejecutar automatizacion real todavia.
4. Convertir esta revision en `REFRESH_PROPOSAL.md`.

```

## First operational selection

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

## Ollama previous recommendation

```markdown
# OLLAMA_RECOMMENDATION

## Decision

decision: GO_ANALYSIS_ONLY
recommended_first_card: SYSTEM_NEED_001
human_decision: DEFER

## Motivo

La arquitectura Obsidian visible es la base para que los bundles, el registry, las skills y el backlog funcionen con menos ruido.

## Dependencias

- SYSTEM_NEED_004 depende de SYSTEM_NEED_001.
- SYSTEM_NEED_005 depende de SYSTEM_NEED_001 y SYSTEM_NEED_004.

## Primera accion segura

Auditar en modo read-only la configuracion de HOME, ESTADO y MASTER_INDEX en la boveda global y bovedas dedicadas.

## No hacer todavia

- No aplicar cambios reales.
- No tocar Git.
- No ejecutar workers.
- No modificar arquitectura sin gate humano.
- No pasar a bundles/registry hasta validar estructura base.

## Next

ENGREMIAT_OBSIDIAN_ARCHITECTURE_READONLY_AUDIT_001

```

## System needs index

```markdown
# SYSTEM_NEEDS_INDEX

| card_id | title | status | system_area | priority | risk | automation_level | adapter | node |
|---|---|---|---|---|---|---|---|---|
| SYSTEM_NEED_001 | Arquitectura Obsidian visible | ACTIVE | vaults | Alta | LOW | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_002 | Backlog vivo de necesidades | ACTIVE | kanban | Alta | MEDIUM | ASSISTED | KANBAN | NONE |
| SYSTEM_NEED_003 | Autoanalisis de backlog | ACTIVE | kanban | Alta | MEDIUM | SEMI_AUTOMATED | POWERSHELL | NONE |
| SYSTEM_NEED_004 | Bundles limpios para Ollama | ACTIVE | ollama | Alta | LOW | ASSISTED | OPENWEBUI | MAIN_PC |
| SYSTEM_NEED_005 | Registry de skills OpenWebUI | ACTIVE | skills | Alta | LOW | ASSISTED | OPENWEBUI | MAIN_PC |
| SYSTEM_NEED_006 | Governance de gates humanos | ACTIVE | core | Alta | HIGH | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_007 | Worker adapters gobernados | ACTIVE | adapters | Alta | HIGH | ASSISTED | OBSIDIAN | MAIN_PC |
| SYSTEM_NEED_008 | Cline proposal-only | ACTIVE | cline | Alta | HIGH | SEMI_AUTOMATED | CLINE | MAIN_PC |
| SYSTEM_NEED_009 | Ollama consulta local segura | ACTIVE | ollama | Alta | MEDIUM | ASSISTED | OLLAMA | MAIN_PC |
| SYSTEM_NEED_010 | OpenWebUI Knowledge Base | ACTIVE | openwebui | Alta | LOW | ASSISTED | OPENWEBUI | MAIN_PC |
| SYSTEM_NEED_011 | Module Registry navegable | ACTIVE | bundles | Alta | MEDIUM | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_012 | Resource Library reusable | ACTIVE | resources | Media | LOW | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_013 | Visual Memory operativa | ACTIVE | visual_memory | Alta | MEDIUM | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_014 | Plan to Worker como puente | ACTIVE | adapters | Media | MEDIUM | ASSISTED | POWERSHELL | MAIN_PC |
| SYSTEM_NEED_015 | Prompt Factory local | ACTIVE | cline | Media | MEDIUM | ASSISTED | POWERSHELL | MAIN_PC |
| SYSTEM_NEED_016 | Evidence First universal | ACTIVE | core | Alta | LOW | ASSISTED | POWERSHELL | NONE |
| SYSTEM_NEED_017 | Estado y NEXT global | ACTIVE | core | Alta | LOW | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_018 | Taxonomia YAML y tags | ACTIVE | vaults | Media | LOW | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_019 | Grafo de relaciones | ACTIVE | visual_memory | Media | MEDIUM | SEMI_AUTOMATED | POWERSHELL | MAIN_PC |
| SYSTEM_NEED_020 | Dashboard humano Obsidian-Kanban | ACTIVE | kanban | Media | LOW | ASSISTED | OBSIDIAN | NONE |
| SYSTEM_NEED_021 | Control de un solo escritor | ACTIVE | nodes | Alta | HIGH | ASSISTED | OBSIDIAN | MAIN_PC |
| SYSTEM_NEED_022 | OpenClaw adapter futuro | ACTIVE | adapters | Media | HIGH | BLOCKED | OPENCLAW_FUTURE | MAIN_PC |
| SYSTEM_NEED_023 | Controlled Apply reusable | ACTIVE | core | Alta | HIGH | SEMI_AUTOMATED | POWERSHELL | MAIN_PC |
| SYSTEM_NEED_024 | Errores recurrentes PowerShell | ACTIVE | core | Alta | MEDIUM | ASSISTED | POWERSHELL | NONE |
| SYSTEM_NEED_025 | Cierre y handoff de contexto | ACTIVE | bundles | Alta | LOW | ASSISTED | OBSIDIAN | NONE |

```

```

## Tarjeta SYSTEM_NEED_004

```markdown
---
type: clean_import_bundle
bundle_id: SYSTEM_NEED_004_NEXT_CLEAN_BUNDLE
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/clean, system_need_004, ollama]
---
# SYSTEM_NEED_004_NEXT_CLEAN_BUNDLE

## Tarjeta activa

SYSTEM_NEED_004 · Bundles limpios para Ollama

## Objetivo

Separar el contexto global en bundles tematicos pequenos para que Ollama y OpenWebUI consulten sin ruido.

## Resultado esperado

- Bundles limpios por capa.
- Orden de importacion.
- Prompt de consulta seguro.
- Evidencia local PASS.

## Primera accion segura

Revisar estos bundles en OpenWebUI/Ollama y pedir analisis de suficiencia de contexto, no ejecucion.

## No hacer todavia

- No automatizar importacion.
- No usar API externa.
- No tocar Git.
- No ejecutar workers.
- No modificar registry sin gate.

```

## Reglas y gates resumidos

```markdown
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

```

## Pregunta esperada

Con este contexto minimo, indica si debemos continuar con SYSTEM_NEED_004 y cual es la primera accion local segura para mejorar los bundles sin ejecutar nada real.
