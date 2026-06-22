# E36 READONLY SYSTEM OBSERVER

STATUS: 
PASS
MASTER_COMMAND: 
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\ENGREMIAT.ps1"

## NEEDS
- MEDIUM: target sin leyenda comun inicio -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
- MEDIUM: target sin leyenda comun proyectos -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- MEDIUM: target sin leyenda comun memoria -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- MEDIUM: target sin leyenda comun data -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- MEDIUM: target sin leyenda comun health -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1
- MEDIUM: no se detecta observer ps1 dedicado fuera de reports/backups; conviene consolidar uno

## SCREENS
- master: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- inicio: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
- proyectos: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- memoria: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- data: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- health: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1
- mantenimiento: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1
- launcher_actual: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1

## RECOMMENDATIONS
- 1) No tocar mas rutas a mano: usar observer readonly + planned master antes de aplicar.
- 2) Probar manualmente el maestro: Enter, ?, m, 1, 2, 3, 4, 5, b/q.
- 3) Normalizar una pantalla cada vez: primero Inicio operador, luego Proyectos, Memoria, Data, Health.
- 4) Crear un NAVIGATION_CONTRACT.json con option -> target -> resultado esperado.
- 5) Solo cerrar cuando el observer confirme parse OK, target OK, leyenda OK y rutas no duplicadas.
