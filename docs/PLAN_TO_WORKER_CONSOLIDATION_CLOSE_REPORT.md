PLAN_TO_WORKER_CONSOLIDATION_CLOSE_REPORT

Objective: 
ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002
Status: CONSOLIDATED_READY
Readiness: 100
Decision: GO
Next: 
CONNECT_CONTROLLED_WORKER_ADAPTERS

Capas consolidadas:
- Input layer estable
- Canonical output consumible
- Worker adapters preparados para Cline, Ollama, OpenClaw y generic
- System output consumible por ENGREMIAT
- Graph output para vision humana
- Dashboard humano consolidado
- Fake worker loop validado
- Smoke end-to-end local validado

Rutas clave:
- data/plan-to-worker/input/imported-input.json
- data/plan-to-worker/output/canonical-work-items.json
- data/plan-to-worker/output/canonical-worker-queue.json
- data/plan-to-worker/adapters/common/worker-request.schema.json
- data/plan-to-worker/adapters/common/worker-response.schema.json
- data/plan-to-worker/adapters/fake/fake-worker-response.json
- data/plan-to-worker/output/system/engremiat-action.json
- data/plan-to-worker/output/system/evidence-manifest.json
- data/plan-to-worker/output/graph/graph.json
- dashboard/plan-to-worker/index.html
- dashboard/plan-to-worker/graph.html

Limites mantenidos:
- external_network=False
- git_write=False
- worker_real_execution=False
- auto_apply=False
- human_gate_required=True

Criterio: listo para preparar conexion controlada de adapters reales, empezando por Cline/Ollama con gate humano y sin apply automatico.
