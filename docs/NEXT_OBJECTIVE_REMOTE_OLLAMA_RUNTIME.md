# NEXT_OBJECTIVE_REMOTE_OLLAMA_RUNTIME

Objetivo siguiente: retornar a ENGREMIAT_LOCAL_RUNTIME_FIX_004 E04 Remote Ollama.

Condición para avisar al humano:
Encender MAIN-PC solo cuando vayamos a ejecutar probe remoto controlado.

Secuencia futura:
1. Encender MAIN-PC.
2. Validar que sigue en IP 
192.168.1.67
 o actualizar endpoint.
3. Activar solo safe probe /api/tags.
4. No ejecutar /api/generate ni /api/chat hasta nuevo gate.

Límites:
- OLD-PC no instala Ollama.
- OLD-PC no descarga modelos.
- MAIN-PC ejecutará IA solo con gate humano.
