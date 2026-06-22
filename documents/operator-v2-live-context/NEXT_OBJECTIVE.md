# NEXT OBJECTIVE

Recomendado: ENGREMIAT_OPERATOR_V2_HOME_RENDER_BINDING_011

Objetivo: localizar el punto exacto de render de la home de Operador V2 y enlazar Show-EngOperatorV2LiveContextOverviewPanel como bloque superior de pantalla, usando guarded write y sin tocar ENGREMIAT.ps1.

Reglas:
- no parchear por regex de texto visible del menu;
- usar contrato/plantilla ya preparado;
- mantener comandos auxiliares plan-v2 y overview;
- validar render manual antes de hacer bind automatico;
- si el punto de render no es claro, mantener LAB_READY y cerrar.
