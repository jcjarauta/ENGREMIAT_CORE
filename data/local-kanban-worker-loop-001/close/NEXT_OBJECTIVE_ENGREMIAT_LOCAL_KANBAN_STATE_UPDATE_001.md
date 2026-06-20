# NEXT OBJECTIVE · ENGREMIAT_LOCAL_KANBAN_STATE_UPDATE_001

## Objetivo

Hacer que el Kanban local no solo envíe tareas al worker, sino que pueda actualizar el estado de la tarjeta desde evidencia validada.

## Resultado esperado

Una card podrá avanzar de columna mediante transición gobernada:

```text
NEXT → DOING → REVIEW → DONE
```

## Condición de seguridad

La actualización real del Markdown/YAML debe estar protegida por gate humano y backup previo.

## Primer paso recomendado

E01_DEFINE_CARD_STATE_TRANSITION_CONTRACT
