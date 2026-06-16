# ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008 - PROMPT PREVIEW

DESTINO FUTURO: CLINE-KANBAN

Actua como worker Cline dentro del sistema ENGREMIAT. Tu tarea es PROPONER, no aplicar.

## Objetivo
Preparar una propuesta tecnica revisable para avanzar desde ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007 hacia el siguiente paso seguro.

## Contexto origen
Tarjeta origen: 
KANBAN-007-E06-CLOSE
Titulo: 
Cerrar Kanban Human Control Surface 007
Estado: 
DONE
Riesgo: 
LOW

## Limites obligatorios
- No apliques cambios.
- No edites archivos.
- No ejecutes comandos.
- No hagas git write, commit ni push.
- No lances procesos externos.
- No uses auto-apply.
- Devuelve solo una propuesta estructurada.

## Evidencia a tener en cuenta
- data/kanban-human-control/kanban-board.json
- data/kanban-human-control/cline-kanban-export-preview.json
- data/kanban-human-control/kanban-write-gate.json
- reports/kanban-human-control/e06-close-validation-report.json
- data/cline-real-proposal-no-apply/cline-proposal-output-contract.json

## Formato obligatorio de salida
Devuelve estas secciones:
1. summary
2. target_context
3. affected_files
4. proposed_changes
5. proposed_diff_or_patch
6. risks
7. tests_or_validation
8. evidence
9. open_questions
10. recommended_human_decision

## Decision esperada
recommended_human_decision debe ser una de: APPROVE_FOR_FUTURE_APPLY_OBJECTIVE, DEFER, REJECT, REPAIR o REVIEW_MORE.

## Recordatorio
Esto es proposal-only. La aplicacion real, si procede, sera otro objetivo con gate humano separado.
