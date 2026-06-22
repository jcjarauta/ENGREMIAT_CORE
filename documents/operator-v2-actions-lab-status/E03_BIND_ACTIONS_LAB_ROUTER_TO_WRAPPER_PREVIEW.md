# E03 Bind Actions LAB Router To Wrapper Preview

Estado: PASS
Root patched: NO
ScreenEngine patched: NO
Wrapper patched: 
True
Wrapper: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1
Backup: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\root-wrapper-preview.before-E03_BIND_ACTIONS_LAB_ROUTER_TO_WRAPPER_PREVIEW_GUARDED_WRITE-20260622-065412.ps1.bak
Router: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1

## Resultado
root-wrapper-preview.ps1 puede derivar comandos LAB hacia actions-lab-status-router.ps1 sin tocar el launcher raiz.

## Inputs LAB
- 13 / informe / plan / estado-plan
- e / estado / overview
- home / vision / preview
- m / mant / mantenimiento

## Comandos
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand plan -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand estado -Execute
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\actions-lab-status-router.ps1"
 -InputCommand home -Execute
```

## Siguiente
E04_VALIDATE_WRAPPER_ACTIONS_LAB_BIND_AND_CLOSE
