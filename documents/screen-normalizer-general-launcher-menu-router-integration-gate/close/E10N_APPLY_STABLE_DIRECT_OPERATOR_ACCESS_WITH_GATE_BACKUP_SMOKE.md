# E10N apply stable direct operator access

## Decision
GO_STABLE_DIRECT_OPERATOR_ACCESS_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- Stable launcher write: true
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
- menu6_visible: 
True
- route_present: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True

## Paths
- stable_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT.stable-launcher-direct-operator-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT.before-e10n-stable-direct-operator-access-20260620-191835.ps1
- operator: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Hashes
- before_sha256: 
20F64CA6E9986C2655C077D4E4AE4F1D110CAD2307ABE31E6099693B56FB3714
- selected_sha256: 
49C164C14405762317CEE28F6BDAB1A84D11B779668AF7915636C3740DFE4AA4
- backup_sha256: 
20F64CA6E9986C2655C077D4E4AE4F1D110CAD2307ABE31E6099693B56FB3714
- after_sha256: 
49C164C14405762317CEE28F6BDAB1A84D11B779668AF7915636C3740DFE4AA4

## Next
E10O_MANUAL_TEST_STABLE_6_TO_OPERATOR_10_NO_AUTOSTART
