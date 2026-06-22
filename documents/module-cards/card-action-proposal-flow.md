# Card Action Proposal Flow

## Estado
PASS

## Principio
Una tarjeta `PROPOSED` no ejecuta. Solo puede generar una propuesta de accion con gate humano.

## Acciones permitidas
- review: leer y validar.
- approve_proposal: aprobar para blueprint, sin ejecutar.
- block: bloquear con razon.
- convert_to_module_blueprint: crear blueprint de modulo.
- convert_to_task_blueprint: crear blueprint de tarea.

## Acciones prohibidas
- ejecutar worker
- modificar codigo directamente
- git commit/push
- red/API/navegador/AutoHotkey
- borrar archivos

## Siguiente
E99B_CREATE_CARD_ACTION_PROPOSAL_SCHEMA