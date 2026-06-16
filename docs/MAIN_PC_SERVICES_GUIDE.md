# MAIN_PC_SERVICES_GUIDE

Objetivo: preparar servicios remotos de MAIN-PC por contrato, sin activarlos todavía.

Estado actual:
- MAIN-PC puede estar apagado.
- OLD-PC mantiene contrato y gates.
- No se abre firewall.
- No se inicia servicio remoto.
- No se ejecuta Ollama.
- No se llama /api/generate ni /api/chat.

Servicios futuros previstos:
- health: http://MAIN-PC:8787/health
- Ollama tags: http://MAIN-PC:11434/api/tags
- worker status: http://MAIN-PC:8787/workers/status

Orden recomendado cuando MAIN-PC vuelva a encenderse:
1. Validar IP/hostname.
2. Activar solo health/probe si hay gate humano.
3. Probar endpoint con timeout corto.
4. Preparar Ollama tags.
5. No permitir inferencia hasta objetivo posterior.

MAIN-PC actual registrado:
- host: 
DESKTOP-PVRVE56
- ip: 
192.168.1.67
