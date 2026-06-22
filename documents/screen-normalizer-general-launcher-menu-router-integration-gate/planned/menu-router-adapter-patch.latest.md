# E04 planned menu/router adapter patch no apply

## Decision
NO_GO_PATCH_ANCHORS_NOT_CLEAR

## Real launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Baseline planned
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.menu-router-planned.latest.ps1

## Patched planned
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.menu-router-adapter-patched.latest.ps1

## Free option
10

## Anchors
- menu_idx_0based: 
97
- switch_idx_0based: 
-1
- switch_close_idx_0based: 
-1

## Inserts
- menu_inserted: 
False
- router_inserted: 
False
- function_inserted: 
False
- planned_parse: 
False

## Backup / rollback / smoke
- backup: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\backup-plan-20260620-185422.md
- rollback: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\rollback-plan-20260620-185422.md
- smoke: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\smoke-plan-20260620-185422.md

## Rule
NO_APPLY. No se modifica el launcher real.

## Authorization required later
AUTORIZO_APLICAR_MENU_ROUTER_ADAPTER_DIFF_TRAS_REVISAR_PATRON_REAL
