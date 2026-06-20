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
