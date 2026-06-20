# HUMAN REVIEW NOTE

## Objetivo
Convertir la respuesta del worker en una decision humana trazable.

## Respuesta worker detectada
```text
worker_decision=
GO
summary=
Worker propone nota tecnica segura y revisable.
```

## Opciones humanas
- APPROVE: aprobar pasar a apply preview, no apply real.
- REJECT: rechazar la propuesta.
- REPAIR: pedir reparacion.
- CONTINUE: continuar investigando sin aplicar.
- DEFER: mantener bloqueado por defecto.

## Estado seguro por defecto
```text
human_decision=DEFER
apply_executed=false
auto_apply=false
remote_execution=false
git_write=false
```

## Regla
La maquina no decide. El humano decide antes de cualquier apply preview o cambio local.
