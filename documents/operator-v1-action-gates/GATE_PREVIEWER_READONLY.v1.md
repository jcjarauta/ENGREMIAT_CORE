# GATE PREVIEWER READONLY v1

## Script
tools/operator-v1/operator-v1-gate-previewer-readonly.ps1

## Proposito
Mostrar gates preparados sin ejecutar acciones reales.

## Politica
- Mode: PREPARE_ONLY
- real_execution=False
- external_open=False
- write=False
- delete=False
- clipboard=False
- browser=False
- network=False
- single_execution_only=True

## Smoke
- Screen: 
OPERATOR_V1_GATE_PREVIEWER_READONLY
- Policy: 
PREPARE_ONLY
- Gate id: 
sample_projects_open_folder_gate
- Risk: 
MEDIUM
- Authorization: 
AUTORIZO_SAMPLE_PROJECTS_OPEN_FOLDER_GATE_SINGLE_EXECUTION

## NEXT
E04_INTEGRATE_PROJECTS_GATE_PREPARE_ONLY
