# NEXT_OBJECTIVE · ENGREMIAT_OPERATOR_V2_ACTIONS_003_E02

## Objetivo
Aplicar el contrato de acciones candidato al active_root del operador V2 usando Guarded Write.

## Condiciones previas
- Context Guardian: GO_ACTIVE_CONTEXT_RESOLVED.
- Healthcheck: GO_OPERATOR_V2_HEALTHY_WITH_WARNINGS o GO_OPERATOR_V2_HEALTHY.
- SCREEN_ACTIONS.candidate.json: existe y valida acciones READY.

## Siguiente paso ejecutable
E02_APPLY_SCREEN_ACTIONS_CONTRACT_WITH_GUARDED_WRITE

## Regla
No escribir en el operador V2 sin ejecutar Start-EngremiatGuardedWrite.ps1 sobre el target concreto.
