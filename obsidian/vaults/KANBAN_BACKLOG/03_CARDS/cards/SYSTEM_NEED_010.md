---
type: card
card_id: SYSTEM_NEED_010
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: OpenWebUI Knowledge Base
system_area: openwebui
priority: Alta
risk: LOW
automation_level: ASSISTED
required_adapter: OPENWEBUI
required_node: MAIN_PC
related_skill: SKILL_ESTADO_ENGREMIAT
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_010 · OpenWebUI Knowledge Base

## Descripcion

Organizar bundles, colecciones y skills en OpenWebUI para consulta humana y local-first.

## Clasificacion

- system_area: openwebui
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: OPENWEBUI
- required_node: MAIN_PC
- related_skill: SKILL_ESTADO_ENGREMIAT

## Entrada

GLOBAL_IMPORT_BUNDLE y bundles derivados

## Salida esperada

colecciones OpenWebUI por capa funcional

## Validacion

validar importacion manual y consulta de estado

## Evidencia

OpenWebUI skill reports

## Next

crear pack de importacion limpio
