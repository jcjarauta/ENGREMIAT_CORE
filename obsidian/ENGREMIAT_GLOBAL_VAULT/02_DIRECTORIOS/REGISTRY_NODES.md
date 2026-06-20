---
type: registry
registry_id: REGISTRY_NODES
status: ACTIVE
tags: [registry, nodes, capabilities]
---
# REGISTRY_NODES

| node_id | type | status | capabilities | limits | risk |
|---|---|---|---|---|---|
| MAIN_PC | COMPUTE_NODE | ACTIVE | ollama,openwebui,cline,kanban,scripts | gates_para_acciones_reales | MEDIUM |
| LEGACY_PC | SUPPORT_NODE | AVAILABLE_LIMITED | backup,consulta,operacion_ligera | terminal_sensible,no_cargas_pesadas | MEDIUM |
| RASPBERRY | BACKUP_NODE | PLANNED | backup,nodo_ligero | no_inferencia_pesada | LOW |
| MOBILE | HUMAN_INTERFACE_NODE | PLANNED | revision,decision,telegram_futuro | no_ejecucion_pesada | LOW |
| OLLAMA_LOCAL | AI_SERVICE | ACTIVE | razonamiento_local | no_acciones_externas | LOW |
| OPENWEBUI_LOCAL | RAG_INTERFACE | ACTIVE | conversaciones_dedicadas,bundles | no_ejecucion_real | LOW |
| CLINE_LOCAL | DEV_ASSISTANT | PLANNED | desarrollo_asistido | requiere_gates | MEDIUM |
| KANBAN_LOCAL | HUMAN_CONTROL_SURFACE | PLANNED | tarjetas,prioridades,flujo | no_ejecucion_directa | LOW |
