# V1 SAFE BUILD CONTRACT v1

## Proposito
Construir V1 de forma segura usando V2 como capa de gobierno.

## Primer objetivo
NORMALIZAR_INICIO_OPERADOR_V1: convertir Inicio operador V1 en una pantalla util con estado operativo real, proyectos, modulos, pendientes, siguiente accion y enlaces V2.

## Regla principal
V2 gobierna y audita; V1 opera el sistema diario.

## Acciones permitidas
- readonly_audit
- create_contract
- create_screen_readonly
- prepare_launcher_gate
- apply_launcher_gate_with_auth
- validate_and_commit_scoped

## Acciones bloqueadas
- push automatico
- fetch automatico
- merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard
- reescritura total no gated

## Etapas previstas
- E03 CREATE_V1_HOME_SCREEN_READONLY
- E04 GATE_LAUNCHER_INTEGRATION_V1_HOME
- E05 APPLY_V1_HOME_INTEGRATION_WITH_AUTH
- E06 VALIDATE_AND_COMMIT_SCOPED
- E07 HUMAN_RETEST_AND_CLOSE

## Git actual
- Branch: 
main
- Head: 
8902743f
- Rev sync: 
0	1
- Tree clean: 
True

## NEXT
E03_CREATE_V1_HOME_SCREEN_READONLY
