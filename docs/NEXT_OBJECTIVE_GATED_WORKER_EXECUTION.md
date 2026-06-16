# NEXT_OBJECTIVE_GATED_WORKER_EXECUTION

Objetivo recomendado: primera ejecución worker real con aprobación humana.

Nombre sugerido:
ENGREMIAT_GATED_WORKER_EXECUTION_006

Precondiciones:
- Revisar controlled-worker-adapters-manifest.json.
- Crear request real pequeño y reversible.
- Crear human gate decision APPROVE explícito solo para una acción.
- Mantener auto_apply=false.
- Mantener git_write=false salvo gate separado.

Ruta segura recomendada:
1. Ejecutar primero Cline con tarea mínima de lectura o propuesta, no apply.
2. Registrar response y receipt.
3. Validar evidencia.
4. Solo después valorar apply controlado.

Ollama remoto:
- Encender MAIN-PC solo cuando se vaya a probar /api/tags.
- No usar /api/generate ni /api/chat todavía.
