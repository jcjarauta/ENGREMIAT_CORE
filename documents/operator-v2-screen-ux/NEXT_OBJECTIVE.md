# NEXT OBJECTIVE

ID: ENGREMIAT_OPERATOR_V2_COMMAND_FEEDBACK_006

Objetivo: mejorar feedback real de comandos del Operador V2 sin romper el flujo legacy.

Prioridades:
1. Enter vacio = refrescar/redibujar pantalla.
2. ? = ayuda contextual por pantalla.
3. m = mantenimiento o mensaje PENDIENTE claro si todavia no esta implementado.
4. e = estado compacto o mensaje PENDIENTE claro.
5. Comando desconocido = feedback visible: Comando no reconocido. Usa ? para ayuda.
6. b/q = volver/salir consistente.

Regla tecnica: read-only discovery primero, contrato COMMAND_FEEDBACK, adapter dry-run, guarded write solo si el punto exacto esta claro.
