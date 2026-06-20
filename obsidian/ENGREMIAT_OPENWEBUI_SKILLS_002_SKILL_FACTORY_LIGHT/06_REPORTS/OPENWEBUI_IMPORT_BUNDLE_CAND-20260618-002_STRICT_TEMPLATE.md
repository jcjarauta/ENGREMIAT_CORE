---
type: openwebui_import_bundle
candidate_id: CAND-20260618-002
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: READY_FOR_IMPORT
---
# OPENWEBUI IMPORT BUNDLE · CAND-20260618-002 · STRICT TEMPLATE

## Objetivo

Este Markdown único contiene todo lo necesario para que OpenWebUI pruebe la candidata `SKILL_CAPTURE_TO_CANDIDATE` sin depender de leer carpetas o nombres de archivo externos.

## Instrucción para OpenWebUI

Usa este documento como fuente principal. Si el usuario pide convertir una captura en candidata, debes completar la plantilla estricta y no explicar narrativamente.

## Candidate schema

```text
---
type: schema
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: ACTIVE
---
# CANDIDATE SCHEMA

## Campos obligatorios

- candidate_id
- proposed_skill_id
- name
- source
- human_problem
- trigger_phrase
- expected_output
- source_files
- test_status
- decision
- next

## Estados de test

- PENDING
- PASS
- WARN
- FAIL

## Decisiones

- CAPTURE_ONLY
- CANDIDATE
- REPAIR
- OFFICIALIZE
- DISCARD

## Regla

Una candidata no se oficializa si `test_status` no es PASS o si no existe evidencia humana repetible.

```

## Strict output contract

```text
---
type: output_contract
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
candidate_id: CAND-20260618-002
status: ACTIVE
---
# STRICT TEMPLATE OUTPUT CONTRACT

## Objetivo

Forzar que OpenWebUI devuelva una ficha de candidata estricta, no una explicacion narrativa.

## Salida obligatoria

Debe devolver exactamente estos campos, en texto plano:

```text
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
name:
source: openwebui_manual_test
human_problem:
trigger_phrase:
expected_output:
source_files:
test_status: PENDING
decision: CANDIDATE
next:
```

## Reglas

- No usar JSON.
- No escribir introduccion.
- No explicar el proceso.
- No oficializar.
- No poner PASS.
- No cambiar candidate_id.
- No cambiar proposed_skill_id.

```

## Candidate current file

```text
---
type: skill_candidate
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: CANDIDATE
test_status: STRICT_TEMPLATE_READY
decision: TEMPLATE_MODE_REQUIRED
source: manual_stage_pattern
---
# CAND-20260618-002 · Skill candidata · Capture to Candidate

## Nombre humano

Convertir captura útil en candidata de skill

## Problema humano

Cuando aparece una respuesta útil en OpenWebUI, Ollama, Cline o ChatGPT, el humano necesita convertirla en una candidata ordenada sin perder contexto ni crear una skill oficial prematura.

## Aprendizaje B05/B07

Los prompts abiertos producen explicaciones o resúmenes. Para esta skill se necesita plantilla estricta rellenable.

## B08 Enfoque

Usar prompt rígido con campos obligatorios y prohibición explícita de JSON, explicación, PASS u oficialización.

## Estado

CANDIDATE

## Test

STRICT_TEMPLATE_READY

## Decision

TEMPLATE_MODE_REQUIRED

## Siguiente

Ejecutar tercera prueba manual con `PROMPT_CAND-20260618-002_STRICT_TEMPLATE.txt`.

```

## Prompt estricto para prueba

```text
Rellena la plantilla siguiente.

REGLAS ESTRICTAS:
- No expliques el proceso.
- No devuelvas JSON.
- No escribas introduccion ni cierre.
- No oficialices la skill.
- No uses PASS.
- Mantén test_status: PENDING.
- Mantén decision: CANDIDATE.
- Devuelve SOLO la plantilla rellenada.

CAPTURA A CONVERTIR:
La respuesta de OpenWebUI sobre el estado ENGREMIAT fue útil porque resumió estado actual, último bloque, siguiente paso y riesgos. Queremos convertir este patrón en una candidata reutilizable para próximas capturas.

PLANTILLA OBLIGATORIA:
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
name:
source: openwebui_manual_test
human_problem:
trigger_phrase:
expected_output:
source_files:
test_status: PENDING
decision: CANDIDATE
next:

```

## Resultado esperado

```text
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
name: Convertir captura útil en candidata de skill
source: openwebui_manual_test
human_problem: Convertir una captura útil en ficha de candidata sin oficializar prematuramente.
trigger_phrase: Convierte esta captura en candidata de skill ENGREMIAT usando el schema de Skill Factory Light.
expected_output: Ficha de candidata con campos obligatorios, test_status PENDING, decision CANDIDATE y next de test manual.
source_files: OPENWEBUI_IMPORT_BUNDLE_CAND-20260618-002_STRICT_TEMPLATE.md
test_status: PENDING
decision: CANDIDATE
next: Ejecutar test manual PASS/WARN/FAIL antes de oficializar.
```
