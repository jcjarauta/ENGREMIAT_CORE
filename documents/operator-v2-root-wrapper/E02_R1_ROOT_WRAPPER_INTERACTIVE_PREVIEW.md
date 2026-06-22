# E02 R1 Root Wrapper Interactive Preview

Estado: PASS
Patched launcher: NO
Preview: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1
Backup preview: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\root-wrapper-preview.ps1.before-E02_R1_REPAIR_WRAPPER_INTERACTIVE_PREVIEW_HOME_VARIABLE-20260622-060023.bak
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer: 
False

## Reparacion
La variable `$home` chocaba con `$HOME`, que es de solo lectura en PowerShell. Se cambia a `$homeText`.

## Smoke
- 
SMOKE_OK root_wrapper_preview_r1=True tests=13 unknown=Comando no reconocido. Usa ? para ayuda. option1=OPEN_OPERATOR_V2 launcher_modified=False executed=False real_execution=False

## Ejecutar preview manual
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1"
```

## Siguiente
E03 comparar salida wrapper preview contra comportamiento esperado del launcher actual.
