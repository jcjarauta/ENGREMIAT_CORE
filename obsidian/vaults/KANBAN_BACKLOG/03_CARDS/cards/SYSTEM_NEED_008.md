---
type: card
card_id: SYSTEM_NEED_008
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Cline proposal-only
system_area: cline
priority: Alta
risk: HIGH
automation_level: SEMI_AUTOMATED
required_adapter: CLINE
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_008 · Cline proposal-only

## Descripcion

Mantener Cline como worker de propuesta revisable, sin apply, sin git write y sin ejecucion libre.

## Clasificacion

- system_area: cline
- priority: Alta
- risk: HIGH
- automation_level: SEMI_AUTOMATED
- required_adapter: CLINE
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

prompts, task candidates y proposal contracts

## Salida esperada

flujo proposal-only con captura, normalizacion y review

## Validacion

validar que no hay source_write_by_worker ni auto_apply

## Evidencia

cline proposal reports

## Next

preparar prueba proposal-only segura
