---
type: card
card_id: SYSTEM_NEED_013
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Visual Memory operativa
system_area: visual_memory
priority: Alta
risk: MEDIUM
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_013 · Visual Memory operativa

## Descripcion

Conectar eventos, dashboards, mapas, decisiones, gates y evidencias para continuidad humano-maquina.

## Clasificacion

- system_area: visual_memory
- priority: Alta
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: NONE
- related_skill: NONE

## Entrada

ENGREMIAT_MEMORY, reports y eventos JSONL

## Salida esperada

VISUAL_MEMORY vault con mapas y estado navegable

## Validacion

validar eventos, mapas y dashboard

## Evidencia

visual memory reports

## Next

actualizar mapa de memoria
