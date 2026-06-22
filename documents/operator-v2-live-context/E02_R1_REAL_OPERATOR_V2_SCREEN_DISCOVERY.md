# E02 R1 Real Operator V2 Screen Discovery

Estado: PASS
Patched: NO
Operator root: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2
Development report command: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1
Candidates PS1: 
27
Primary: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e03-20260621-175039.ps1
Decision: 
GO_REAL_SCREEN_SCRIPT_DISCOVERED_PREPARE_GUARDED_WRITE

## Candidatos ejecutables detectados
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e03-20260621-175039.ps1
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e05b-20260621-175913.ps1
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04c-20260621-175502.ps1
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04b-20260621-175346.ps1
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
- score=130 | parse=True | reasons=title,read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e02-20260621-170200.ps1
- score=105 | parse=True | reasons=title,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1
- score=80 | parse=True | reasons=prompt,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-style-reader.ps1
- score=50 | parse=True | reasons=read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-wrapper-preview.ps1
- score=50 | parse=True | reasons=read-host,switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.ps1
- score=35 | parse=True | reasons=read-host,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e04-20260621-171140.ps1
- score=35 | parse=True | reasons=read-host,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-state-20260621-170823.ps1
- score=35 | parse=True | reasons=read-host,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e03-20260621-170239.ps1
- score=35 | parse=True | reasons=read-host,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e03b-20260621-170435.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e03-20260621-170239.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e02-engine-20260621-174611.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e04-20260621-171140.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e03b-20260621-170435.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e01b-20260621-170949.ps1
- score=25 | parse=True | reasons=switch,menu | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-state-20260621-170823.ps1

## Integracion recomendada
- Añadir entrada visible: [13] Informe plan desarrollo [ACTIVE].
- Añadir comandos: informe, plan, estado-plan.
- Ejecutar: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-development-report.ps1"
- No tocar ENGREMIAT.ps1.

## Siguiente
E03_ADD_PLAN_REPORT_COMMAND_TO_OPERATOR_V2_SCREEN_GUARDED_WRITE
