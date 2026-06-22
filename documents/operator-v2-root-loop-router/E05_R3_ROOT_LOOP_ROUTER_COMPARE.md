# E05 R3 Root Loop Router Compare

Estado: PASS
Metodo: READER_ONLY_SCRIPTBLOCK_BYPASS_EXECUTION_POLICY
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_LOOP_ROUTER.json
Reader: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-loop-router-reader.ps1
Patched: NO
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer: 
False
Results: 
13
Mismatches: 
0
Decision: 
GO_PLANNED_DIFF_CAN_BE_GENERATED_WITH_CAUTION

## Matrix
- input=[] expected=root.refresh actual=root.refresh ok=True risk=LOW feedback=Pantalla refrescada.
- input=[enter] expected=root.refresh actual=root.refresh ok=True risk=LOW feedback=Pantalla refrescada.
- input=[?] expected=root.help actual=root.help ok=True risk=LOW feedback=Ayuda: 1 operador, 2 proyectos, 3 memoria, 4 data intake, 5 health, m mantenimiento, b/q salir.
- input=[m] expected=root.maintenance actual=root.maintenance ok=True risk=MEDIUM_PENDING feedback=Mantenimiento pendiente de conectar en el router root.
- input=[e] expected=root.status actual=root.status ok=True risk=MEDIUM_PENDING feedback=Estado compacto pendiente de conectar en el router root.
- input=[1] expected=root.option.1 actual=root.option.1 ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Abriendo operador.
- input=[2] expected=root.option.2 actual=root.option.2 ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Abriendo proyectos.
- input=[3] expected=root.option.3 actual=root.option.3 ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Abriendo memoria y documentacion.
- input=[4] expected=root.option.4 actual=root.option.4 ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Abriendo Data Intake.
- input=[5] expected=root.option.5 actual=root.option.5 ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Abriendo Health launchers.
- input=[b] expected=root.quit actual=root.quit ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Saliendo o volviendo segun flujo legacy.
- input=[q] expected=root.quit actual=root.quit ok=True risk=HIGH_LEGACY_ROUTE_DO_NOT_REWRITE_BLINDLY feedback=Saliendo o volviendo segun flujo legacy.
- input=[xyz] expected=root.unknown actual=root.unknown ok=True risk=LOW_FEEDBACK_ONLY feedback=Comando no reconocido. Usa ? para ayuda.

## Lectura humana
- El router dry-run ya resuelve 13 inputs sin ejecutar acciones reales.
- Todavia no se aplica ningun cambio al launcher.
- Si mismatches=0, el siguiente paso es generar diff planificado NO_APPLY.

## Siguiente
E06_GENERATE_ROOT_LOOP_ROUTER_PLANNED_DIFF_NO_APPLY
