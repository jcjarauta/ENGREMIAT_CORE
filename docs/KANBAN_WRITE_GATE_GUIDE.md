# KANBAN WRITE GATE GUIDE

Objetivo: preparar un gate humano para una futura escritura real en Kanban sin ejecutarla durante ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007.

## Estado por defecto
decision=DEFER.

## Regla principal
No se crea ni sincroniza ninguna tarjeta real en Kanban durante E05. Solo se deja preparada una request preview y una validacion que bloquea escritura real.

## Autorizacion futura requerida
Para permitir escritura real en un objetivo posterior, debe existir una frase humana explicita y una request concreta. Frase propuesta: AUTORIZO_KANBAN_WRITE_REAL_CARD_FOR_SPECIFIC_REQUEST.

## Acciones prohibidas ahora
write_real_kanban_card, create_cline_task, launch_cline, send_prompt, run_worker, auto_apply, git_write, remote_inference y ui_automation.

## Seguridad esperada
kanban_write=False; real_kanban_sync=False; launch_cline_task=False; cline_task_created=False; worker_real_execution=False; auto_apply=False; git_write=False; remote_inference=False; ui_automation=False.

## Siguiente etapa
E06 cerrara 007 y preparara el siguiente objetivo: ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008.
