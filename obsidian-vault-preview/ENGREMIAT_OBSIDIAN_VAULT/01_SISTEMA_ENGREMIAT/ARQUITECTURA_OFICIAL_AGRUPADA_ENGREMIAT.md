---
type: official_architecture
status: adopted_preview
architecture_id: engremiat-official-grouped-architecture.v1
tags:
  - engremiat/architecture
  - engremiat/obsidian
  - engremiat/groups
---
# ENGREMIAT · Arquitectura oficial agrupada

## Decisión
Adoptar la arquitectura agrupada en Obsidian como base oficial preview para ordenar la visión global de ENGREMIAT.

## Principio
Cada bóveda, módulo o proyecto debe nacer ubicable, agrupable, relacionable, visible y gobernado.

## Grupos oficiales
- `G01_CORE` · **ENGREMIAT CORE** — Fuente canonica, contratos, reports, manifests, dashboards y estado reconstruible
- `G02_HUMAN_CONTROL` · **CONTROL HUMANO** — Panel humano, decisiones, gates, revisiones y autorizaciones
- `G03_PROJECTS_MODULES` · **PROYECTOS Y MODULOS** — Project spaces, module spaces y lineas de trabajo agrupables
- `G04_MEMORY_VISUAL` · **MEMORIA VISUAL** — Obsidian, Canvas, grafo, enlaces, indices y vistas
- `G05_TASKS_KANBAN` · **TAREAS Y KANBAN PREVIEW** — Tarjetas, backlog, lanes, prioridades y trabajo humano visible
- `G06_WORKERS_EXECUTION_PREVIEW` · **WORKERS Y EJECUCION PREVIEW** — Worker packets, dry-runs, propuestas y ejecucion bloqueada por gate
- `G07_EVIDENCE_RESULTS` · **EVIDENCIAS Y RESULTADOS** — Pruebas, receipts, reports de cierre, readiness y resultados
- `G08_SYSTEM_EVOLUTION` · **EVOLUCION DEL SISTEMA** — Backlog de arquitectura, decisiones estrategicas, modulos futuros y aprendizaje

## Reglas de adopción
- Todo modulo/proyecto debe pertenecer a un grupo oficial
- Todo modulo/proyecto debe tener index, intake/contexto, roadmap/proposito, tareas, gates, evidencias, resultados y relaciones
- Obsidian es memoria visual y navegacion, no motor de ejecucion
- Dashboard operativo decide intencion y superficie de trabajo
- Worker, Kanban/Cline write, Git y red siguen bloqueados por gate explicito
- La fuente canonica sigue siendo data/reports/exports/dashboard/manifests
- Cada cierre debe proponer siguiente objetivo y actualizar memoria visual

## Rol de cada capa
- ENGREMIAT CORE: fuente canónica.
- Obsidian: memoria visual y relaciones.
- Dashboard: decisión humana.
- Kanban preview: visión de tareas.
- Ollama: propuesta local.
- Workers: futuro bajo gate.

## Siguiente
Cerrar esta etapa y definir el siguiente objetivo operativo.
