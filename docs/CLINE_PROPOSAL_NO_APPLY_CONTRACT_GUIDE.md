# CLINE PROPOSAL NO APPLY CONTRACT GUIDE

Objective: ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008.

## Proposito
Preparar el contrato minimo para que Cline pueda crear una propuesta revisable sin aplicar cambios.

## Regla principal
Cline puede proponer, pero no aplicar. El humano revisa antes de cualquier objetivo posterior de apply.

## Acciones prohibidas en E01
launch_cline, create_cline_task, send_prompt, run_worker, auto_apply, write_source_files_by_worker, git_write, git_commit, git_push, remote_inference y ui_automation.

## Salida esperada de una futura tarea
summary, target_context, affected_files, proposed_changes, proposed_diff_or_patch, risks, tests_or_validation, evidence, open_questions y recommended_human_decision.

## Flags obligatorios
proposal_only=True; human_review_required=True; cline_task_created=False; launch_cline_task=False; prompt_sent=False; worker_real_execution=False; auto_apply=False; apply_executed=False; source_write_by_worker=False; git_write=False; git_commit=False; git_push=False; remote_inference=False; ui_automation=False.

## Siguiente etapa
E02 seleccionara una tarjeta candidata desde la superficie Kanban 007 y preparara un prompt preview, sin crear tarea real todavia.
