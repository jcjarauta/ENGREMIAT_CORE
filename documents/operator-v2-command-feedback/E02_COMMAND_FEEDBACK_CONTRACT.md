# E02 Command Feedback Contract

Estado: PASS
Target: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\COMMAND_FEEDBACK.json
Backup: 
Schema: 
ENGREMIAT_COMMAND_FEEDBACK_V1
Commands: 
6

## Comandos canonicos
- refresh.empty_enter -> REFRESH_CURRENT_SCREEN | Pantalla refrescada.
- help.context -> SHOW_CONTEXT_HELP | Ayuda contextual: usa Enter para refrescar, b/q para volver/salir, m para mantenimiento y e para estado.
- maintenance.menu -> OPEN_MAINTENANCE_OR_PENDING | Mantenimiento pendiente de conectar en esta pantalla.
- status.compact -> SHOW_COMPACT_STATUS_OR_PENDING | Estado compacto pendiente de conectar en esta pantalla.
- back.quit -> BACK_OR_QUIT_LEGACY | Volviendo o saliendo segun flujo legacy.
- unknown.fallback -> UNKNOWN_COMMAND_FEEDBACK | Comando no reconocido. Usa ? para ayuda.

## Politica
- DRY_RUN_FIRST.
- Preserve legacy flow.
- No side effects in adapter.
- Guarded write solo cuando el punto exacto este claro.

## Siguiente
E03 crear lector COMMAND_FEEDBACK y smoke read-only.
