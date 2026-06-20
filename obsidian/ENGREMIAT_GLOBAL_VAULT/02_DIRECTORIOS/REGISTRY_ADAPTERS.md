---
type: registry
registry_id: REGISTRY_ADAPTERS
status: ACTIVE
tags: [registry, adapters, risk/model]
---
# REGISTRY_ADAPTERS

| adapter_id | tool | status | risk | allowed_actions | blocked_actions | requires_gate |
|---|---|---|---|---|---|---|
| OBSIDIAN_ADAPTER | Obsidian | ACTIVE_DESIGN | LOW | organizar,navegar,editar_markdown | ejecucion_externa | false |
| OPENWEBUI_ADAPTER | OpenWebUI | ACTIVE_DESIGN | LOW | consulta_rag,generacion_controlada,captura | ejecucion_real | false |
| KANBAN_ADAPTER | Kanban | ACTIVE_DESIGN | LOW | visualizar_priorizar_tarjetas | ejecucion_real | false |
| CLINE_ADAPTER | Cline | PLANNED | MEDIUM | desarrollo_asistido_con_gate | autoapprove_sin_control | true |
| OLLAMA_ADAPTER | Ollama | ACTIVE_DESIGN | LOW | razonamiento_local | acciones_externas | false |
| OPENCLAW_ADAPTER | OpenClaw | FUTURE | HIGH | gateway_futuro_con_gates_fuertes | ejecucion_sin_gate | true |
| POWERSHELL_ADAPTER | PowerShell | ACTIVE | MEDIUM | materializacion_local_controlada | red_git_remoto_sin_autorizacion | true |
