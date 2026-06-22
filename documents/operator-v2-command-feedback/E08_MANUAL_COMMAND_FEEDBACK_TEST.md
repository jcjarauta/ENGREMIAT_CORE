# E08 Manual Command Feedback Test

Estado: READY_FOR_HUMAN_TEST
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Adapter: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\command-feedback-dry-run-adapter.ps1

## Prueba manual
1. En el launcher raiz, prueba `?` y debe salir ayuda contextual o feedback visible.
2. Prueba `m` y debe salir mantenimiento o pendiente claro.
3. Prueba `e` y debe salir estado o pendiente claro.
4. Prueba `xyz` y debe salir: Comando no reconocido. Usa ? para ayuda.
5. Pulsa Enter vacio y debe refrescar/redibujar sin error.
6. Entra con `1` a Operador V2 y verifica que no rompe la navegacion.
7. Prueba `b` o `q` para volver/salir.

## PASS esperado
- No errores rojos.
- Feedback visible para comando desconocido.
- Flujo legacy conservado.
- Launcher sigue operativo.

## FAIL
Copiar pantalla/error para reparar solo el observer COMMAND_FEEDBACK.
