# E18 apply projects-manager screen template

## Status
PASS

## Applied
- target: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-master-template\eng-projects-manager.before-e18-screen-template-20260620-204846.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\eng-projects-manager.screen-master-candidate.latest.ps1

## Checks
- target_parse_before: True
- candidate_parse: True
- target_parse_after: True
- has_backup: True
- has_screen_marker: True
- has_router_marker: True
- has_m_router: True
- has_help_router: True
- has_cancel: True
- has_route: True
- has_existing_options: True

## Manual smoke
1. Abrir PROYECTOS ACTIVOS.
2. Confirmar que salen ruta/encabezado y comandos comunes.
3. Probar `?` ayuda.
4. Probar `m` tarjeta contextual y cancelar con `c`.
5. Probar Enter refrescar.
6. Probar q salir.
7. Confirmar que numero/oN/hN/v/n siguen funcionando.

## Next
E19_MANUAL_TEST_PROJECTS_MANAGER_SCREEN_TEMPLATE
