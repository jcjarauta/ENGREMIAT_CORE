# HEALTH LAUNCHERS SCREEN CONTRACT v1

## Proposito
Crear pantalla V1 Health Launchers para operar launchers, validadores, smokes, healthchecks, reports recientes y siguientes acciones humanas bajo gobierno V2.

## Primera iteracion
HEALTH_LAUNCHERS_SCREEN_READONLY_V1: pantalla read-only versionada y testeable.

## Secciones
- Resumen de salud
- Launchers detectados
- Validadores y smokes
- Reports recientes
- Estado Git
- Siguiente accion humana
- Acciones bloqueadas
- Gobierno V2 disponible

## Clasificacion inicial
- LAUNCHER / launchers e inicio
- HEALTH / healthchecks y doctor
- SMOKE / tests, checks y validaciones
- REPAIR / repair, fix, restore
- STATUS / reports, state, status

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
- ejecutar reparaciones sin gate
- ejecutar smokes sensibles sin gate
- modificar launchers sin gate

## Etapas previstas
- E03 CREATE_HEALTH_LAUNCHERS_SCREEN_READONLY
- E04 GATE_LAUNCHER_INTEGRATION_HEALTH_LAUNCHERS
- E05 APPLY_HEALTH_LAUNCHERS_INTEGRATION_WITH_AUTH
- E06 VALIDATE_AND_COMMIT_SCOPED
- E07 HUMAN_RETEST_AND_CLOSE

## Git actual
- Branch: 
main
- Head: 
ca44ce5a
- Rev sync: 
0	10
- Tree clean: 
False

## NEXT
E03_CREATE_HEALTH_LAUNCHERS_SCREEN_READONLY
