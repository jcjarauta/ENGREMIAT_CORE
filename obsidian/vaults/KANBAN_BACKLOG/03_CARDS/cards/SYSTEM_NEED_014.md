---
type: card
card_id: SYSTEM_NEED_014
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Plan to Worker como puente
system_area: adapters
priority: Media
risk: MEDIUM
automation_level: ASSISTED
required_adapter: POWERSHELL
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_014 · Plan to Worker como puente

## Descripcion

Ordenar el flujo plan, seleccion de paso, prompt worker, inbox, evidencia y decision humana.

## Clasificacion

- system_area: adapters
- priority: Media
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: POWERSHELL
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

plan-normalized, selected-step y worker-context

## Salida esperada

paquete worker reproducible y dashboard plan-to-worker

## Validacion

validar que worker_real_execution=false por defecto

## Evidencia

plan-to-worker reports

## Next

conectar con Kanban Backlog
