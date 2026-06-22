# E37 NAVIGATION CONTRACT + TEST MATRIX

MASTER_COMMAND: 
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\ENGREMIAT.ps1"

COMMON_LEGEND: 
[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar

## NEEDS
- MEDIUM: normalizar leyenda comun en inicio -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
- MEDIUM: normalizar leyenda comun en proyectos -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- MEDIUM: normalizar leyenda comun en memoria -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- MEDIUM: normalizar leyenda comun en data -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- MEDIUM: normalizar leyenda comun en health -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1

## SCREENS
- master: exists=True parse=True legend=True status=OK path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- inicio: exists=True parse=True legend=False status=PENDING_LEGEND_NORMALIZATION path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
- proyectos: exists=True parse=True legend=False status=PENDING_LEGEND_NORMALIZATION path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- memoria: exists=True parse=True legend=False status=PENDING_LEGEND_NORMALIZATION path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- data: exists=True parse=True legend=False status=PENDING_LEGEND_NORMALIZATION path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- health: exists=True parse=True legend=False status=PENDING_LEGEND_NORMALIZATION path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1
- mantenimiento: exists=True parse=True legend=True status=OK path=C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1

## TEST MATRIX
- Enter: master -> redibuja pantalla sin cambiar estado
- ?: master -> abre ayuda del launcher maestro
- m: master -> abre mantenimiento del launcher maestro
- 1: master -> abre Inicio operador
- 2: master -> abre Proyectos
- 3: master -> abre Memoria y documentacion
- 4: master -> abre Data Intake
- 5: master -> abre Health launchers
- b/q: master -> salir/volver
