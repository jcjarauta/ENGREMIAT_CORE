# E10Y apply clean master experimental 6

## Decision
GO_MASTER_ROUTER_CLEAN_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- Master launcher write: true
- INICIO write: false
- Operator write: false
- Adapter write: false
- Git write: false
- Worker real enabled: false
- Rollback done: false

## Checks
- stable_parse_before: 
True
- selected_parse: 
True
- stable_parse_after: 
True
- stable_has_6_experimental: 
False
- stable_has_6_route: 
False
- stable_routes_inicio: 
True
- inicio_routes_operator: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True

## Paths
- master_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT.master-router-clean-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT.before-e10y-clean-master-experimental-6-20260620-193111.ps1
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- operator: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Hashes
- before_sha256: 
ED0772333C4FE9B1F897D984D65AEAA33DFE9B8D4F3FE17BF31435EB86A63E65
- selected_sha256: 
20F64CA6E9986C2655C077D4E4AE4F1D110CAD2307ABE31E6099693B56FB3714
- backup_sha256: 
ED0772333C4FE9B1F897D984D65AEAA33DFE9B8D4F3FE17BF31435EB86A63E65
- after_sha256: 
20F64CA6E9986C2655C077D4E4AE4F1D110CAD2307ABE31E6099693B56FB3714

## Next
E10Z_CLOSE_ROUTE_NORMALIZATION_AND_STATIC_EVIDENCE
