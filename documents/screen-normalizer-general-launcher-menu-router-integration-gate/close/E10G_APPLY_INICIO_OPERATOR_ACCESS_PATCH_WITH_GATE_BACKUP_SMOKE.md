# E10G apply INICIO operator access patch

## Decision
GO_INICIO_OPERATOR_ACCESS_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- INICIO write: true
- Operator write: false
- Adapter write: false
- Git write: false
- Rollback done: false

## Checks
- inicio_parse_before: 
True
- selected_parse: 
True
- inicio_parse_after: 
True
- menu5_enabled: 
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
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT-INICIO-NORMALIZED.operator-access-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10g-operator-access-20260620-191053.ps1
- operator: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Hashes
- before_sha256: 
B1516AF2F864539649472507A6C26A9D02DCA56CBBB0854D49D9AC471CAE0BDF
- selected_sha256: 
F1F6EDD55AC784CAC5227919A54EDC143F84419FC274CF12179FB34C54953A99
- backup_sha256: 
B1516AF2F864539649472507A6C26A9D02DCA56CBBB0854D49D9AC471CAE0BDF
- after_sha256: 
F1F6EDD55AC784CAC5227919A54EDC143F84419FC274CF12179FB34C54953A99

## Next
E10H_MANUAL_TEST_INICIO_5_TO_OPERATOR_10_NO_AUTOSTART
