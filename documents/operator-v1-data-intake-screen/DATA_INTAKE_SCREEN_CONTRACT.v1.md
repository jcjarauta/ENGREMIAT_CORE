# DATA INTAKE SCREEN CONTRACT v1

## Proposito
Crear pantalla V1 Data Intake para operar fuentes, staging, imports, CSV/TSV/JSON, reports recientes y siguientes acciones humanas bajo gobierno V2.

## Primera iteracion
DATA_INTAKE_SCREEN_READONLY_V1: pantalla read-only versionada y testeable.

## Secciones
- Resumen de entrada
- Directorios de intake
- Archivos de datos
- Reports recientes
- Estado Git
- Siguiente accion humana
- Acciones bloqueadas
- Gobierno V2 disponible

## Clasificacion inicial
- SOURCE / fuentes/raw/input
- STAGING / staging/STG
- IMPORT / importacion/ingest
- SHEET / sheets/csv/tsv
- API / api/open/collector

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
- importar datos sin gate
- modificar staging sin gate
- transformar datos sin gate

## Etapas previstas
- E03 CREATE_DATA_INTAKE_SCREEN_READONLY
- E04 GATE_LAUNCHER_INTEGRATION_DATA_INTAKE
- E05 APPLY_DATA_INTAKE_INTEGRATION_WITH_AUTH
- E06 VALIDATE_AND_COMMIT_SCOPED
- E07 HUMAN_RETEST_AND_CLOSE

## Git actual
- Branch: 
main
- Head: 
1868462c
- Rev sync: 
0	8
- Tree clean: 
False

## NEXT
E03_CREATE_DATA_INTAKE_SCREEN_READONLY
