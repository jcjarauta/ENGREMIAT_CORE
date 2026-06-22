# E03 Wrapper Compare Expected Root Behavior

Estado: PASS
Patched launcher: NO
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Preview: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1
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
GO_WRAPPER_PREVIEW_MATCHES_EXPECTED_ROOT_BEHAVIOR

## Matrix
- input=[] expected=root.refresh actual=root.refresh ok=True risk=LOW feedback=Pantalla refrescada.
- input=[enter] expected=root.refresh actual=root.refresh ok=True risk=LOW feedback=Pantalla refrescada.
- input=[?] expected=root.help actual=root.help ok=True risk=LOW feedback=Ayuda: 1 operador, 2 proyectos, 3 memoria, 4 data intake, 5 health, m mantenimiento, b/q salir.
- input=[m] expected=root.maintenance actual=root.maintenance ok=True risk=PENDING_FEEDBACK_SAFE feedback=Mantenimiento pendiente de conectar en el router root.
- input=[e] expected=root.status actual=root.status ok=True risk=PENDING_FEEDBACK_SAFE feedback=Estado compacto pendiente de conectar en el router root.
- input=[1] expected=root.option.1 actual=root.option.1 ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Abriendo operador.
- input=[2] expected=root.option.2 actual=root.option.2 ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Abriendo proyectos.
- input=[3] expected=root.option.3 actual=root.option.3 ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Abriendo memoria y documentacion.
- input=[4] expected=root.option.4 actual=root.option.4 ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Abriendo Data Intake.
- input=[5] expected=root.option.5 actual=root.option.5 ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Abriendo Health launchers.
- input=[b] expected=root.quit actual=root.quit ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Saliendo o volviendo segun flujo legacy.
- input=[q] expected=root.quit actual=root.quit ok=True risk=LEGACY_DRY_RUN_ONLY feedback=Saliendo o volviendo segun flujo legacy.
- input=[xyz] expected=root.unknown actual=root.unknown ok=True risk=UNKNOWN_FEEDBACK_SAFE feedback=Comando no reconocido. Usa ? para ayuda.

## Lectura humana
- El wrapper reproduce la matriz esperada del root sin tocar ENGREMIAT.ps1.
- Las rutas legacy siguen marcadas como dry-run.
- Si mismatches=0, el siguiente paso decide si el wrapper queda como laboratorio o como entrada candidata.

## Siguiente
E04_DECIDE_IF_WRAPPER_BECOMES_SAFE_ENTRY_OR_STAYS_LAB
