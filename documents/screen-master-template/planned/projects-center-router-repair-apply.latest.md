# E24 apply projects-center router repair

## Status
PASS

## Applied
- target: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-master-template\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.before-e24-router-repair-20260620-210118.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\projects-center.router-repair-candidate.latest.ps1

## Checks
- target_parse_before: True
- candidate_parse: True
- target_parse_after: True
- has_backup: True
- has_repair_marker: True
- has_no_old_router_marker: True
- has_m_router: True
- has_help_router: True
- has_q_router: True
- has_common_menu: True
- has_card_function: True
- has_help_function: True
- has_cancel: True

## Manual smoke
1. Abrir INICIO > Proyectos.
2. Probar `?`: debe abrir ayuda.
3. Probar `m`: debe abrir tarjeta contextual.
4. En tarjeta probar `c`: debe cancelar.
5. Probar `q`: debe volver/salir.
6. Probar Enter vacío: debe refrescar.
7. Probar número y `b`: deben seguir funcionando.

## Next
E25_MANUAL_TEST_PROJECTS_CENTER_ROUTER_REPAIR
