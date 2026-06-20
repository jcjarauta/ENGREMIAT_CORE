# OPENWEBUI_OPENCLAW_REAL_READONLY_ADAPTER_001

## Objetivo
Crear una puerta local readonly para que OpenWebUI/OpenClaw entreguen hilos o resúmenes como JSON, sin usar API real todavía.

## Flujo
JSON en inbox -> detected-input -> recurrent model -> card -> Obsidian candidate -> inline review.

## Inbox
docs/openwebui-openclaw-readonly-adapter/inbox

## Tool
tools/kanban-local/Invoke-OpenWebUIOpenClawReadonlyIntake.ps1

## Comando smoke completo
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Seguridad
- No llama OpenWebUI API.
- No llama OpenClaw API.
- No ejecuta comandos externos.
- No escribe en Kanban nativo.
- No escribe en vault Obsidian real.
- Solo procesa archivos JSON locales.

## Próximo paso
Crear skill/packet OpenClaw para generar este JSON de inbox desde una conversación.
