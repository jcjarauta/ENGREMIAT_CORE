# E02 R1 Feedback Preview Self Contained

Estado: PASS
Patched launcher: NO
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Preview: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1
Adapter referencia: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\wrapper-command-feedback-adapter.ps1
Backup preview: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\root-wrapper-preview.ps1.before-E02_R1_REPAIR_FEEDBACK_PREVIEW_SELF_CONTAINED_NO_ROOT_PATCH-20260622-060436.bak
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer in launcher: 
False

## Reparacion
La preview anterior cargaba el adapter dentro de funcion y Get-EngWrapperCommandFeedback no quedaba visible por scope. La version R1 integra feedback autocontenido directamente en root-wrapper-preview.ps1.

## Smoke
- 
SMOKE_OK feedback_preview_self_contained=True tests=13 help=Ayuda: 1 operador, 2 proyectos, 3 memoria, 4 data intake, 5 health, m mantenimiento, b/q salir. maintenance=Mantenimiento pendiente de conectar en el router root. status=Estado compacto pendiente de conectar en el router root. unknown=Comando no reconocido. Usa ? para ayuda. option1=OPEN_OPERATOR_V2 launcher_modified=False executed=False real_execution=False

## Preview manual
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1"
```

## Resultado
La preview LAB ya muestra feedback controlado de forma autocontenida. ENGREMIAT.ps1 sigue intacto.

## Siguiente
E03 comparar feedback integrado contra matriz esperada y decidir cierre.
