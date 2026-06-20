# SYSTEM_GROUPING_MODEL

## Proposito
Definir como el humano agrupa manualmente el sistema para entenderlo, priorizarlo y operarlo sin perderse.

## Enlaces
- Inicio: [[PROJECT_HOME]]
- Roadmap: [[ROADMAP_MODEL]]
- Modulos: [[MODULES_INDEX]]
- Tareas: [[TASK_MODEL]]
- Workers: [[WORKER_MODEL]]
- Gates: [[HUMAN_GATE_MODEL]]
- Evidencias: [[EVIDENCE_MODEL]]
- Resultados: [[RESULT_MODEL]]
- Decisiones: [[DECISION_MODEL]]

## Grupos manuales principales
1. Trabajo humano: decisiones, criterio, revision, validacion, comunicacion.
2. Trabajo asistido: prompts, Cline/Ollama, scripts propuestos, revision semiautomatica.
3. Trabajo automatizable: validadores, generadores, reportes, snapshots, dashboards.
4. Bloqueos: errores, riesgos, dependencias, falta de datos, gates pendientes.
5. Carga humana: bajo, medio, alto, sensible, requiere autorizacion.
6. Valor operativo: core, modulo, evidencia, interfaz humana, worker, archivo, aprendizaje.
7. Estado: idea, pendiente, preparado, en curso, validado, aplicado, cerrado, archivado.

## Tabla minima de agrupacion
| Item | Grupo | Tipo trabajo | Prioridad | Dependencias | Bloqueo | Carga humana | Estado | Siguiente |
|---|---|---|---|---|---|---|---|---|
| {{ITEM}} | {{GRUPO}} | humano/asistido/automatizable | alta/media/baja | {{DEPENDENCIAS}} | {{BLOQUEO}} | baja/media/alta | {{ESTADO}} | {{SIGUIENTE}} |

## Reglas
- Agrupar antes de automatizar.
- Separar lo operativo de lo historico.
- Separar decisiones humanas de ejecucion tecnica.
- No mezclar backlog, evidencia y resultado en el mismo nodo.
- Cada grupo debe poder verse en Obsidian y convertirse en tarea.

## Uso en vista grafica
Este modelo debe enlazar nodos por funcion, no solo por carpeta. Sirve para decidir que se muestra, que se oculta y que se convierte en modulo.

## Candidatos recuperados de control
- score 16 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_PROJECT_CONTROL\PROJECT_GRAPH_VIEW_SELECTOR.md
- score 12 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\LAB_STATUS.md
- score 12 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\SIMULATION_LAB_V1_CLOSE.md
- score 12 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\PROJECT_HOME.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\SIM_PROJECT_20260619-144124_HUMAN_REVIEW.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\SIMULATION_CYCLE.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_PROJECT_CONTROL\PROJECT_STATUS.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\OBJECT_MODEL_REGISTRY.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\CYCLE_RUN_001.md
- score 11 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\00_LAB_CONTROL\CYCLE_RUN_001_FINAL_STATUS.md
- score 8 | ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL\02_ROADMAPS\ROADMAP_MODEL.md
- score 8 | BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_CONTROL\project.template.json
