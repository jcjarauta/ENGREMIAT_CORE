# CLINE TASK CREATION GATE GUIDE

Objective: ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008.

## Proposito
Preparar el gate humano para crear la primera tarea real de Cline en modo proposal-only.

## Estado por defecto
decision=DEFER.

## Regla principal
Sin autorizacion humana explicita no se crea tarea Cline real, no se lanza Cline y no se envia prompt.

## Frase futura de autorizacion
AUTORIZO_CLINE_REAL_PROPOSAL_TASK_NO_APPLY_FOR_SPECIFIC_REQUEST

## Alcance permitido si se autoriza en una etapa posterior
Crear una unica tarea Cline real desde el prompt preview ya validado, solo para obtener una propuesta revisable.

## Acciones prohibidas ahora
launch_cline, create_cline_task, send_prompt, run_worker, auto_apply, apply_executed, source_write_by_worker, git_write, git_commit, git_push, remote_inference y ui_automation.

## Flags obligatorios
proposal_only=True; human_review_required=True; cline_task_created=False; launch_cline_task=False; prompt_sent=False; worker_real_execution=False; auto_apply=False; apply_executed=False; source_write_by_worker=False; git_write=False; git_commit=False; git_push=False; remote_inference=False; ui_automation=False.

## Siguiente etapa
E04 comprobara preflight y solo podra crear tarea real si existe autorizacion humana especifica.
