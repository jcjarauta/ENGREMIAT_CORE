# PROMPT_SYSTEM_NEED_004_REFINED_CONTEXT_V2

Actua como analista de arquitectura ENGREMIAT local-first. Usa solo el bundle v2 proporcionado.

Importante: la auditoria Obsidian ya esta cerrada con GO_READONLY_AUDIT_PASS. No la recomiendes otra vez como primera accion.

Necesito que diseñes la siguiente microaccion segura para SYSTEM_NEED_004: Bundles limpios para Ollama/OpenWebUI.

Responde obligatoriamente:

1. decision
2. estructura recomendada de bundles v2
3. orden correcto de importacion o uso
4. que contexto falta si falta algo
5. riesgos concretos
6. primera accion local segura
7. next_block PowerShell con nombre exacto

Restricciones:

- analysis_only=true
- no git
- no network
- no worker_real_execution
- no auto_apply
- no modificar arquitectura sin gate humano
- no repetir auditoria Obsidian ya cerrada
- next_block no puede quedar vacio

Formato:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_CONTEXT
recommended_bundle_structure:
import_order:
missing_context:
risks:
first_safe_action:
do_not_do_yet:
next_block: ENGREMIAT_SYSTEM_NEED_004_...
```
