# E09 · Cline integration routes for avoiding manual Kanban handoff

## Objetivo

Actualizar la evaluación: no mirar solo extensiones Kanban Markdown, sino también integraciones Cline/Kanban/VS Code documentadas o plausibles.

## Conclusión

Obsidian puede evitar el paso manual si lo conectamos a una superficie que lea archivos Markdown o a Cline por CLI/MCP/SDK/plugins. La sincronización directa VS Code Extension ↔ Cline Kanban no debe asumirse como disponible hasta verificarla.

## Rutas

| Ruta | Estado | Reducción manual | Siguiente |
|---|---|---:|---|
| Markdown Kanban Extension | ACTIVE_TEST | Alta | Validar tablero visual |
| Cline Kanban Sidebar Chat | PARTIAL_GO | Media/Alta | Generar prompt pack |
| Cline CLI Headless | GO later | Alta | Gate de seguridad |
| Cline MCP Server | Mejor candidata arquitectura | Alta | Contrato MCP read-only |
| Cline Plugins/Hooks/Rules/Skills | Research required | Alta | Inspección local .cline |
| VS Code Extension Sync to Kanban | Not confirmed | Alta si existe | No asumir |
| Git issues / Markdown tasks bridge | Fallback fuerte | Media/Alta | Mantener |

## Decisión operativa

Seguir con dos pruebas paralelas controladas:

1. Validar visualmente Markdown Kanban ya instalado.
2. Preparar un paquete de prompt para Cline Kanban sidebar chat que pueda crear cards desde Obsidian con un solo pegado.

## Seguridad

No se escribe en Cline/Kanban. No se ejecuta Cline CLI. No se instalan más extensiones.
