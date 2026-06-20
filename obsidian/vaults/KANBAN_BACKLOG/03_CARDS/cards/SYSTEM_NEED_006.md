---
type: card
card_id: SYSTEM_NEED_006
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Governance de gates humanos
system_area: core
priority: Alta
risk: HIGH
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_006 · Governance de gates humanos

## Descripcion

Centralizar reglas de decision humana para cualquier accion sensible como worker real, apply, git, red, OpenClaw o escritura Kanban real.

## Clasificacion

- system_area: core
- priority: Alta
- risk: HIGH
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: NONE
- related_skill: NONE

## Entrada

gates existentes, policies y manuales

## Salida esperada

GATES_AND_SECURITY y HUMAN_AUTHORIZATIONS actualizados

## Validacion

validar que no hay accion real sin APPROVE explicito

## Evidencia

gate reports y governance docs

## Next

crear indice de gates activos
