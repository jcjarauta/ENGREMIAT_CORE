# PROJECTS SCREEN CONTRACT v1

## Proposito
Crear pantalla V1 Proyectos para operar proyectos detectados, activos/historicos, rutas, reports relacionados y siguiente accion humana bajo gobierno V2.

## Primera iteracion
PROJECTS_SCREEN_READONLY_V1: pantalla read-only versionada y testeable.

## Secciones
- Resumen operativo
- Proyectos detectados
- Archivos/reportes relacionados
- Estado Git
- Siguiente accion humana
- Acciones bloqueadas
- Gobierno V2 disponible

## Acciones permitidas
- readonly_audit
- create_contract
- create_screen_readonly
- prepare_launcher_gate
- apply_launcher_gate_with_auth
- validate_and_commit_scoped
- human_retest

## Acciones bloqueadas
- push automatico
- fetch automatico
- merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard
- modificar proyectos sin gate

## Etapas previstas
- E03 CREATE_PROJECTS_SCREEN_READONLY
- E04 GATE_LAUNCHER_INTEGRATION_PROJECTS
- E05 APPLY_PROJECTS_INTEGRATION_WITH_AUTH
- E06 VALIDATE_AND_COMMIT_SCOPED
- E07 HUMAN_RETEST_AND_CLOSE

## Git actual
- Branch: 
main
- Head: 
71579f30
- Rev sync: 
0	4
- Tree clean: 
False

## NEXT
E03_CREATE_PROJECTS_SCREEN_READONLY
