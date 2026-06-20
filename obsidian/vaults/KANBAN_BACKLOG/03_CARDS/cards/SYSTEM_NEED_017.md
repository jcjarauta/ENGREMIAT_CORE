---
type: card
card_id: SYSTEM_NEED_017
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Estado y NEXT global
system_area: core
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
# SYSTEM_NEED_017 · Estado y NEXT global

## Descripcion

Mantener ESTADO_GLOBAL y NEXT_GLOBAL como entrada principal para humano, ChatGPT, Ollama y OpenWebUI.

## Clasificacion

- system_area: core
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: NONE
- related_skill: SKILL_ESTADO_ENGREMIAT

## Entrada

close reports y decisiones next

## Salida esperada

estado global breve, next y riesgos activos

## Validacion

validar consistencia con ultimos reports

## Evidencia

NEXT_GLOBAL y ESTADO_GLOBAL

## Next

sincronizar tras cada cierre
