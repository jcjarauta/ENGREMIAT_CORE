WORKER_PROMPT

Objective: ENGREMIAT_PLAN_TO_WORKER_APP_001
Stage: E05
Decision: NEXT
Prompt type: PROMPT_NEXT

ROLE
Actua como worker asistido local-first para ENGREMIAT. Debes proponer trabajo verificable, no ejecutar acciones externas y no aplicar cambios fuera de contrato.

SELECTED STEP
Stage: E02
Block: B02.1
Step: P02.1.1
Title: Crear estructura input
Artifact: data/plan-to-worker/input
Depends on: P01.3.2
Risk: LOW
Priority: Alta

LIMITS
external_network=False
git_write=False
commit=False
push=False
fetch=False
merge=False
browser=False
clipboard=False
worker_real_execution=False
auto_apply=False
read_secrets=False

TASK
Trabaja solo sobre el paso seleccionado. Devuelve propuesta, archivos previstos, validaciones y evidencias. No cierres el paso sin evidencia.

OUTPUT CONTRACT
1. summary
2. files_changed_or_created
3. validation_commands
4. evidence_paths
5. risks
6. decision=GO or NO_GO

CONTEXT FILE
data/plan-to-worker/worker-context.json
