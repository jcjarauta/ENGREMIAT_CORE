# WRAPPER ACTIONS LAB BINDING HINT

Estado: PREPARED_NO_APPLY
Root patched: NO
Wrapper patched: NO

## Objetivo posterior
Permitir que root-wrapper-preview.ps1 derive comandos LAB hacia actions-lab-status-router.ps1.

## Inputs a derivar
- 13, informe, plan, estado-plan
- e, estado, overview
- home, vision, preview
- m, mantenimiento

## Regla
No tocar ENGREMIAT.ps1. Si se aplica, hacerlo solo en wrapper LAB preview y con rollback.

## Comandos actuales
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand plan -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand estado -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand home -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand mantenimiento -Execute
```
