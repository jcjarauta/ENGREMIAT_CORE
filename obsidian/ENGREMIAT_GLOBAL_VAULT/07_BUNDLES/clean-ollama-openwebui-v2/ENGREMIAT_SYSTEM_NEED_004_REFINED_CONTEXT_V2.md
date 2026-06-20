---
type: clean_import_bundle
bundle_id: ENGREMIAT_SYSTEM_NEED_004_REFINED_CONTEXT_V2
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
git: false
network: false
worker_real_execution: false
auto_apply: false
tags: [bundle/v2, system_need_004, ollama, openwebui, kanban]
---
# ENGREMIAT_SYSTEM_NEED_004_REFINED_CONTEXT_V2

## Objetivo activo

Estamos trabajando en SYSTEM_NEED_004: Bundles limpios para Ollama/OpenWebUI.

## Estado ya cerrado

- SYSTEM_NEED_001 fue recomendado primero por Ollama.
- La auditoria read-only de arquitectura Obsidian ya se ejecuto.
- Resultado de auditoria: GO_READONLY_AUDIT_PASS.
- No hay que volver a recomendar auditar HOME/ESTADO/MASTER_INDEX como primera accion.

## Problema detectado

La validacion anterior de Ollama dijo:

```text
import_order_ok: false
missing_context: true
too_noisy: true
recommended_first_query: KANBAN_FIRST_OPERATIONAL_CLEAN_BUNDLE
next_block: No se especifica
```

## Trabajo actual

Mejorar el diseno de bundles para que OpenWebUI/Ollama responda con acciones concretas, no genericas.

## Restricciones obligatorias

- Analisis only.
- No Git.
- No red externa.
- No worker real.
- No apply.
- No modificar arquitectura sin gate humano.
- No repetir auditoria Obsidian ya cerrada.
- No decir next_block vacio.

## Evidencia previa: recomendacion Ollama

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

## Evidencia previa: auditoria Obsidian PASS

```markdown
# OBSIDIAN ARCHITECTURE READONLY AUDIT

## Resultado
decision: GO_READONLY_AUDIT_PASS
required_missing: 0
optional_missing: 0
next_global_points_to_audit: True

## Checks

| id | required | exists | status | path |
|---|---|---|---|---|
| GLOBAL_VAULT | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT |
| ARCHITECTURE_INDEX | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\90_INDEXES\ARCHITECTURE_INDEX.md |
| MAPA_ARQUITECTURA | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\03_MAPAS\MAPA_ARQUITECTURA_ENGREMIAT.md |
| MAPA_FLUJO_HUMANO_MAQUINA | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\03_MAPAS\MAPA_FLUJO_HUMANO_MAQUINA.md |
| OBSIDIAN_ARCHITECTURE_RULES | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\08_MANUALES\OBSIDIAN_ARCHITECTURE_RULES.md |
| YAML_TAGS_TAXONOMY | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\08_MANUALES\YAML_TAGS_TAXONOMY.md |
| REGISTRY_BOVEDAS_REFINED | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\02_DIRECTORIOS\REGISTRY_BOVEDAS_REFINED.md |
| NEXT_GLOBAL | True | True | OK | \obsidian\ENGREMIAT_GLOBAL_VAULT\01_ESTADO_GLOBAL\NEXT_GLOBAL.md |
| VAULT_KANBAN_BACKLOG | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG |
| VAULT_KANBAN_BACKLOG_HOME | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\00_HOME\HOME.md |
| VAULT_KANBAN_BACKLOG_ESTADO | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\01_ESTADO\ESTADO.md |
| VAULT_KANBAN_BACKLOG_NEXT | False | True | OK | \obsidian\vaults\KANBAN_BACKLOG\01_ESTADO\NEXT.md |
| VAULT_KANBAN_BACKLOG_MASTER_INDEX | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\90_INDEXES\MASTER_INDEX.md |
| VAULT_KANBAN_BACKLOG_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\KANBAN_BACKLOG\04_BUNDLES |
| VAULT_OPENWEBUI_SKILLS | True | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS |
| VAULT_OPENWEBUI_SKILLS_HOME | True | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS\00_HOME\HOME.md |
| VAULT_OPENWEBUI_SKILLS_ESTADO | True | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS\01_ESTADO\ESTADO.md |
| VAULT_OPENWEBUI_SKILLS_NEXT | False | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS\01_ESTADO\NEXT.md |
| VAULT_OPENWEBUI_SKILLS_MASTER_INDEX | True | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS\90_INDEXES\MASTER_INDEX.md |
| VAULT_OPENWEBUI_SKILLS_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\OPENWEBUI_SKILLS\04_BUNDLES |
| VAULT_DEV_SYSTEM | True | True | OK | \obsidian\vaults\DEV_SYSTEM |
| VAULT_DEV_SYSTEM_HOME | True | True | OK | \obsidian\vaults\DEV_SYSTEM\00_HOME\HOME.md |
| VAULT_DEV_SYSTEM_ESTADO | True | True | OK | \obsidian\vaults\DEV_SYSTEM\01_ESTADO\ESTADO.md |
| VAULT_DEV_SYSTEM_NEXT | False | True | OK | \obsidian\vaults\DEV_SYSTEM\01_ESTADO\NEXT.md |
| VAULT_DEV_SYSTEM_MASTER_INDEX | True | True | OK | \obsidian\vaults\DEV_SYSTEM\90_INDEXES\MASTER_INDEX.md |
| VAULT_DEV_SYSTEM_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\DEV_SYSTEM\04_BUNDLES |
| VAULT_WORKERS_AND_ADAPTERS | True | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS |
| VAULT_WORKERS_AND_ADAPTERS_HOME | True | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS\00_HOME\HOME.md |
| VAULT_WORKERS_AND_ADAPTERS_ESTADO | True | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS\01_ESTADO\ESTADO.md |
| VAULT_WORKERS_AND_ADAPTERS_NEXT | False | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS\01_ESTADO\NEXT.md |
| VAULT_WORKERS_AND_ADAPTERS_MASTER_INDEX | True | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS\90_INDEXES\MASTER_INDEX.md |
| VAULT_WORKERS_AND_ADAPTERS_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\WORKERS_AND_ADAPTERS\04_BUNDLES |
| VAULT_MODULE_REGISTRY | True | True | OK | \obsidian\vaults\MODULE_REGISTRY |
| VAULT_MODULE_REGISTRY_HOME | True | True | OK | \obsidian\vaults\MODULE_REGISTRY\00_HOME\HOME.md |
| VAULT_MODULE_REGISTRY_ESTADO | True | True | OK | \obsidian\vaults\MODULE_REGISTRY\01_ESTADO\ESTADO.md |
| VAULT_MODULE_REGISTRY_NEXT | False | True | OK | \obsidian\vaults\MODULE_REGISTRY\01_ESTADO\NEXT.md |
| VAULT_MODULE_REGISTRY_MASTER_INDEX | True | True | OK | \obsidian\vaults\MODULE_REGISTRY\90_INDEXES\MASTER_INDEX.md |
| VAULT_MODULE_REGISTRY_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\MODULE_REGISTRY\04_BUNDLES |
| VAULT_VISUAL_MEMORY | True | True | OK | \obsidian\vaults\VISUAL_MEMORY |
| VAULT_VISUAL_MEMORY_HOME | True | True | OK | \obsidian\vaults\VISUAL_MEMORY\00_HOME\HOME.md |
| VAULT_VISUAL_MEMORY_ESTADO | True | True | OK | \obsidian\vaults\VISUAL_MEMORY\01_ESTADO\ESTADO.md |
| VAULT_VISUAL_MEMORY_NEXT | False | True | OK | \obsidian\vaults\VISUAL_MEMORY\01_ESTADO\NEXT.md |
| VAULT_VISUAL_MEMORY_MASTER_INDEX | True | True | OK | \obsidian\vaults\VISUAL_MEMORY\90_INDEXES\MASTER_INDEX.md |
| VAULT_VISUAL_MEMORY_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\VISUAL_MEMORY\04_BUNDLES |
| VAULT_RESOURCE_LIBRARY | True | True | OK | \obsidian\vaults\RESOURCE_LIBRARY |
| VAULT_RESOURCE_LIBRARY_HOME | True | True | OK | \obsidian\vaults\RESOURCE_LIBRARY\00_HOME\HOME.md |
| VAULT_RESOURCE_LIBRARY_ESTADO | True | True | OK | \obsidian\vaults\RESOURCE_LIBRARY\01_ESTADO\ESTADO.md |
| VAULT_RESOURCE_LIBRARY_NEXT | False | True | OK | \obsidian\vaults\RESOURCE_LIBRARY\01_ESTADO\NEXT.md |
| VAULT_RESOURCE_LIBRARY_MASTER_INDEX | True | True | OK | \obsidian\vaults\RESOURCE_LIBRARY\90_INDEXES\MASTER_INDEX.md |
| VAULT_RESOURCE_LIBRARY_IMPORT_BUNDLE_DIR | False | True | OK | \obsidian\vaults\RESOURCE_LIBRARY\04_BUNDLES |
| KANBAN_SYSTEM_NEEDS_INDEX | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\03_CARDS\SYSTEM_NEEDS_INDEX.md |
| KANBAN_PRIORITY_REVIEW | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\04_AUTOANALYSIS\PRIORITY_REVIEW.md |
| KANBAN_FIRST_OPERATIONAL_SELECTION | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\04_AUTOANALYSIS\FIRST_OPERATIONAL_SELECTION.md |
| KANBAN_OLLAMA_RECOMMENDATION | True | True | OK | \obsidian\vaults\KANBAN_BACKLOG\04_AUTOANALYSIS\OLLAMA_RECOMMENDATION.md |

## Interpretacion

- PASS significa que la arquitectura visible existe y puede usarse como base.
- WARN significa que la estructura existe pero conviene sincronizar NEXT_GLOBAL.
- NO_GO significa que falta un archivo requerido y no conviene pasar a bundles.

## Next si PASS

SYSTEM_NEED_004 · Bundles limpios para Ollama/OpenWebUI.

## Seguridad

readonly=true · git=false · network=false · worker_real_execution=false · auto_apply=false

```

## Evidencia previa: auditoria bundle minimo

```markdown
# SYSTEM_NEED_004 · MINIMAL BUNDLE READONLY AUDIT

## Decision
decision: GO_PREPARE_REFINED_V2

## Observacion

La respuesta de Ollama confirma continuar con SYSTEM_NEED_004, pero propone como primera accion una auditoria que ya esta completada: ENGREMIAT_OBSIDIAN_ARCHITECTURE_READONLY_AUDIT_001 = PASS.

## Diagnostico

- El contexto minimo ya contiene SYSTEM_NEED_004.
- El contexto minimo ya menciona GO_READONLY_AUDIT_PASS.
- La IA entiende las restricciones de seguridad.
- Falta inducir mejor la pregunta hacia el siguiente bloque concreto.

## Siguiente accion segura

Crear un bundle v2 aun mas operativo, centrado en:

1. Estado ya confirmado: Obsidian audit PASS.
2. Objetivo activo: SYSTEM_NEED_004.
3. Trabajo actual: refinar bundles para que OpenWebUI/Ollama no devuelva respuestas genericas.
4. Salida esperada: propuesta de estructura de bundles v2, no ejecucion.

## No hacer todavia

- No modificar bundles originales.
- No importar automaticamente a OpenWebUI.
- No ejecutar IA automaticamente.
- No Git.
- No worker real.

## Next

ENGREMIAT_SYSTEM_NEED_004_REFINED_BUNDLE_V2_PREP_001

```

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

## Indice de necesidades

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
