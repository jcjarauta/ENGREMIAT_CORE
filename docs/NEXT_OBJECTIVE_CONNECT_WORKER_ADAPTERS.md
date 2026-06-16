NEXT_OBJECTIVE_CONNECT_WORKER_ADAPTERS

Objetivo recomendado: CONNECT_CONTROLLED_WORKER_ADAPTERS

Proposito: conectar Cline, Ollama y OpenClaw de forma progresiva usando los endpoints de archivo ya preparados, manteniendo fake-worker como referencia de contrato.

Orden recomendado:
1. Revalidar fake worker como baseline.
2. Conectar Cline en modo manual/copiar prompt, sin apply automatico.
3. Conectar Ollama local en modo request/response controlado, sin red externa.
4. Preparar OpenClaw solo como adapter posterior con gate humano.
5. Validar cada respuesta contra worker-response.schema.json.
6. No permitir apply, commit, push ni red externa sin autorizacion explicita.

Gate minimo antes de worker real:
- worker-request.json valido
- worker-response.schema.json valido
- policy worker_real_execution=False hasta autorizacion
- evidence-manifest actualizado
- dashboard muestra estado y riesgos
