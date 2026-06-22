# ACTIONABLE NAVIGATION CONTRACT v1

## Proposito
Convertir pantallas V1 read-only en navegacion accionable segura: seleccionar elementos, ver detalle, refrescar, volver y preparar gates sin ejecutar acciones sensibles.

## Principios
- Navegacion antes que ejecucion
- Una frontera tecnica por paso
- Read-only por defecto
- Acciones reales solo con gate
- Mantener Enter/refrescar/volver
- Sin push/fetch/merge/delete durante desarrollo local

## Pantallas incluidas
- OPERATOR_V1_HOME
- OPERATOR_V1_PROJECTS
- OPERATOR_V1_MEMORY_DOCS
- OPERATOR_V1_DATA_INTAKE
- OPERATOR_V1_HEALTH_LAUNCHERS

## Acciones permitidas
- create_contract
- create_navigation_model_readonly
- create_detail_view_readonly
- prepare_gate_text
- validate_parse_json
- commit_scoped

## Acciones bloqueadas
- push automatico
- fetch automatico
- merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard
- abrir archivos sin gate
- ejecutar smokes sin gate
- ejecutar reparaciones sin gate
- modificar datos sin gate
- modificar launchers sin gate

## Etapas previstas
- E03 CREATE_NAVIGATION_MODEL_READONLY
- E04 CREATE_DETAIL_VIEWER_READONLY
- E05 INTEGRATE_FIRST_SCREEN_ACTIONS_LOW_RISK
- E06 VALIDATE_AND_COMMIT_SCOPED
- E07 HUMAN_RETEST_AND_CLOSE_OR_NEXT_SCREEN

## Git actual
- Branch: 
main
- Head: 
7b5f91aa
- Rev sync: 
0	0
- Remote synced: 
True
- Tree clean: 
False

## NEXT
E03_CREATE_NAVIGATION_MODEL_READONLY
