---
type: operative_index
view_id: PENDING_GATES
status: ready
object_type: gate
tags:
  - engremiat/view
  - engremiat/obsidian
---
# Gates pendientes

## Propósito
Vista operativa para objetos de tipo `gate`.

## Filtro previsto
`authorization_status = NOT_GRANTED OR decision = DEFER`

## Agrupación
`sensitive_action`

## Columnas
- `gate_id`
- `project_id`
- `status`
- `decision`
- `authorization_status`
- `sensitive_action`

## Enlaces
- Especificación JSON: `C:\ENGREMIAT_CORE\obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT\00_CONTROL_OPERATIVO\PENDING_GATES.view.json`
- Base preview: `C:\ENGREMIAT_CORE\obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT\00_CONTROL_OPERATIVO\PENDING_GATES.base`

## Nota
Este Markdown es fallback humano. El archivo `.base` queda como preview estable, sin sintaxis experimental obligatoria.
