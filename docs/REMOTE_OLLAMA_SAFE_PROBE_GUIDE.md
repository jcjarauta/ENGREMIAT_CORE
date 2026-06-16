# REMOTE_OLLAMA_SAFE_PROBE_GUIDE

Objetivo: preparar una prueba futura segura de Ollama remoto en MAIN-PC.

Estado actual:
- MAIN-PC puede seguir apagado.
- No se ejecuta probe en E05.
- No se permite inferencia.
- Gate enabled=false por defecto.

Endpoint futuro permitido con aprobacion humana:
- GET 
http://192.168.1.67:11434/api/tags

Bloqueado:
- /api/generate
- /api/chat
- pull de modelos
- descarga de modelos
- worker real execution
- auto_apply
- git_write
- firewall_change
- service_start

Cuando toque probar:
1. Encender MAIN-PC.
2. Confirmar que la IP sigue siendo 
192.168.1.67
.
3. Activar gate humano solo para /api/tags.
4. Ejecutar safe probe.
5. Guardar receipt.
