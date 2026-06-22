# E30 apply launcher actual router patch

## Status
PASS

## Applied
- target: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-master-template\ENGREMIAT-LAUNCHER-ACTUAL.before-e30-screen-template-20260620-211110.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\ENGREMIAT-LAUNCHER-ACTUAL.screen-master-candidate.latest.ps1

## Checks
- target_parse_before: True
- candidate_parse: True
- target_parse_after: True
- has_backup: True
- has_help_function: True
- has_help_router: True
- has_b_router: True
- has_marker: True
- keeps_q: True
- keeps_m: True

## Manual smoke
1. Abrir launcher actual.
2. Probar `?`: debe abrir ayuda.
3. Probar `b`: debe volver/salir igual que q.
4. Probar `q`: debe seguir funcionando.
5. Probar `m`: debe seguir funcionando.
6. Enter vacío debe refrescar si ya lo hacía.

## Next
E31_MANUAL_TEST_LAUNCHER_ACTUAL_SCREEN_TEMPLATE
