---
type: card
card_id: SYSTEM_NEED_022
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: OpenClaw adapter futuro
system_area: adapters
priority: Media
risk: HIGH
automation_level: BLOCKED
required_adapter: OPENCLAW_FUTURE
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_022 · OpenClaw adapter futuro

## Descripcion

Mantener OpenClaw como adapter preparado pero diferido, sin gateway ni agente real hasta gate explicito.

## Clasificacion

- system_area: adapters
- priority: Media
- risk: HIGH
- automation_level: BLOCKED
- required_adapter: OPENCLAW_FUTURE
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

openclaw policy y contracts

## Salida esperada

ficha OpenClaw futura con limites y prerequisitos

## Validacion

validar gateway_active=false y agent_real_execution=false

## Evidencia

openclaw prepared report

## Next

mantener diferido
