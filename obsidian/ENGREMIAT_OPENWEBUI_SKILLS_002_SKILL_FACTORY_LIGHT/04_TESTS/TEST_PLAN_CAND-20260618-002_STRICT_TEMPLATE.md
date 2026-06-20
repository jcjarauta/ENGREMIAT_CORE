---
type: manual_test_plan
candidate_id: CAND-20260618-002
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: READY
---
# TEST PLAN · STRICT TEMPLATE · CAND-20260618-002

## Objetivo

Validar si OpenWebUI puede completar una plantilla estricta sin desviarse a explicacion narrativa.

## Prompt

Usar `PROMPT_CAND-20260618-002_STRICT_TEMPLATE.txt`.

## Criterios PASS

- Devuelve candidate_id exacto.
- Devuelve proposed_skill_id exacto.
- Incluye todos los campos obligatorios.
- Mantiene test_status PENDING.
- Mantiene decision CANDIDATE.
- No usa JSON.
- No explica el proceso.
- No oficializa.

## Criterios WARN

- Cumple casi todo, pero añade breve explicación o falta un campo secundario.

## Criterios FAIL

- Vuelve a explicar narrativamente.
- Usa JSON.
- Cambia PASS/OFFICIAL.
- No respeta la plantilla.
