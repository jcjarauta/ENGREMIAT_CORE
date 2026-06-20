---
type: card
card_id: SYSTEM_NEED_025
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Cierre y handoff de contexto
system_area: bundles
priority: Alta
risk: LOW
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: NONE
related_skill: SKILL_ESTADO_ENGREMIAT
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_025 · Cierre y handoff de contexto

## Descripcion

Preparar paquetes de continuidad para cambiar de conversacion, PC o herramienta sin perder arquitectura ni estado.

## Clasificacion

- system_area: bundles
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: NONE
- related_skill: SKILL_ESTADO_ENGREMIAT

## Entrada

estado, next, bundles y reports

## Salida esperada

continuation bundle y prompt de continuidad

## Validacion

validar que incluye estado, next, reglas y riesgos

## Evidencia

GLOBAL_IMPORT_BUNDLE y memory bundle

## Next

generar bundle de continuidad
