# MENU / ROUTER INTEGRATION DIFF - NO APLICADO

package: ENGREMIAT_SCREEN_NORMALIZER_GENERAL_LAUNCHER_MENU_ROUTER_INTEGRATION_GATE_001
stage: E01_AUDIT_MENU_ROUTER_PATTERN_AND_PREPARE_MINIMAL_DIFF_NO_APPLY
created_at: 2026-06-20T18:50:28

launcher: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
adapter: C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1
decision: NO_GO_PATTERN_NOT_CLEAR
proposed_option: 9

## Anchors
- menu_anchor_line: 
- menu_anchor_text: 
- switch_start_line: 
- router_anchor_line: 
- router_anchor_text: 

## Menu insertion
``powershell
Write-Host ' [9] Adapter subpantallas normalizadas'
``

## Router insertion
``powershell
    '9' {
      & powershell -NoProfile -ExecutionPolicy Bypass -File 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1'
      continue
    }
``

## Candidate
- planned: C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT-LAUNCHER-ACTUAL.menu-router-planned.latest.ps1
- planned_parse_ok: False

## Backup previsto
- Copiar launcher real antes de escribir.

## Rollback previsto
- Restaurar backup si parse o smoke falla.