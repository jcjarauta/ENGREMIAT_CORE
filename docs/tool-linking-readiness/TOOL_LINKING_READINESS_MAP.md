# TOOL LINKING READINESS MAP

## Objetivo
Definir qué falta para empezar a vincular herramientas reales alrededor de ENGREMIAT sin romper la arquitectura local-first.

## Decisión
ENGREMIAT_CORE sigue siendo la fuente de verdad. Las herramientas externas alimentan el core mediante contratos, inbox readonly, tarjetas consumibles, gates y revisión humana.

## Estado global
READY_TO_START_SAFE_TOOL_LINKING_PREP

## Herramientas

### ENGREMIAT_CORE
- role: source_of_truth_gates_cards_state
- current_status: READY
- real_link_status: LOCAL_READY
- allowed_now: read_write_local_artifacts
- blocked_now: none_inside_workspace
- required_next: keep_as_core_control_layer

### OpenWebUI
- role: conversation_model_workspace
- current_status: CONCEPT_READY
- real_link_status: NOT_CONNECTED
- allowed_now: file_drop_summary_only
- blocked_now: api_call_real_browser_automation_execution
- required_next: define_export_format_or_readonly_drop_folder

### OpenClaw
- role: middle_layer_gateway_skill_router
- current_status: CONCEPT_READY
- real_link_status: NOT_CONNECTED
- allowed_now: skill_packet_draft_file_drop_only
- blocked_now: gateway_real_dm_api_external_actions
- required_next: build_skill_packet_for_readonly_intake

### Obsidian
- role: durable_memory_vault
- current_status: EXPORT_GATE_READY
- real_link_status: WAITING_VAULT_PATH
- allowed_now: export_candidate_pack_preview
- blocked_now: vault_write_without_path_and_gate
- required_next: provide_vault_path_then_apply_gate_if_authorized

### Cline_Kanban
- role: human_review_orchestration
- current_status: INLINE_REVIEW_READY
- real_link_status: PARTIAL_LIMITS_KNOWN
- allowed_now: inline_batch_review_same_session
- blocked_now: native_kanban_write_file_snapshot_assumptions
- required_next: keep_review_layer_not_source_of_truth

### Ollama
- role: local_worker_analysis_generation
- current_status: PLANNED
- real_link_status: NOT_CONNECTED_IN_THIS_FLOW
- allowed_now: none
- blocked_now: real_inference_until_adapter_gate
- required_next: build_readonly_worker_output_to_card_adapter

## Lo que falta antes de vincular real
1. Crear skill packet OpenClaw para generar JSON compatible con readonly intake.
2. Definir ruta real de vault Obsidian.
3. Decidir si OpenWebUI exportará por archivo, API o copia manual controlada.
4. Mantener Cline/Kanban solo como review inline.
5. Crear healthcheck de puertos/rutas/herramientas antes de cualquier integración real.

## Siguiente paso recomendado
BUILD_OPENCLAW_SKILL_PACKET_FOR_READONLY_INTAKE
