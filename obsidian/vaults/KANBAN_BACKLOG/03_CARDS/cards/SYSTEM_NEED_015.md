---
type: card
card_id: SYSTEM_NEED_015
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Prompt Factory local
system_area: cline
priority: Media
risk: MEDIUM
automation_level: ASSISTED
required_adapter: POWERSHELL
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_015 · Prompt Factory local

## Descripcion

Generar prompts operativos desde plan, estado y memoria sin depender de conversaciones largas.

## Clasificacion

- system_area: cline
- priority: Media
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: POWERSHELL
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

plan, estado, contexto y errores

## Salida esperada

PROMPT_NEXT, PROMPT_REPAIR y ACTIVE_PROMPT

## Validacion

validar limites, archivos permitidos y criterio GO/NO_GO

## Evidencia

prompt factory reports

## Next

actualizar prompt templates
