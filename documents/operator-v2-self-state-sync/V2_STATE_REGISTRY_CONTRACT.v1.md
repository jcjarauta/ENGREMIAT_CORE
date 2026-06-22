# V2 STATE REGISTRY CONTRACT v1

## Proposito
Convertir Operador V2 en consola viva del desarrollo, actualizada por cada bloque cerrado.

## Capas
- V1: gestion diaria del sistema ENGREMIAT_CORE.
- V2: gestion, validacion, auditoria, reparacion y evolucion de V1.

## Archivos canonicos propuestos
- data/operator-v2-self-state-sync/v2-state.registry.json
- data/operator-v2-self-state-sync/v2-state.events.jsonl
- data/operator-v2-self-state-sync/v2-state.latest.json
- documents/operator-v2-self-state-sync/V2_STATE_INDEX.md

## Entidades minimas
- objective
- stage
- step
- artifact
- evidence
- decision
- risk
- next_action
- git_state

## Regla de actualizacion
Cada bloque cerrado debe registrar package, stage, step, status, report, git_state y next_action.

## Decision
GO_E03_CREATE_V2_STATE_REGISTRY_FILES_DRY_RUN_OR_SAFE_INIT
