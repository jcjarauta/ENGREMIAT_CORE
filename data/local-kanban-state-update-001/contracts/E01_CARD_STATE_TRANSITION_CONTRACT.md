# E01 · Card state transition contract

## Objetivo

Definir cómo una respuesta/evidencia del worker puede convertirse en una propuesta de transición de estado para una tarjeta del Kanban local.

## Transiciones permitidas

```text
BACKLOG → NEXT
NEXT → DOING
DOING → REVIEW
REVIEW → DONE
NEXT → BLOCKED
DOING → BLOCKED
BLOCKED → NEXT
```

## Regla principal

Este paso no modifica tarjetas. Solo define contrato.

## Política de seguridad

- No escribir en Cline/Kanban.
- No modificar Markdown/YAML todavía.
- No git.
- No red externa.
- Toda actualización real requiere backup y gate humano.

## Archivos

- Contract JSON: 
C:\ENGREMIAT_CORE\data\local-kanban-state-update-001\contracts\card-state-transition-contract.v1.json

## Siguiente

E02_ANALYZE_WORKER_EVIDENCE_FOR_CARD_TRANSITION_DRY_RUN
