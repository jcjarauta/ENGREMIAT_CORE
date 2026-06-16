NEXT_OBJECTIVE_CONTROLLED_WORKERS

Objetivo recomendado: CONNECT_CONTROLLED_WORKER_ADAPTERS

Propósito: conectar workers reales de forma progresiva y gobernada usando la toolchain preparada y la app Plan To Worker ya consolidada.

Orden recomendado:
1. Revalidar fake worker baseline.
2. Revalidar worker-request.schema.json y worker-response.schema.json.
3. Conectar Cline primero en modo manual/file endpoint, sin auto-apply.
4. Conectar Ollama local después, sin descarga/inferencia pesada sin gate.
5. Mantener OpenClaw diferido hasta tener Cline/Ollama estables.
6. Registrar cada respuesta en evidence-manifest y dashboard.
7. No permitir commit, push, fetch, merge, auto-apply ni worker real sin autorización explícita.

Primer bloque recomendado:
E01 — Hardening de scripts reales y fake-worker baseline.

Criterio de seguridad: prepared > validated > simulated > human gate > controlled execution.
