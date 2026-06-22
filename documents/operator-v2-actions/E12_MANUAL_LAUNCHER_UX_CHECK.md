# E12 Manual Launcher UX Check

Estado: READY_FOR_HUMAN_TEST
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Parse OK: SI
Actions minimal bind: 
True
Actions observer bind: 
True

## Probar manualmente
1. Enter vacío debe refrescar/redibujar sin romper.
2. e debe mantener comportamiento legacy de estado/entrada actual.
3. m debe mantener mantenimiento/menu actual.
4. ? debe mostrar ayuda o comportamiento legacy.
5. b/q debe volver/salir.

## Criterio PASS
Si todos responden sin error y el flujo visual sigue igual o mejor, cerrar ACTIONS_003.

## Criterio FAIL
Si aparece error, copiar salida y reparar solo el punto afectado.
