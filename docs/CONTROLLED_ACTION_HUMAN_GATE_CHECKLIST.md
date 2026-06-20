# CONTROLLED ACTION HUMAN GATE CHECKLIST

## Regla de aprobacion
Solo se permite continuar si se cumplen las tres condiciones:

```text
decision=APPROVE
human_confirmation=true
execution_allowed=true
```

## Verificacion humana
- Confirmo que entiendo el alcance de la accion.
- Confirmo que la accion es minima y reversible.
- Confirmo que no hay auto_apply.
- Confirmo que no hay remote_execution.
- Confirmo que no hay git_write sin autorizacion explicita.
- Confirmo que Kanban es superficie humana de control, no motor de ejecucion.

## Decision posible
- DEFER: bloquear por defecto.
- REJECT: rechazar y registrar.
- APPROVE: permitir solo la siguiente fase gated, sin apply automatico.

## Resultado esperado
El gate protege. La maquina prepara. El humano decide.
