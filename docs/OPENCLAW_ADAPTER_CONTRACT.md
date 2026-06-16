OPENCLAW_ADAPTER_CONTRACT

Objective: 
ENGREMIAT_OPEN_SOURCE_TOOLCHAIN_BOOTSTRAP_003
Stage: E06
Status: DEFERRED_PREPARATION_ONLY

Rol previsto: OpenClaw queda definido como gateway/adapter futuro para canales, agentes o flujos externos, pero no se instala ni se ejecuta en esta fase.

Modo operativo permitido ahora:
- Preparar contrato local.
- Validar que existe request.json de OpenClaw si fue generado por Plan To Worker.
- Exigir worker-response.schema.json para cualquier respuesta futura.
- Mantener fake-worker como baseline antes de activar agentes reales.

Bloqueos activos:
- install_executed=False
- external_network=False
- gateway_active=False
- agent_real_execution=False
- worker_real_execution=False
- auto_apply=False
- git_write=False
- commit=False
- push=False
- fetch=False
- merge=False

Gate futuro minimo:
1. Revalidar fake worker.
2. Revalidar request OpenClaw.
3. Revisar riesgos humanos.
4. Autorizar instalacion/ejecucion de forma explicita.
5. Validar respuesta contra worker-response.schema.json.
