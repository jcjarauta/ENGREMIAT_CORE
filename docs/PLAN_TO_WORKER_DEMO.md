PLAN_TO_WORKER_DEMO

Objetivo: demostrar el flujo end-to-end local desde plan tipo Sheets hasta paquete worker.

1. Preparar o exportar un plan desde Sheets como TSV/CSV.
2. Ejecutar plan-import para detectar e importar el plan.
3. Ejecutar normalizacion y validacion para generar plan-normalized.json y PLAN_IMPORT_REVIEW.md.
4. Ejecutar selector operativo para crear selected-step.json y worker-decision.json.
5. Generar worker-context.json y WORKER_PROMPT.md.
6. Publicar paquete reproducible en data/plan-to-worker/packages/.
7. Revisar dashboard local con plan-open.

Comandos utiles:
.\eng.ps1 plan-status
.\eng.ps1 plan-next
.\eng.ps1 plan-prompt
.\eng.ps1 plan-inbox
.\eng.ps1 plan-open

Limites activos: external_network=False, git_write=False, worker_real_execution=False, auto_apply=False.
