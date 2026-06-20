# E06 - RAG VALIDATION TESTS

## Instruccion de prueba
Usar qwen3:14b en Open WebUI con la Knowledge Base ENGREMIAT_CORE activada. Copiar las respuestas obtenidas para valorar si estan basadas en los documentos.

## Pregunta 1
Que es ENGREMIAT?

Respuesta esperada: debe mencionar sistema local-first, modular, economia circular, conocimiento estructurado, nodos, workers, tareas, proyectos, evidencias y decision controlada.

## Pregunta 2
Cual es el estado actual de la infraestructura?

Respuesta esperada: debe mencionar Docker, PostgreSQL, backend NestJS, Ollama, qwen3:14b, Open WebUI, chat validado y GPU.

## Pregunta 3
Cual es el roadmap de ENGREMIAT_OPENWEBUI_KNOWLEDGE_BASE_001?

Respuesta esperada: debe mencionar E01 a E07: estructura, consolidacion, contexto maestro, estado operativo, importacion, validacion RAG y cierre.

## Pregunta 4
Que reglas de desarrollo estan activas?

Respuesta esperada: debe mencionar Local First, una frontera tecnica por bloque, validar antes de avanzar, no automatizar fases no usadas manualmente, modularidad y documentacion reutilizable.

## Pregunta 5
Cual es el siguiente objetivo previsto despues de la Knowledge Base?

Respuesta esperada: ENGREMIAT_OPENWEBUI_SKILLS_001.

## Criterio PASS
PASS si 4 de 5 respuestas son correctas, concretas y basadas en documentos.

## Criterio WARN
WARN si responde de forma general pero no usa suficiente contexto documental.

## Criterio FAIL
FAIL si inventa estado, contradice readiness o no reconoce el roadmap.
