# MANUAL HUMANO-MAQUINA · ENGREMIAT_INTERNAL_WORKFLOW_STANDARD_001

## Objetivo
Normalizar el trabajo interno de ENGREMIAT para proyectos, tareas, workers, inputs, outputs, evidencias, recursos, gates y adaptadores antes de integrar OpenWebUI, Ollama, OpenClaw, Cline, Kanban, Obsidian o Sheets reales.

## Principio central
ENGREMIAT gobierna. Las herramientas son adaptadores.

## Flujo canonico
IDEA -> PROJECT -> TASK -> WORKER -> INPUT -> PROCESS -> OUTPUT -> EVIDENCE -> RESOURCE -> LIBRARY_OR_ARCHIVE.

## Regla operativa
Ninguna herramienta escribe libremente. Todo pasa por JSON, schema, validator, evidence y gate humano cuando hay escritura real, agente real, red, inferencia con impacto de estado o oficializacion.

## Objetos normalizados
- PROJECT: unidad de trabajo con objetivo y cierre.
- TASK: unidad ejecutable asignada a worker.
- WORKER: humano, IA local, agente, validador o coordinador.
- INPUT: audio, PDF, DOCX, markdown, JSON, CSV, nota, fila Sheets, card Kanban o chat.
- OUTPUT: resumen, decision, documento, modulo, script, dashboard, plan, presupuesto, subvencion, manual o recurso.
- EVIDENCE: prueba trazable.
- RESOURCE: activo reutilizable.
- GATE: decision humana o controlada.

## Rutas clave
- module.json
- contracts/workflow-standard-contract.json
- contracts/operational-glossary.json
- contracts/tool-adapter-contract.json
- contracts/adapter-role-map.json
- contracts/adapter-safety-policy.json
- schemas/project.schema.json
- schemas/task.schema.json
- schemas/worker.schema.json
- schemas/resource.schema.json
- schemas/evidence.schema.json
- schemas/lifecycle-model.json
- schemas/lifecycle-status-enum.json
- schemas/human-gate-schema.json
- samples/sample-project-software.json
- samples/sample-project-grant.json
- samples/sample-project-business-plan.json
- samples/sample-audio-meeting-task.json
- tools/Invoke-WorkflowStandardValidator.ps1

## Uso humano
1. Crear o recibir una idea.
2. Convertirla en PROJECT.
3. Dividirla en TASKS.
4. Asignar WORKERS humanos o IA.
5. Adjuntar INPUTS.
6. Generar OUTPUTS.
7. Registrar EVIDENCE.
8. Revisar mediante GATE.
9. Convertir el resultado util en RESOURCE.
10. Publicar en biblioteca o archivar.

## Siguiente integracion recomendada
ENGREMIAT_TOOL_ADAPTER_GATE_001 para preparar gates especificos de OpenWebUI, Ollama, OpenClaw, Cline, Kanban, Obsidian y Sheets reales.
