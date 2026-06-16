# PROMPT_NEXT - ENGREMIAT WORKER TASK

## ROL
Actúa como worker local controlado para ENGREMIAT usando Cline/Ollama. Trabaja SOLO sobre el paso indicado y devuelve salida verificable.

## OBJETIVO ACTIVO
- objective_id: ENGREMIAT_CORE_MVP_001
- stage_id: E01
- block_id: B01.1
- step_id: P01.1.1
- step_name: Crear CORE_MVP_CONTRACT

## DESCRIPCIÓN DEL PASO
Generar contrato local del MVP con entidades Need, Task, MatchProposal, Offer, Acceptance y Evidence.

## DEPENDENCIA VALIDADA
- dependency: NONE

## ARTEFACTO ESPERADO
- artifact: CORE_MVP_CONTRACT.md
- format: Markdown

## CONTEXTO REAL
- active_objective: ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001
- active_stage: E06
- active_step: P06.3.2
- memory_status: .\eng.ps1 memory-status
- memory_sync: .\eng.ps1 memory-sync
- dashboard: ENGREMIAT_MEMORY/dashboard/memory/index.html

## LÍMITES DE SEGURIDAD
- external_network=False
- git_write=False
- commit=False
- push=False
- fetch=False
- merge=False
- browser=False
- clipboard=False
- apply_sensible=False sin gate humano explícito
- Si falta evidencia o no puedes validar, responde NO_GO.

## ARCHIVOS PERMITIDOS
- data/prompt-factory/**
- tools/prompt-factory/**
- reports/prompt-factory/**
- docs/prompt-factory/**

## ARCHIVOS PROHIBIDOS
- .git/**
- node_modules/**
- backend/node_modules/**
- cualquier secreto, token o credencial
- cambios fuera del objetivo actual sin autorización humana

## VALIDACIÓN OBLIGATORIA
- crear o actualizar el artefacto esperado
- generar reporte JSON local
- no usar red externa
- no escribir git
- explicar pruebas ejecutadas
- si algo falla, devolver NO_GO con causa y evidencia faltante

## FORMATO DE SALIDA WORKEROUTPUT
Devuelve una respuesta con estos campos:
`json
{
  "worker_id": "cline_or_ollama",
  "task_id": "P01.1.1",
  "decision": "GO|NO_GO|REQUEST_CHANGES|BLOCKED",
  "summary": "...",
  "files_touched": [],
  "tests_executed": [],
  "risks": [],
  "evidence": [],
  "validation_report": "...",
  "external_network": false,
  "git_write": false,
  "next": "..."
}
`"
# PROMPT_NEXT - ENGREMIAT WORKER TASK  ## ROL Actúa como worker local controlado para ENGREMIAT usando Cline/Ollama. Trabaja SOLO sobre el paso indicado y devuelve salida verificable.  ## OBJETIVO ACTIVO - objective_id: ENGREMIAT_CORE_MVP_001 - stage_id: E01 - block_id: B01.1 - step_id: P01.1.1 - step_name: Crear CORE_MVP_CONTRACT  ## DESCRIPCIÓN DEL PASO Generar contrato local del MVP con entidades Need, Task, MatchProposal, Offer, Acceptance y Evidence.  ## DEPENDENCIA VALIDADA - dependency: NONE  ## ARTEFACTO ESPERADO - artifact: CORE_MVP_CONTRACT.md - format: Markdown  ## CONTEXTO REAL - active_objective: ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001 - active_stage: E06 - active_step: P06.3.2 - memory_status: .\eng.ps1 memory-status - memory_sync: .\eng.ps1 memory-sync - dashboard: ENGREMIAT_MEMORY/dashboard/memory/index.html  ## LÍMITES DE SEGURIDAD - external_network=False - git_write=False - commit=False - push=False - fetch=False - merge=False - browser=False - clipboard=False - apply_sensible=False sin gate humano explícito - Si falta evidencia o no puedes validar, responde NO_GO.  ## ARCHIVOS PERMITIDOS - data/prompt-factory/** - tools/prompt-factory/** - reports/prompt-factory/** - docs/prompt-factory/**  ## ARCHIVOS PROHIBIDOS - .git/** - node_modules/** - backend/node_modules/** - cualquier secreto, token o credencial - cambios fuera del objetivo actual sin autorización humana  ## VALIDACIÓN OBLIGATORIA - crear o actualizar el artefacto esperado - generar reporte JSON local - no usar red externa - no escribir git - explicar pruebas ejecutadas - si algo falla, devolver NO_GO con causa y evidencia faltante  ## FORMATO DE SALIDA WORKEROUTPUT Devuelve una respuesta con estos campos: `json {   "worker_id": "cline_or_ollama",   "task_id": "P01.1.1",   "decision": "GO|NO_GO|REQUEST_CHANGES|BLOCKED",   "summary": "...",   "files_touched": [],   "tests_executed": [],   "risks": [],   "evidence": [],   "validation_report": "...",   "external_network": false,   "git_write": false,   "next": "..." } += "
# PROMPT_NEXT - ENGREMIAT WORKER TASK  ## ROL Actúa como worker local controlado para ENGREMIAT usando Cline/Ollama. Trabaja SOLO sobre el paso indicado y devuelve salida verificable.  ## OBJETIVO ACTIVO - objective_id: ENGREMIAT_CORE_MVP_001 - stage_id: E01 - block_id: B01.1 - step_id: P01.1.1 - step_name: Crear CORE_MVP_CONTRACT  ## DESCRIPCIÓN DEL PASO Generar contrato local del MVP con entidades Need, Task, MatchProposal, Offer, Acceptance y Evidence.  ## DEPENDENCIA VALIDADA - dependency: NONE  ## ARTEFACTO ESPERADO - artifact: CORE_MVP_CONTRACT.md - format: Markdown  ## CONTEXTO REAL - active_objective: ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001 - active_stage: E06 - active_step: P06.3.2 - memory_status: .\eng.ps1 memory-status - memory_sync: .\eng.ps1 memory-sync - dashboard: ENGREMIAT_MEMORY/dashboard/memory/index.html  ## LÍMITES DE SEGURIDAD - external_network=False - git_write=False - commit=False - push=False - fetch=False - merge=False - browser=False - clipboard=False - apply_sensible=False sin gate humano explícito - Si falta evidencia o no puedes validar, responde NO_GO.  ## ARCHIVOS PERMITIDOS - data/prompt-factory/** - tools/prompt-factory/** - reports/prompt-factory/** - docs/prompt-factory/**  ## ARCHIVOS PROHIBIDOS - .git/** - node_modules/** - backend/node_modules/** - cualquier secreto, token o credencial - cambios fuera del objetivo actual sin autorización humana  ## VALIDACIÓN OBLIGATORIA - crear o actualizar el artefacto esperado - generar reporte JSON local - no usar red externa - no escribir git - explicar pruebas ejecutadas - si algo falla, devolver NO_GO con causa y evidencia faltante  ## FORMATO DE SALIDA WORKEROUTPUT Devuelve una respuesta con estos campos: `json {   "worker_id": "cline_or_ollama",   "task_id": "P01.1.1",   "decision": "GO|NO_GO|REQUEST_CHANGES|BLOCKED",   "summary": "...",   "files_touched": [],   "tests_executed": [],   "risks": [],   "evidence": [],   "validation_report": "...",   "external_network": false,   "git_write": false,   "next": "..." } += 
GO solo si el artefacto existe, la validación local pasa y la evidencia queda registrada. NO_GO si no puedes demostrarlo.

## NEXT
Después de completar este paso, deja indicado el siguiente paso lógico y la evidencia generada.
