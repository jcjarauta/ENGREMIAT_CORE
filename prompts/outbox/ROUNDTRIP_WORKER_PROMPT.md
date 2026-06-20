# ROUNDTRIP_WORKER_PROMPT

Actua como worker asistido de ENGREMIAT. No ejecutes cambios. No hagas apply. No uses red. No hagas git write.

OBJETIVO
Preparar una propuesta para E39 Human Decision Console: una consola humana para revisar propuestas, ver riesgos, aprobar/rechazar y dejar evidencia, sin ejecutar acciones sensibles.

CONTEXTO
- E36 Human Start Screen cerrado.
- E37 Command Hub Unificado Real preparado en eng.ps1.
- Comandos humanos disponibles: start, status, next, readiness, gates, artifacts, context, errors, docs, dashboard, mvp-open, prompt, inbox, review, approve.

TAREA
Devuelve una propuesta estructurada en JSON o Markdown con: objetivo, pantallas mínimas, campos de decision, gates, evidencias, riesgos, criterios GO/NO_GO y pasos para E39.

LIMITES
- No aplicar cambios.
- No escribir código operativo.
- No ejecutar comandos.
- No usar red externa.
- No git write.
- La respuesta será importada como propuesta, no ejecutada.

SALIDA ESPERADA
Una propuesta clara y accionable para que el humano decida el diseño de E39.
