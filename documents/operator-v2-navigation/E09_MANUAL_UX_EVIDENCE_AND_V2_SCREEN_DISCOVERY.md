# E09 Manual UX Evidence And V2 Screen Discovery

Estado: PASS
Root launcher visible: SI
Operator V2 visible: SI
Root launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Operator root: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2
Best V2 screen candidate: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e02-20260621-170200.ps1

## Evidencia manual observada
- Root: ENGREMIAT / LAUNCHER HUMANO ESTABLE.
- Root menu: [1] Inicio operador, [2] Proyectos, [3] Memoria y documentacion, [4] Data Intake, [5] Health launchers.
- Root legend: [b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar.
- V2: ENGREMIAT / OPERADOR V2.
- V2 legend: [b/q] volver | ? ayuda | Enter refrescar.
- Diferencia detectada: V2 necesita normalizar formato de leyenda con "=" y posiblemente añadir m = mantenimiento si aplica.

## Top candidates
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\ENGREMIAT_OPERADOR_V2.before-e02-20260621-170200.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e03-20260621-175039.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04b-20260621-175346.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e04c-20260621-175502.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.before-e05b-20260621-175913.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=18 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1 why=title_v2,back_hint,enter_hint,help_hint
- score=8 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e03-20260621-170239.ps1 why=back_hint,enter_hint,help_hint
- score=8 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e03b-20260621-170435.ps1 why=back_hint,enter_hint,help_hint
- score=8 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-e04-20260621-171140.ps1 why=back_hint,enter_hint,help_hint
- score=8 parse_ok=True path=C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.before-state-20260621-170823.ps1 why=back_hint,enter_hint,help_hint

## Siguiente
E10 aplicar guarded write sobre el mejor candidato V2 para normalizar leyenda/prompt sin alterar flujo.
