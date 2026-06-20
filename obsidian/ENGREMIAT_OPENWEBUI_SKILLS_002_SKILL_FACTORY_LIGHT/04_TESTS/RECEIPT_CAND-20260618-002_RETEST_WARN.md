---
type: manual_retest_receipt
candidate_id: CAND-20260618-002
proposed_skill_id: SKILL_CAPTURE_TO_CANDIDATE
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: WARN
---
# RECEIPT · RETEST · CAND-20260618-002

## Resultado observado

OpenWebUI entendió el concepto general de convertir captura en candidata, pero respondió con explicación narrativa y no con ficha estricta.

## Evaluación

WARN útil. El resultado mejora frente a B05, pero todavía no cumple el contrato de salida.

## Checklist

- [x] Entiende el proceso general.
- [x] Mantiene regla de validación manual.
- [x] Evita oficialización directa.
- [ ] Devuelve candidate_id literal.
- [ ] Devuelve proposed_skill_id literal.
- [ ] Devuelve test_status PENDING.
- [ ] Devuelve decision CANDIDATE o CAPTURE_ONLY.
- [ ] Devuelve next operativo.

## Decisión

WARN

## Aprendizaje

Para esta skill no basta un prompt abierto. Debe usarse modo plantilla rellenable: dar al modelo una ficha exacta y pedir completar solo campos vacíos.

## Siguiente

B08_STRICT_FILLABLE_TEMPLATE_FOR_CAPTURE_TO_CANDIDATE
