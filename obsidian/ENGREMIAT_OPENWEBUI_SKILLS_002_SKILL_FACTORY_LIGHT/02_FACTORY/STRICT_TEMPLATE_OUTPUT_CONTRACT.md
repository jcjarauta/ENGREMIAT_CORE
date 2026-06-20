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
