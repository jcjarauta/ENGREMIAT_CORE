# CLINE KANBAN ADAPTER GUIDE

Objetivo: preparar una exportacion preview desde el board canonico ENGREMIAT hacia una posible superficie Kanban/Cline.

## Regla principal
Este adapter no escribe en la extension Kanban, no crea tareas Cline, no lanza Cline y no envia prompts. Solo genera un JSON local de preview.

## Fuente canonica
La fuente canonica sigue siendo data/, reports/, docs/, receipts/ y manifests. Kanban es una vista humana sincronizable, no el motor del sistema.

## Entradas y salidas
Entrada: data/kanban-human-control/kanban-board.json.
Salida: data/kanban-human-control/cline-kanban-export-preview.json.
Reporte: reports/kanban-human-control/e04-cline-kanban-adapter-preview-report.json.

## Acciones prohibidas
write_real_kanban_card, create_cline_task, launch_cline, send_prompt, run_worker, auto_apply, git_write y remote_inference.

## Seguridad esperada
kanban_write=False; launch_cline_task=False; cline_task_created=False; worker_real_execution=False; auto_apply=False; git_write=False; remote_inference=False.

## Siguiente etapa
E05 debe crear un gate humano para una futura escritura real, con decision=DEFER por defecto.
