# NEXT_OBJECTIVE_CONNECT_CONTROLLED_WORKERS

Objetivo recomendado: conectar adapters controlados de workers.

Base disponible:
- Node/npm/Git/Cline listos en OLD-PC.
- Node link OLD-PC MAIN-PC documentado.
- MAIN-PC puede estar apagado hasta probe remoto.
- Remote Ollama config preparada por contrato.

Siguiente ruta:
1. Mantener Cline en modo CLI detectado, sin lanzar tareas automaticas.
2. Volver a remote Ollama solo cuando MAIN-PC este encendido.
3. Ejecutar safe probe /api/tags con gate humano.
4. No ejecutar /api/generate ni /api/chat hasta nuevo objetivo.

Nombre sugerido siguiente: ENGREMIAT_CONTROLLED_WORKER_ADAPTERS_005
