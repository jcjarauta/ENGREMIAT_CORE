# NEXT OBJECTIVE

ID: ENGREMIAT_OPERATOR_V2_ROOT_LOOP_ROUTER_007

Objetivo: aislar y normalizar el bucle interactivo del launcher/root antes de integrar feedback real de comandos.

Motivo: COMMAND_FEEDBACK_006 demostro que un observer posterior a Read-Host puede romper el flujo interactivo si imprime o evalua input fuera del router principal.

Prioridades:
1. Descubrir estructura exacta del bucle Read-Host/switch del launcher.
2. Crear contrato ROOT_LOOP_ROUTER.json.
3. Crear router dry-run que decida accion y feedback sin side effects.
4. Preparar diff minimo para integrar feedback dentro del switch correcto, no como observer externo.
5. Mantener rollback facil y smoke de launcher.

Regla: read-only primero, guarded write despues, no observers que escriban salida fuera del bucle principal.
