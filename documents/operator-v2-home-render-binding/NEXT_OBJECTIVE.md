# NEXT OBJECTIVE

Recomendado: ENGREMIAT_OPERATOR_V2_ACTIONS_LAB_STATUS_012

Objetivo: conectar acciones LAB no invasivas sobre la base ya creada: 13/informe/plan/estado-plan, e/estado y m/mantenimiento, usando comandos auxiliares existentes y sin tocar ENGREMIAT.ps1.

Motivo: antes de forzar auto-bind visual, ya tenemos hoja de tareas viva por comando. Ahora conviene que el wrapper/operador LAB pueda invocar esos comandos como acciones controladas.

Reglas:
- mantener ENGREMIAT.ps1 intacto;
- no auto-bind de pantalla real todavía;
- usar plan-v2, overview y home-preview-composer como fuente viva;
- todas las acciones primero en LAB/dry-run;
- si el router real no esta claro, crear alias/bridge auxiliar antes de parchear.
