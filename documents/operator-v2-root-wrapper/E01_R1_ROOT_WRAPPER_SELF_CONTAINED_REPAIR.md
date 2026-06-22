# E01 R1 Root Wrapper Self Contained Repair

Estado: PASS
Patched launcher: NO
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_WRAPPER.json
Wrapper: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper.ps1
Router contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_LOOP_ROUTER.json
Backup contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\ROOT_WRAPPER.json.before-E01_R1_REPAIR_ROOT_WRAPPER_SELF_CONTAINED_SMOKE-20260622-055808.bak
Backup wrapper: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\root-wrapper.ps1.before-E01_R1_REPAIR_ROOT_WRAPPER_SELF_CONTAINED_SMOKE-20260622-055808.bak
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer: 
False

## Reparacion
El wrapper anterior dependia de cargar root-loop-router-reader.ps1 dentro de una funcion. En PowerShell eso genero problema de scope y ExecutionPolicy. La version R1 queda autocontenida y lee ROOT_LOOP_ROUTER.json directamente.

## Smoke
- 
SMOKE_OK root_wrapper_008_r1=True tests=13 unknown=Comando no reconocido. Usa ? para ayuda. option1=OPEN_OPERATOR_V2 launcher_modified=False executed=False real_execution=False

## Siguiente
E02 crear preview interactiva del wrapper sin parchear launcher.
