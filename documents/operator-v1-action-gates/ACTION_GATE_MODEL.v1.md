# ACTION GATE MODEL v1

## Proposito
Modelo read-only para preparar gates de acciones V1 sin ejecutar acciones reales.

## Politica
- Mode: PREPARE_ONLY
- real_execution=False
- external_open=False
- write=False
- delete=False
- clipboard=False
- browser=False
- network=False
- human_authorization_required=True
- single_execution_only=True

## Comandos globales
- gN = preparar gate del elemento N
- gate N = preparar gate del elemento N
- ? = ayuda
- Enter = refrescar
- b/q = volver

## Pantallas y gates
### OPERATOR_V1_PROJECTS
- abrir_carpeta_proyecto | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_PROJECTS__ABRIR_CARPETA_PROYECTO_SINGLE_EXECUTION
- crear_proyecto | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_PROJECTS__CREAR_PROYECTO_SINGLE_EXECUTION
- activar_proyecto | risk=HIGH | status=DRAFT | auth=AUTORIZO_PROJECTS__ACTIVAR_PROYECTO_SINGLE_EXECUTION
- archivar_proyecto | risk=HIGH | status=DRAFT | auth=AUTORIZO_PROJECTS__ARCHIVAR_PROYECTO_SINGLE_EXECUTION
### OPERATOR_V1_MEMORY_DOCS
- abrir_documento_externo | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_MEMORY_DOCS__ABRIR_DOCUMENTO_EXTERNO_SINGLE_EXECUTION
- editar_documento | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_MEMORY_DOCS__EDITAR_DOCUMENTO_SINGLE_EXECUTION
- generar_indice | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_MEMORY_DOCS__GENERAR_INDICE_SINGLE_EXECUTION
- modificar_memoria | risk=HIGH | status=DRAFT | auth=AUTORIZO_MEMORY_DOCS__MODIFICAR_MEMORIA_SINGLE_EXECUTION
### OPERATOR_V1_DATA_INTAKE
- importar_fuente | risk=HIGH | status=DRAFT | auth=AUTORIZO_DATA_INTAKE__IMPORTAR_FUENTE_SINGLE_EXECUTION
- modificar_staging | risk=HIGH | status=DRAFT | auth=AUTORIZO_DATA_INTAKE__MODIFICAR_STAGING_SINGLE_EXECUTION
- transformar_datos | risk=HIGH | status=DRAFT | auth=AUTORIZO_DATA_INTAKE__TRANSFORMAR_DATOS_SINGLE_EXECUTION
- enviar_a_sheets | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_DATA_INTAKE__ENVIAR_A_SHEETS_SINGLE_EXECUTION
- abrir_archivo_externo | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_DATA_INTAKE__ABRIR_ARCHIVO_EXTERNO_SINGLE_EXECUTION
### OPERATOR_V1_HEALTH_LAUNCHERS
- ejecutar_smoke | risk=HIGH | status=DRAFT | auth=AUTORIZO_HEALTH_LAUNCHERS__EJECUTAR_SMOKE_SINGLE_EXECUTION
- ejecutar_healthcheck | risk=HIGH | status=DRAFT | auth=AUTORIZO_HEALTH_LAUNCHERS__EJECUTAR_HEALTHCHECK_SINGLE_EXECUTION
- ejecutar_repair | risk=HIGH | status=DRAFT | auth=AUTORIZO_HEALTH_LAUNCHERS__EJECUTAR_REPAIR_SINGLE_EXECUTION
- abrir_launcher_externo | risk=MEDIUM | status=DRAFT | auth=AUTORIZO_HEALTH_LAUNCHERS__ABRIR_LAUNCHER_EXTERNO_SINGLE_EXECUTION
- modificar_launcher | risk=HIGH | status=DRAFT | auth=AUTORIZO_HEALTH_LAUNCHERS__MODIFICAR_LAUNCHER_SINGLE_EXECUTION

## Hard blocked without gate
- push
- fetch
- merge
- delete_files
- worker_real
- api_external
- browser
- clipboard
- execute_smoke
- execute_repair
- modify_file
- open_external

## NEXT
E03_CREATE_GATE_PREVIEWER_READONLY
