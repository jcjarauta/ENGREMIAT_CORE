# OPENCLAW TO ENGREMIAT HANDOFF

## Handoff manual actual
Copiar un JSON generado por la skill a:
C:\ENGREMIAT_CORE\docs\openwebui-openclaw-readonly-adapter\inbox

Después ejecutar:
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Handoff futuro
OpenClaw escribirá o entregará el JSON al inbox mediante integración autorizada.

## Política
ENGREMIAT no ejecuta lo que llega. Primero lo convierte en tarjeta y requiere revisión humana.
