OLLAMA_MANUAL_GATE

Estado: Ollama preparado en modo seguro.

Si falta Ollama o winget:
1. Instalar Ollama manualmente desde instalador oficial o habilitar winget.
2. Cerrar y reabrir PowerShell para refrescar PATH.
3. No descargar modelos todavía.
4. Reejecutar E03.

Reglas:
- model_download=False
- inference=False
- external_network=False en esta fase
- worker_real_execution=False
- human_gate_required=True
