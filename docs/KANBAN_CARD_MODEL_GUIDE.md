# KANBAN CARD MODEL GUIDE

Objetivo: definir una tarjeta Kanban humana para ENGREMIAT sin convertir Kanban en fuente canonica.

## Principio
ENGREMIAT controla el proyecto; Kanban muestra el estado humano. La fuente canonica sigue siendo data/, reports/, docs/, receipts/ y manifests.

## Estados visuales
- BACKLOG: pendiente de preparar.
- READY: preparado para trabajar.
- GATED: requiere decision humana.
- RUNNING: en curso.
- REVIEW: pendiente de revision humana.
- DEFERRED: aplazado.
- DONE: completado con evidencia.
- BLOCKED: bloqueado por error o falta de autorizacion.

## Campos minimos
card_id, objective, stage, block, step, title, description, status, risk, gate, worker, evidence, next_action y safety.

## Seguridad por defecto
kanban_write=False; cline_task_created=False; worker_real_execution=False; auto_apply=False; git_write=False; remote_inference=False.

## Uso
Cada tarjeta debe apuntar a evidencia canonica y mostrar la siguiente accion humana recomendada. No debe ejecutar workers, crear tareas reales ni aplicar cambios por si misma.
