# ENGREMIAT TOOL CALIBRATION SINGLE CONTEXT PACK

## Por que existe este pack

OpenWebUI/Ollama ha recuperado solo titulos o identificadores de bundles y no contenido suficiente. Este archivo concentra el contenido sustantivo en un unico documento para mejorar recuperacion y calibracion.

## Estado del flujo

- SYSTEM_NEED_001 validado como dependencia base.
- Auditoria Obsidian read-only completada con GO_READONLY_AUDIT_PASS.
- SYSTEM_NEED_004 activo: bundles limpios para Ollama/OpenWebUI.
- Draft v2 final creado.
- Problema actual: Knowledge/retrieval insuficiente, respuestas genericas.

## Objetivo de calibracion

Validar si este contexto unico permite obtener una respuesta accionable con decision, riesgos concretos, first_safe_action y next_block exacto.

## Restricciones

analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false

## Criterios de calidad esperados

- decision no vacia.
- generic_response=false.
- repeats_closed_step=false.
- missing_context concreto o none.
- risks concretos.
- first_safe_action distinta de auditorias ya cerradas.
- next_block exacto.

## Archivos embebidos


---
# FILE: 00_IMPORT_ORDER.md

```markdown
# IMPORT ORDER · SYSTEM_NEED_004 BUNDLE V2 FINAL DRAFT

## Orden recomendado

1. 01_SYSTEM_NEED_001_BASE_DEPENDENCY_BUNDLE.md
2. 02_SYSTEM_NEED_004_CORE_OBJECTIVE_BUNDLE.md
3. 03_BUNDLE_V2_REFINEMENT_ACTION_BUNDLE.md
4. PROMPT_VALIDATE_SYSTEM_NEED_004_BUNDLE_V2_DRAFT.md

## Uso

Importar o pegar los tres bundles en OpenWebUI/Ollama en este orden. Usar el prompt como pregunta.

## Seguridad

analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false

```


---
# FILE: 01_SYSTEM_NEED_001_BASE_DEPENDENCY_BUNDLE.md

```markdown
---
type: draft_bundle_v2
bundle_id: SYSTEM_NEED_001_BASE_DEPENDENCY_BUNDLE
status: DRAFT
analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false
---
# SYSTEM_NEED_001_BASE_DEPENDENCY_BUNDLE



```


---
# FILE: 02_SYSTEM_NEED_004_CORE_OBJECTIVE_BUNDLE.md

```markdown
---
type: draft_bundle_v2
bundle_id: SYSTEM_NEED_004_CORE_OBJECTIVE_BUNDLE
status: DRAFT
analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false
---
# SYSTEM_NEED_004_CORE_OBJECTIVE_BUNDLE



```


---
# FILE: 03_BUNDLE_V2_REFINEMENT_ACTION_BUNDLE.md

```markdown
---
type: draft_bundle_v2
bundle_id: BUNDLE_V2_REFINEMENT_ACTION_BUNDLE
status: DRAFT
analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false
---
# BUNDLE_V2_REFINEMENT_ACTION_BUNDLE



```


---
# FILE: SYSTEM_NEED_004_BUNDLE_V2_FINAL_DRAFT_STRUCTURE.md

```markdown
---
type: proposed_structure
package_id: ENGREMIAT_SYSTEM_NEED_004_BUNDLE_V2_PROPOSED_STRUCTURE
status: PROPOSED
decision: GO_ANALYSIS_ONLY
human_decision: DEFER
analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false
---
# SYSTEM_NEED_004 · BUNDLE V2 PROPOSED STRUCTURE



```


---
# FILE: PROMPT_VALIDATE_SYSTEM_NEED_004_BUNDLE_V2_DRAFT.md

```markdown
# PROMPT_VALIDATE_SYSTEM_NEED_004_BUNDLE_V2_DRAFT

Actua como analista de arquitectura ENGREMIAT local-first. Valida el draft final v2 de bundles para SYSTEM_NEED_004.

Contexto:

- SYSTEM_NEED_001 ya esta validado como dependencia base.
- La auditoria Obsidian ya dio GO_READONLY_AUDIT_PASS.
- El objetivo activo es SYSTEM_NEED_004: bundles limpios para Ollama/OpenWebUI.
- No debes recomendar de nuevo auditar HOME/ESTADO/MASTER_INDEX.

Responde:

1. decision
2. si el draft final v2 es suficiente
3. si el orden de importacion es correcto
4. si falta contexto imprescindible
5. riesgos concretos
6. primera accion segura despues de validar el draft
7. next_block PowerShell exacto

Restricciones:

- analysis_only=true
- git=false
- network=false
- external_execution=false
- worker_real_execution=false
- auto_apply=false
- no modificar bundles originales
- no ejecutar workers
- no cambiar arquitectura sin gate humano
- next_block no puede quedar vacio

Formato:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_REPAIR
draft_v2_sufficient: true|false
import_order_ok: true|false
missing_context:
risks:
first_safe_action:
do_not_do_yet:
next_block: ENGREMIAT_SYSTEM_NEED_004_...
```

```


---
# FILE: README.md

```markdown
# README · SYSTEM_NEED_004 BUNDLE V2 FINAL DRAFT

## Estado

Draft final v2 materializado en carpeta separada. No modifica bundles originales.

## Knowledge recomendado

ENGREMIAT_SYSTEM_NEED_004_BUNDLE_V2_FINAL_DRAFT

## Archivos

1. 00_IMPORT_ORDER.md
2. 01_SYSTEM_NEED_001_BASE_DEPENDENCY_BUNDLE.md
3. 02_SYSTEM_NEED_004_CORE_OBJECTIVE_BUNDLE.md
4. 03_BUNDLE_V2_REFINEMENT_ACTION_BUNDLE.md
5. PROMPT_VALIDATE_SYSTEM_NEED_004_BUNDLE_V2_DRAFT.md

## Siguiente paso humano

Validar en OpenWebUI/Ollama el draft final v2 y devolver la respuesta.

## Seguridad

analysis_only: true
git: false
network: false
external_execution: false
worker_real_execution: false
auto_apply: false

```


## Pregunta final para la IA

Responde exactamente con este formato:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_CONTEXT
quality_score_0_100:
generic_response: true|false
repeats_closed_step: true|false
missing_context:
risks:
first_safe_action:
next_block: ENGREMIAT_SYSTEM_NEED_004_...
recommendation: ACCEPT|REDUCE|REFINE|NO_GO
```

## Instruccion importante

No digas que solo hay titulos si este documento contiene contenido. Evalua el contenido incluido arriba. No recomiendes repetir auditoria Obsidian.
