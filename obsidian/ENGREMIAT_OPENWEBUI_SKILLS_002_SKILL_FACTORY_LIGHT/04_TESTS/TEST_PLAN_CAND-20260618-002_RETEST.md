---
type: manual_retest_plan
candidate_id: CAND-20260618-002
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: READY
---
# RETEST PLAN · CAND-20260618-002

## Motivo

El primer test devolvió un resumen/ficha de estado en vez de una ficha estricta de candidata.

## Cambio

El prompt reparado fuerza campos obligatorios y prohíbe oficializar o devolver PASS.

## Prompt reparado

Ver `PROMPT_CAND-20260618-002_REPAIRED.txt`.

## Criterios PASS

- Incluye candidate_id CAND-20260618-002.
- Incluye proposed_skill_id SKILL_CAPTURE_TO_CANDIDATE.
- Incluye test_status PENDING.
- Incluye decision CANDIDATE o CAPTURE_ONLY.
- Indica next de test manual.
- No oficializa ni da PASS final.

## Criterios WARN

- Cumple parte del schema pero falta algun campo.

## Criterios FAIL

- Vuelve a resumir estado.
- Oficializa prematuramente.
- Devuelve PASS como decisión final de skill.
