# E12 Manual Operator V2 Legend Check

Estado: READY_FOR_HUMAN_TEST
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
Root launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Legend expected: 
[b/q] volver | m = mantenimiento | ? = ayuda | Enter = refrescar
Parse OK: SI

## Probar ahora
1. Abrir operador V2 desde launcher raiz con opcion 1 si aparece launcher raiz.
2. Confirmar que la pantalla OPERADOR V2 muestra: 
[b/q] volver | m = mantenimiento | ? = ayuda | Enter = refrescar
3. Confirmar que Enter refresca sin error.
4. Confirmar que ? muestra ayuda o comportamiento legacy.
5. Confirmar que b/q vuelve/sale sin error.
6. Confirmar que m no rompe; si no tiene funcion real todavia, debe mantener fallback/legacy.

## PASS
Si la leyenda se ve normalizada y no hay errores, cerrar NAVIGATION_004.

## FAIL
Copiar la salida visual/error para reparar solo el punto afectado.
