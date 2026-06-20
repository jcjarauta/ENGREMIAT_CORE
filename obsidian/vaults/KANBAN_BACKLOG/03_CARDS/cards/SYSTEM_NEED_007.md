---
type: card
card_id: SYSTEM_NEED_007
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Worker adapters gobernados
system_area: adapters
priority: Alta
risk: HIGH
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_007 · Worker adapters gobernados

## Descripcion

Ordenar Cline, Ollama, OpenWebUI y OpenClaw como adapters con contratos, limites y receipts, no como autoridad del sistema.

## Clasificacion

- system_area: adapters
- priority: Alta
- risk: HIGH
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

manuales worker, adapter contracts y policies

## Salida esperada

WORKERS_AND_ADAPTERS vault con fichas y contratos

## Validacion

validar flags auto_apply=false, git_write=false, remote_execution=false

## Evidencia

controlled-worker reports

## Next

crear mapa de adapters
