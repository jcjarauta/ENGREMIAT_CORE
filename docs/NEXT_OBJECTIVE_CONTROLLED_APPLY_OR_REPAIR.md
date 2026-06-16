# NEXT OBJECTIVE - CONTROLLED APPLY OR REPAIR

Decision source: data/cline-real-proposal-no-apply/sample-human-proposal-decision.json.

## Decision actual
decision=
DEFER
proposal_status=
PENDING_OUTPUT

## Ruta recomendada
Si decision=APPROVE y proposal_status no es PENDING_OUTPUT: preparar un objetivo separado de apply controlado con gate humano, diff revisable y rollback.
Si decision=DEFER o proposal_status=PENDING_OUTPUT: mantener espera, crear tarea Cline real con autorizacion explicita o aportar manual-cline-output.md.
Si decision=REPAIR: reparar contrato, captura o prompt antes de intentar apply.
Si decision=REJECT: cerrar sin apply y seleccionar otro candidato.

## Prohibicion
No iniciar apply automaticamente desde 008. Apply siempre va en objetivo separado con autorizacion humana.

## Siguiente sugerido
NEXT=
NEXT_OBJECTIVE_WAIT_OR_RETRY_CLINE_REAL_PROPOSAL
