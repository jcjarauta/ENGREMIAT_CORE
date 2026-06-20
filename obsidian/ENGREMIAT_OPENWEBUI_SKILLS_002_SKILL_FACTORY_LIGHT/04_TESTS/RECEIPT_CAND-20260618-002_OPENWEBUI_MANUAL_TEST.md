---
type: manual_test_receipt
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: WARN
---
# RECEIPT · TEST MANUAL · CAND-20260618-002

## Resultado observado

OpenWebUI devolvió una estructura JSON útil, con estado actual, último bloque, siguiente paso, riesgos, reglas y decisión PASS.

## Evaluación

WARN: la respuesta está bien formada, pero no cumple plenamente el objetivo de convertir una captura en candidata usando el schema de Skill Factory Light. Falta candidate_id, proposed_skill_id, test_status, decision de candidata y next específico de fábrica.

## Checklist humano

- [ ] Respeta todos los campos obligatorios del schema.
- [x] No conecta Telegram ni inventa API.
- [x] Usa reglas canónicas.
- [ ] Propone test_status PENDING.
- [ ] Propone decision CANDIDATE o CAPTURE_ONLY.
- [ ] Define siguiente paso manual de fábrica.

## Decision

WARN

## Siguiente

B06_REPAIR_CAPTURE_TO_CANDIDATE_PROMPT
