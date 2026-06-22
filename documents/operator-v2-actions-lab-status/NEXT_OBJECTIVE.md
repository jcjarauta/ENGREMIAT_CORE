# NEXT OBJECTIVE

Recomendado: ENGREMIAT_OPERATOR_V2_MAINTENANCE_ACTIONS_LAB_014

Objetivo: sustituir el placeholder de mantenimiento por un menu LAB seguro con acciones readonly/controladas:
- ver salud de Operador V2;
- ver ultimos reports;
- ver backups recientes;
- validar comandos vivos;
- mostrar rutas principales;
- preparar cierre/commit scoped cuando toque, sin ejecutarlo automaticamente si no se autoriza.

Reglas:
- no tocar ENGREMIAT.ps1;
- no tocar ScreenEngine;
- mantener todo en wrapper/router LAB;
- readonly por defecto;
- sin git automatico en este objetivo salvo cierre explicito posterior;
- mantener plan-v2 y home preview sincronizados.
