---
type: operative_index
view_id: ACTIVE_CARDS
status: ready
object_type: task_card
tags:
  - engremiat/view
  - engremiat/obsidian
---
# Tarjetas activas

## Propósito
Vista operativa para objetos de tipo `task_card`.

## Filtro previsto
`status != done AND status != closed`

## Agrupación
`lane`

## Columnas
- `card_id`
- `project_id`
- `lane`
- `status`
- `priority`
- `risk`
- `gate`
- `next_action`

## Enlaces
- Especificación JSON: `C:\ENGREMIAT_CORE\obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT\06_KANBAN_TAREAS\ACTIVE_CARDS.view.json`
- Base preview: `C:\ENGREMIAT_CORE\obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT\06_KANBAN_TAREAS\ACTIVE_CARDS.base`

## Nota
Este Markdown es fallback humano. El archivo `.base` queda como preview estable, sin sintaxis experimental obligatoria.
