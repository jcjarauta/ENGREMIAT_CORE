# E22 apply projects-center screen template

## Status
PASS

## Applied
- target: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-master-template\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.before-e22-screen-template-20260620-205656.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\projects-center.screen-master-candidate.latest.ps1

## Checks
- target_parse_before: True
- candidate_parse: True
- target_parse_after: True
- has_backup: True
- has_screen_marker: True
- has_router_marker: True
- has_m_router: True
- has_help_router: True
- has_q_router: True
- has_cancel: True
- has_route: True
- has_common_menu: True
- has_existing_options: True

## Manual smoke
1. Abrir INICIO > Proyectos.
2. Confirmar que se ve: numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar.
3. Probar `?` ayuda.
4. Probar `m` tarjeta contextual y cancelar con `c`.
5. Probar Enter refrescar.
6. Probar `q` volver/salir.
7. Confirmar que número y `b` siguen funcionando.

## Next
E23_MANUAL_TEST_PROJECTS_CENTER_SCREEN_TEMPLATE
