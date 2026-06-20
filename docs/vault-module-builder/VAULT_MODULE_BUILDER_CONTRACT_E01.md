# ENGREMIAT · Vault Module Builder Contract

## Objetivo
Crear un constructor local-first que convierta decisiones humanas en espacios de trabajo Obsidian/ENGREMIAT agrupados, visibles y gobernados.

## Tipos de espacio
- `MASTER_VAULT` · Boveda maestra ENGREMIAT · grupo: `G01_CORE` · ruta: `obsidian-vault-preview/ENGREMIAT_OBSIDIAN_VAULT`
- `PROJECT_SPACE` · Project space · grupo: `G03_PROJECTS_MODULES` · ruta: `02_PROYECTOS/PROJECT_<slug>`
- `MODULE_SPACE` · Modulo ENGREMIAT relacionado · grupo: `G03_PROJECTS_MODULES` · ruta: `02_PROYECTOS/<parent>/08_RELACIONES/MODULE_<slug>`
- `RELATION_SPACE` · Relacion entre boveda/proyecto/modulo · grupo: `G04_MEMORY_VISUAL` · ruta: `<target>/08_RELACIONES/REL_<slug>`
- `WORK_SURFACE` · Superficie humana de trabajo · grupo: `G02_HUMAN_CONTROL` · ruta: `00_CONTROL_OPERATIVO/SURFACE_<slug>`

## Entradas humanas
- `name` · required=True · Nombre humano del espacio o modulo
- `intent` · required=True · Que quiere conseguir el humano
- `space_type` · required=True · 
- `parent_vault_or_project` · required=False · Boveda/proyecto padre si aplica
- `related_to` · required=False · Modulo, proyecto o grupo relacionado
- `preferred_surface` · required=False · CONTROL_HUB, GROUPED_CANVAS, PROJECT_CANVAS, PENDING_GATES, ACTIVE_CARDS, RECENT_EVIDENCE, WORKER_PROPOSALS

## Reglas
- Todo espacio debe declarar grupo oficial
- Todo project/module space debe tener index, intake/contexto, roadmap, tareas, gates, evidencias, workers/resultados y relaciones
- Todo builder empieza en preview_only=true
- Toda ejecucion real queda bloqueada por gate explicito
- Obsidian visualiza y relaciona; no ejecuta
- data/reports/dashboard siguen siendo fuente canonica
- Cada salida debe incluir decision, readiness, safety y next

## Seguridad
preview_only=true · worker_execution=false · kanban_write=false · clien_write=false · git_write=false · external_network=false

## Siguiente
E02_CREATE_MASTER_VAULT_TEMPLATE_PACKET
