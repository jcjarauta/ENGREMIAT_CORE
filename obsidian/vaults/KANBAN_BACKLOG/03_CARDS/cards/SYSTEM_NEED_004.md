---
type: card
card_id: SYSTEM_NEED_004
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Bundles limpios para Ollama
system_area: ollama
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
# SYSTEM_NEED_004 · Bundles limpios para Ollama

## Descripcion

Separar el contexto global en bundles tematicos pequeños para que Ollama y OpenWebUI consulten sin ruido.

## Clasificacion

- system_area: ollama
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: OPENWEBUI
- required_node: MAIN_PC
- related_skill: SKILL_ESTADO_ENGREMIAT

## Entrada

boveda global, manuales y registries

## Salida esperada

bundles por capa: global, reglas, kanban, skills, workers, modulos y next

## Validacion

validar que cada bundle no contiene instrucciones de ejecucion real

## Evidencia

GLOBAL_OVERVIEW_BUNDLE y derivados

## Next

probar consulta en OpenWebUI
