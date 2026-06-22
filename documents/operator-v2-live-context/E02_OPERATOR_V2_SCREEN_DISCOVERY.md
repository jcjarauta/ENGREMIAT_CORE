# E02 Operator V2 Screen Discovery

Estado: PASS
Patched: NO
Operator root: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2
Development report command: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1
Run command: 
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1"
JSON command: 
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1" -JsonOnly
Candidates: 
36
Decision: 
GO_PREPARE_COMMAND_EXPOSURE_NO_ROOT_PATCH

## Candidatos detectados
- score=85 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json | title=True | prompt=True | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e03-20260621-175039.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e02-20260621-170200.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e05b-20260621-175913.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04c-20260621-175502.ps1 | title=True | prompt=False | dev_system=False
- score=55 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04b-20260621-175346.ps1 | title=True | prompt=False | dev_system=False
- score=35 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-style-reader.ps1 | title=False | prompt=True | dev_system=False
- score=15 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1 | title=False | prompt=False | dev_system=False
- score=10 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e05b-20260621-175913.json | title=False | prompt=False | dev_system=False
- score=10 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e03-20260621-175039.json | title=False | prompt=False | dev_system=False
- score=10 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e04b-20260621-175346.json | title=False | prompt=False | dev_system=False
- score=10 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.json | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.ps1 | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\tools\screen-engine-smoke.ps1 | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e01b-20260621-170949.ps1 | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.ps1 | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-state-20260621-170823.ps1 | title=False | prompt=False | dev_system=False
- score=5 | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e03b-20260621-170435.ps1 | title=False | prompt=False | dev_system=False

## Punto de integracion recomendado
- Exponer comando humano: informe / plan / estado-plan.
- No tocar ENGREMIAT.ps1.
- Si se parchea pantalla V2, añadir entrada: [13] Informe plan desarrollo [ACTIVE].
- Si se parchea router V2, mapear inputs: informe, plan, estado-plan, p? si no choca.

## Siguiente
E03_CREATE_OPERATOR_V2_PLAN_COMMAND_ALIAS_OR_SCREEN_ENTRY_GUARDED_WRITE
