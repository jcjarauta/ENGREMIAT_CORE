# E11 Manual Retest Command Feedback After Repair

Estado: READY_FOR_HUMAN_TEST
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Adapter: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\command-feedback-dry-run-adapter.ps1
Smoke: 
SMOKE_OK command_feedback_retest_ready=True tests=5 x_feedback=Comando no reconocido. Usa ? para ayuda. executed=False real_execution=False

## Prueba manual
1. Escribe `x`: debe mostrar `WARN Comando no reconocido. Usa ? para ayuda.` o al menos `Comando no reconocido. Usa ? para ayuda.`
2. Escribe `e`: debe mostrar estado compacto o pendiente claro; ya no debe salir `Comando no reconocido: e`.
3. Escribe `?`: debe mostrar ayuda.
4. Escribe `m`: debe mostrar mantenimiento o pendiente claro.
5. Pulsa Enter vacio: debe refrescar/redibujar sin error.
6. Escribe `1`: debe entrar al Operador V2 sin doble leyenda inmediata.
7. Escribe `b` o `q`: debe volver/salir.

## PASS
Si no aparece `Comando no reconocido: x/e` ni `Enter = volver/refrescar`, cerrar COMMAND_FEEDBACK_006.

## FAIL
Copiar pantalla/error y reparar solo launcher/observer feedback.
