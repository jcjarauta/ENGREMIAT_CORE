---
type: card
card_id: SYSTEM_NEED_002
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Backlog vivo de necesidades
system_area: kanban
priority: Alta
risk: MEDIUM
automation_level: ASSISTED
required_adapter: KANBAN
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_002 · Backlog vivo de necesidades

## Descripcion

Convertir necesidades, bloqueos y mejoras recurrentes en tarjetas vivas dentro de KANBAN_BACKLOG.

## Clasificacion

- system_area: kanban
- priority: Alta
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: KANBAN
- required_node: NONE
- related_skill: NONE

## Entrada

reports, errores, decisiones NEXT y aportes humanos

## Salida esperada

tarjetas SYSTEM_NEEDS clasificadas por area, prioridad, riesgo y automatizacion

## Validacion

validar 25 tarjetas, indices y bundle de backlog

## Evidencia

SYSTEM_NEEDS_INDEX y AUTOANALYSIS_REPORT

## Next

revisar prioridades humanas
