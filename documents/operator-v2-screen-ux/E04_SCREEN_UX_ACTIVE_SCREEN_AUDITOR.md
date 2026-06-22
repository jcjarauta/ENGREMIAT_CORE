# E04 Screen UX Active Screen Auditor

Estado: PASS
Screen: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
Style contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json
Style reader: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-style-reader.ps1
Auditor: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-active-screen-auditor.ps1
Backup: 
Smoke: 
SMOKE_OK screen_ux_active_auditor=True readiness=90 issues=1 recommendation=PATCH_STYLE_ONLY_WITH_GUARDED_WRITE

## Funciones
- Test-EngScreenUxActiveScreen
- Get-EngScreenUxPatchPlan
- Measure-EngMaxBlankRun

## Siguiente
E05 ejecutar auditor real y decidir si hace falta parche de estilo o cierre visual.
