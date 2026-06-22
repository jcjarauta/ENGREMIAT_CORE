# E29 launcher actual router patch NO_APPLY

## Decision
GO_LAUNCHER_ACTUAL_ROUTER_PATCH_READY_NO_APPLY

## Target
- original: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\ENGREMIAT-LAUNCHER-ACTUAL.screen-master-candidate.latest.ps1
- readhost_line: 
106
- command_var: 
cmd
- menu_updated_lines: 
1

## Old parse errors

## New parse errors

## Checks
- source_parse: True
- candidate_parse: True
- readhost_found: True
- router_insertions: 1
- has_help_function: True
- has_help_router: True
- has_b_router: True
- has_marker: True
- keeps_m: True

## Gate para aplicar
`
AUTORIZO_APLICAR_PLANTILLA_MASTER_A_LAUNCHER_ACTUAL
`

## Next
E30_APPLY_LAUNCHER_ACTUAL_ROUTER_PATCH_WITH_GATE
