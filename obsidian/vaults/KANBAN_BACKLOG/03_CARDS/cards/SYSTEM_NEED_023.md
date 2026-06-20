---
type: card
card_id: SYSTEM_NEED_023
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Controlled Apply reusable
system_area: core
priority: Alta
risk: HIGH
automation_level: SEMI_AUTOMATED
required_adapter: POWERSHELL
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_023 · Controlled Apply reusable

## Descripcion

Estandarizar scope, gate, dry-run, execution plan, receipt, postcheck y cierre para cualquier apply controlado.

## Clasificacion

- system_area: core
- priority: Alta
- risk: HIGH
- automation_level: SEMI_AUTOMATED
- required_adapter: POWERSHELL
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

controlled-action-template y instances

## Salida esperada

plantilla reusable de accion controlada

## Validacion

validar gate APPROVE + human_confirmation + execution_allowed

## Evidencia

controlled action reports

## Next

crear indice de acciones controladas
