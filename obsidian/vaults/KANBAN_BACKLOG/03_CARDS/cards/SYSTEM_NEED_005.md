---
type: card
card_id: SYSTEM_NEED_005
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Registry de skills OpenWebUI
system_area: skills
priority: Alta
risk: LOW
automation_level: ASSISTED
required_adapter: OPENWEBUI
required_node: MAIN_PC
related_skill: SKILL_CAPTURE_TO_CANDIDATE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_005 · Registry de skills OpenWebUI

## Descripcion

Mantener skills oficiales y candidatas con prompt, test, estado y evidencia PASS antes de usarlas como memoria operativa.

## Clasificacion

- system_area: skills
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: OPENWEBUI
- required_node: MAIN_PC
- related_skill: SKILL_CAPTURE_TO_CANDIDATE

## Entrada

skills oficiales, candidatas y pruebas manuales

## Salida esperada

SKILLS_INDEX, OFFICIAL_SKILLS y bundles importables

## Validacion

validar status oficial y prueba manual

## Evidencia

OPENWEBUI_SKILLS vault

## Next

preparar siguiente skill registry
