---
type: validator_contract
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: ACTIVE
---
# READONLY VALIDATOR CONTRACT

## Objetivo

Validar sin escribir que la fabrica ligera tiene contrato, criterios, schema, registros y skill oficial heredada.

## No hace

- No modifica archivos.
- No ejecuta red.
- No usa Git.
- No oficializa skills.

## Decision

- PASS si estructura minima existe.
- WARN si falta alguna pieza secundaria.
- FAIL si falta foundation o registry.
