# CONSUMABLE CARD BRIDGE MANUAL

## Identidad
Esta etapa consolida un puente de tarjetas consumibles para ENGREMIAT.

## Decisión
El Backlog visual nativo de Cline/Kanban no se usa todavía como fuente de verdad ni como destino de escritura automática.

## Modelo validado
- Fuente de verdad: tarjetas markdown locales.
- Vista humana: ORCHESTRATION_BOARD.html.
- Review/orquestación: sesión madre de Cline/Kanban.
- Consumo por Cline: prompts inline por lotes pequeños.
- Automatización nativa Kanban: disabled.
- Escritura en Kanban nativo: disabled.

## Resultado validado
- 25 tarjetas iniciales KANBAN-SEED-0001 a KANBAN-SEED-0025 creadas.
- Refrescador local validado.
- Generador de prompts inline validado.
- Lotes 001 a 005 revisados por Cline/Kanban.
- Cline/Kanban funciona mejor con contenido inline o sesión madre estable que con lectura de archivos creados después del snapshot.

## Función puente futura
Este sistema servirá como formato intermedio cuando se conecten OpenWebUI, Ollama y Obsidian.

## Flujo recurrente
1. El sistema detecta una necesidad, capacidad, bloqueo o nuevo proyecto.
2. Se convierte en tarjeta markdown consumible.
3. El refrescador actualiza índice, manifiesto y tablero HTML.
4. El generador crea lote inline para Cline/Kanban.
5. El humano revisa en la sesión madre.
6. Solo con autorización explícita se convierte una tarjeta en acción real.

## Archivos clave
- docs/kanban-backlog/seed-25/*.md
- docs/kanban-backlog/seed-25/INDEX.md
- docs/kanban-backlog/seed-25/seed-25-manifest.json
- docs/kanban-backlog/seed-25/ORCHESTRATION_BOARD.html
- tools/kanban-local/Refresh-KanbanLocalBacklog.ps1
- tools/kanban-local/New-ClineInlineBatchPrompt.ps1
- docs/kanban-backlog/cline-inline-batches/*.md

## Regla principal
Kanban/Cline es espacio de Review y orquestación humana. La fuente de verdad del backlog sigue siendo local y legible por humanos.

## Siguiente paso recomendado
Construir el modelo de refresco recurrente: needs/capabilities/projects -> consumable cards -> board -> inline batch.
