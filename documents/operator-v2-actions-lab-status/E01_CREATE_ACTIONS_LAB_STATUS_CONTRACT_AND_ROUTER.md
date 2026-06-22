# E01 Create Actions LAB Status Contract And Router

Estado: PASS
Root patched: NO
ScreenEngine patched: NO
Contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ACTIONS_LAB_STATUS.json
Router: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1

## Acciones
- 13/informe/plan/estado-plan -> plan-v2.ps1
- e/estado/overview -> operator-v2-live-context-overview.ps1
- home/vision/preview -> operator-v2-home-preview-composer.ps1
- m/mantenimiento -> placeholder LAB seguro

## Comando
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand plan
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand plan -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand estado -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand home -Execute
```

## Siguiente
E02_VALIDATE_ACTIONS_LAB_ROUTER_AND_OPTIONAL_WRAPPER_HINT
