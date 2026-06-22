# NEXT OBJECTIVE

ID: 
ENGREMIAT_OPERATOR_V2_COMMAND_FEEDBACK_INSIDE_WRAPPER_009

Objetivo: integrar feedback de comandos dentro del wrapper LAB para probar mensajes de ayuda, estado, mantenimiento y comandos desconocidos sin tocar ENGREMIAT.ps1.

Motivo: COMMAND_FEEDBACK_006 ya preparo contrato y adapter, pero no era seguro integrarlo como observer en el launcher raiz. ROOT_WRAPPER_008 crea ahora una frontera segura para probarlo.

Reglas:
- No modificar ENGREMIAT.ps1.
- No convertir wrapper en entrada principal todavia.
- Mantener todo en dry-run o feedback local.
- Probar primero m, e, ?, Enter, unknown y rutas legacy 1..5 como simulacion.
- Cerrar con comparacion visual y decision humana antes de promocionar.

Primer paso recomendado: E01 leer COMMAND_FEEDBACK existente y generar adapter wrapper-feedback no invasivo.
