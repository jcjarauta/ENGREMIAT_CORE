# REMOTE_OLLAMA_MAIN_PC_GUIDE

Objetivo: usar MAIN-PC como nodo Ollama remoto y OLD-PC solo como puesto de desarrollo/control.

Reglas:
- No instalar Ollama en OLD-PC.
- No descargar modelos en OLD-PC.
- No ejecutar inferencia desde OLD-PC en esta etapa.
- Preparar endpoint remoto MAIN-PC con gate humano.

Flujo recomendado:
1. Preparar MAIN-PC con Ollama.
2. Configurar MAIN-PC para escuchar en LAN solo si se autoriza.
3. Crear data/local-runtime-fix/remote-ollama-target.local.json en OLD-PC.
4. Validar solo GET /api/tags.
5. No llamar /api/generate hasta etapa de worker remoto controlado.

Siguiente paso ENGREMIAT: E04_B04_REMOTE_OLLAMA_CONFIG_AND_SAFE_PROBE.
