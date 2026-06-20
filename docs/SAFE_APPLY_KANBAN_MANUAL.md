# SAFE APPLY AND KANBAN MANUAL

Objective: 
ENGREMIAT_SAFE_LOCAL_APPLY_AND_KANBAN_AUTHORIZATION_102_111
Stage: E109

## Proposito
Manual de seguridad para apply local autorizado y Kanban write autorizado.

## Regla principal
No ejecutar acciones reales sin autorizacion humana explicita, rollback, postcheck, receipt y readiness.

## Apply local seguro
Requisitos antes de apply:
- scope permitido
- target seguro
- autorizacion humana explicita
- rollback pack valido
- postcheck runner listo
- receipt obligatorio
- no ERR
- no NO_GO

Frase de autorizacion apply:
AUTORIZO_APPLY_LOCAL_CONTROLADO

## Kanban write seguro
Requisitos antes de Kanban write:
- contrato de campos verificado
- dry-run Kanban final
- rollback Kanban
- autorizacion humana explicita
- postcheck/receipt
- no red externa salvo autorizacion especifica

Frase de autorizacion Kanban:
AUTORIZO_KANBAN_WRITE_CONTROLADO

## Flags bloqueantes
- auto_apply=true
- remote_execution=true
- external_network=true sin autorizacion
- worker_executed=true
- kanban_real_write=true sin gate
- git_write=true sin autorizacion

## Archivos clave
- data/apply-scope-102/apply-scope-model.json
- data/rollback-pack-103/rollback-pack.json
- tools/eng-rollback-pack-validate.ps1
- tools/eng-postcheck-runner.ps1
- data/human-authorization-105/human-authorization-decision-contract.json
- data/controlled-apply-106/controlled-apply-result.json
- data/kanban-write-authorization-107/kanban-write-authorization-gate.json
- data/kanban-dryrun-gate-108/kanban-write-gate-result.json
