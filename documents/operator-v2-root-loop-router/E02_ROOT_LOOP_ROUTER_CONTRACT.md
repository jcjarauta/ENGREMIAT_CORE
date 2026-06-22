# E02 Root Loop Router Contract

Estado: PASS
Target: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_LOOP_ROUTER.json
Backup: 
Schema: 
ENGREMIAT_ROOT_LOOP_ROUTER_V1
Routes: 
11

## Regla clave
No volver a integrar feedback como observer posterior a Read-Host. Todo feedback real debe vivir dentro del switch/router principal.

## Routes
- root.option.1 -> OPEN_OPERATOR_V2 | Abriendo operador.
- root.option.2 -> OPEN_PROJECTS | Abriendo proyectos.
- root.option.3 -> OPEN_MEMORY_DOCS | Abriendo memoria y documentacion.
- root.option.4 -> OPEN_DATA_INTAKE | Abriendo Data Intake.
- root.option.5 -> OPEN_HEALTH_LAUNCHERS | Abriendo Health launchers.
- root.refresh -> REFRESH_ROOT_SCREEN | Pantalla refrescada.
- root.help -> SHOW_ROOT_HELP | Ayuda: 1 operador, 2 proyectos, 3 memoria, 4 data intake, 5 health, m mantenimiento, b/q salir.
- root.maintenance -> OPEN_MAINTENANCE | Mantenimiento pendiente de conectar en el router root.
- root.status -> SHOW_COMPACT_STATUS | Estado compacto pendiente de conectar en el router root.
- root.quit -> QUIT_OR_BACK | Saliendo o volviendo segun flujo legacy.
- root.unknown -> UNKNOWN_COMMAND | Comando no reconocido. Usa ? para ayuda.

## Siguiente
E03 crear lector ROOT_LOOP_ROUTER y smoke dry-run.
