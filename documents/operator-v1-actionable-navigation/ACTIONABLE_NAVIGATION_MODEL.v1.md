# ACTIONABLE NAVIGATION MODEL v1

## Proposito
Modelo read-only para convertir pantallas V1 en navegacion accionable segura.

## Politica
- Modo por defecto: READONLY
- Seleccion: numero de elemento o comando
- Refrescar: Enter vacio/refrescar
- Volver: b/q/volver
- Detalle: ver detalle readonly
- Acciones reales: solo gate humano explicito

## Pantallas
- OPERATOR_V1_HOME :: safe=[abrir_inicio, ir_proyectos, ir_memoria, ir_data_intake, ir_health, ir_v2_siguiente] :: gated=[]
- OPERATOR_V1_PROJECTS :: safe=[listar_proyectos, seleccionar_proyecto, ver_detalle_proyecto, refrescar, volver] :: gated=[abrir_carpeta_proyecto, crear_proyecto, activar_proyecto, archivar_proyecto]
- OPERATOR_V1_MEMORY_DOCS :: safe=[listar_documentos, filtrar_indices, filtrar_contratos, filtrar_evidencias, ver_detalle_documento, refrescar, volver] :: gated=[abrir_documento_externo, editar_documento, generar_indice]
- OPERATOR_V1_DATA_INTAKE :: safe=[listar_fuentes, listar_staging, listar_imports, ver_detalle_fuente, ver_detalle_staging, refrescar, volver] :: gated=[importar_fuente, modificar_staging, transformar_datos, enviar_a_sheets]
- OPERATOR_V1_HEALTH_LAUNCHERS :: safe=[listar_launchers, listar_smokes, listar_healthchecks, ver_detalle_launcher, ver_detalle_smoke, refrescar, volver] :: gated=[ejecutar_smoke, ejecutar_healthcheck, reparar_launcher, modificar_launcher]

## Integracion recomendada
Primera pantalla: OPERATOR_V1_PROJECTS. Motivo: permite probar seleccion y detalle sin abrir archivos externos ni ejecutar procesos.

## Acciones bloqueadas globales
- push_auto
- fetch_auto
- merge_auto
- delete_files
- worker_real
- api_externa
- navegador
- clipboard
- abrir_externo_sin_gate
- ejecutar_smoke_sin_gate
- ejecutar_repair_sin_gate
- modificar_archivo_sin_gate

## Git
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
E04_CREATE_DETAIL_VIEWER_READONLY
