# REMOTE_OLLAMA_MAIN_PC_RUNTIME

OLD-PC no instala Ollama. MAIN-PC sera el nodo de computo IA.

Para activar prueba remota segura:
1. En MAIN-PC, tener Ollama instalado y escuchando en LAN.
2. En OLD-PC, editar data/local-runtime-fix/remote-ollama-target.local.json.
3. Sustituir base_url por http://IP_MAIN_PC:11434.
4. Cambiar enabled=true y probe_allowed=true.
5. Ejecutar tools/runtime/Test-RemoteOllamaSafeProbe.ps1.

Esta etapa solo permite GET /api/tags. No permite /api/generate ni /api/chat.
