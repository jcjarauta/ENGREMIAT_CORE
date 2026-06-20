# PROMPT_VALIDATE_SYSTEM_NEED_004_BUNDLE_V2_DRAFT

Actua como analista de arquitectura ENGREMIAT local-first. Valida el draft final v2 de bundles para SYSTEM_NEED_004.

Contexto:

- SYSTEM_NEED_001 ya esta validado como dependencia base.
- La auditoria Obsidian ya dio GO_READONLY_AUDIT_PASS.
- El objetivo activo es SYSTEM_NEED_004: bundles limpios para Ollama/OpenWebUI.
- No debes recomendar de nuevo auditar HOME/ESTADO/MASTER_INDEX.

Responde:

1. decision
2. si el draft final v2 es suficiente
3. si el orden de importacion es correcto
4. si falta contexto imprescindible
5. riesgos concretos
6. primera accion segura despues de validar el draft
7. next_block PowerShell exacto

Restricciones:

- analysis_only=true
- git=false
- network=false
- external_execution=false
- worker_real_execution=false
- auto_apply=false
- no modificar bundles originales
- no ejecutar workers
- no cambiar arquitectura sin gate humano
- next_block no puede quedar vacio

Formato:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_REPAIR
draft_v2_sufficient: true|false
import_order_ok: true|false
missing_context:
risks:
first_safe_action:
do_not_do_yet:
next_block: ENGREMIAT_SYSTEM_NEED_004_...
```
