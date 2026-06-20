---
type: gate
project_id: "{{project_id}}"
gate_id: "{{gate_id}}"
status: pending
decision: DEFER
authorization_status: NOT_GRANTED
requires_human: true
sensitive_action: "{{sensitive_action}}"
created_at: "{{created_at}}"
tags:
  - engremiat/gate
  - status/pending
---
# Gate · {{gate_id}}

## Acción sensible
{{sensitive_action}}

## Estado
- Decisión: `DEFER`
- Autorización: `NOT_GRANTED`
- Requiere humano: `true`

## Condición de aprobación

## Evidencia requerida

## Resultado si no se aprueba
NO_GO
