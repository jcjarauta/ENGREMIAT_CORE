---
type: schema
project: ENGREMIAT_OPENWEBUI_SKILLS_001
status: ACTIVE
---
# SKILL CANDIDATE SCHEMA

## Campos mínimos

- candidate_id
- source
- capture_date
- human_problem
- useful_answer
- repeated_use
- friction_reduced
- proposed_skill_name
- trigger_phrase
- expected_output
- status

## Estados

- CAPTURED
- TESTING
- REPEATED
- OFFICIAL_CANDIDATE
- DISCARDED

## Regla

No oficializar una skill por una sola respuesta útil. Primero debe demostrar repetición, utilidad y reducción de fricción humana.
