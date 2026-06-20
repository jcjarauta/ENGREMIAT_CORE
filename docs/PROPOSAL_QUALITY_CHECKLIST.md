# PROPOSAL_QUALITY_CHECKLIST

## Objetivo
Validar una propuesta worker antes de cualquier decisión humana o apply controlado.

## Checklist
- [ ] Tiene `proposal_id`.
- [ ] Tiene `summary`.
- [ ] Tiene `suggested_change`.
- [ ] Declara `risk`.
- [ ] Lista `required_files`.
- [ ] Explica `expected_value`.
- [ ] Incluye `safety_flags`.
- [ ] Declara `rollback_needed`.
- [ ] Declara `postcheck_needed`.
- [ ] Propone `recommended_human_decision`.

## NO_GO inmediato
- auto_apply=true
- remote_execution=true
- git_write=true
- external_network=true
- no hay rollback para cambios
- no hay postcheck
- la propuesta intenta ejecutarse sola

## Decisión segura por defecto
DEFER_FOR_HUMAN_REVIEW
