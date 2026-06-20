---
type: card
card_id: SYSTEM_NEED_009
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Ollama consulta local segura
system_area: ollama
priority: Alta
risk: MEDIUM
automation_level: ASSISTED
required_adapter: OLLAMA
required_node: MAIN_PC
related_skill: SKILL_ESTADO_ENGREMIAT
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_009 · Ollama consulta local segura

## Descripcion

Usar Ollama como razonador local sobre bundles limpios sin convertirlo en ejecutor ni darle contexto excesivo.

## Clasificacion

- system_area: ollama
- priority: Alta
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: OLLAMA
- required_node: MAIN_PC
- related_skill: SKILL_ESTADO_ENGREMIAT

## Entrada

bundles tematicos y policies Ollama

## Salida esperada

consultas locales controladas y respuestas resumidas

## Validacion

validar no network, no model pull no autorizado, no apply

## Evidencia

ollama readiness reports

## Next

probar pregunta de estado global
