# ENGREMIAT_OPERATOR_V2_MAINTENANCE_ACTIONS_LAB_014 - CLOSE

Estado: CLOSED_LAB_READY
Readiness: 90
Root patched: NO
ScreenEngine patched: NO
Plan updated: SI

## Resultado
m/mantenimiento abre un menu LAB readonly con salud, reports, backups, rutas, validar y git-dry.

## Comandos
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand mantenimiento -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\maintenance-actions-lab-router.ps1"
 -InputCommand salud
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\maintenance-actions-lab-router.ps1"
 -InputCommand validar
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\maintenance-actions-lab-router.ps1"
 -InputCommand reports
```
