# PROMPT_FACTORY_CONTRACT

## Propósito
Convertir el plan de desarrollo de ENGREMIAT en prompts operativos para Cline/Ollama sin depender de ChatGPT ni navegador.

## Límites obligatorios
- external_network=False
- git_write=False por defecto
- commit=False por defecto
- push=False
- fetch=False
- merge=False
- apply_sensible=False sin gate humano
- worker_real_execution=False hasta autorización explícita
- browser=False
- clipboard=False por defecto

## Todo prompt generado debe incluir
- rol del worker
- objetivo, etapa, bloque y paso
- dependencia validada
- archivos permitidos
- archivos prohibidos
- riesgo
- validaciones obligatorias
- evidencia requerida
- formato de salida WorkerOutput
- criterio GO/NO_GO
- next

## WorkerOutput obligatorio
El worker debe devolver decision, summary, files_touched, tests_executed, risks, evidence y next.

## Regla
Si Cline/Ollama no puede validar, debe responder NO_GO y explicar evidencia faltante.
