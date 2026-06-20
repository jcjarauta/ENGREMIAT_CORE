# FIRST REAL LINKING SANDBOX

## Objetivo
Crear el primer punto de entrada realista para vincular herramientas sin usar APIs reales todavía.

## Sandbox
C:\ENGREMIAT_CORE\runtime\tool-linking-sandbox

## Inbox
C:\ENGREMIAT_CORE\runtime\tool-linking-sandbox\openclaw-openwebui-inbox

## Uso
1. OpenWebUI/OpenClaw/manual dejan un JSON compatible en el inbox.
2. ENGREMIAT copia ese JSON al readonly adapter inbox.
3. ENGREMIAT ejecuta el intake readonly.
4. Se genera detected-input, tarjeta recurrente, nota candidata y batch inline.

## Comando
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ToolLinkingSandboxIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Seguridad
- No llama API de OpenWebUI.
- No llama API de OpenClaw.
- No escribe Obsidian real.
- No escribe Kanban nativo.
- No ejecuta comandos contenidos en los JSON.
- Human review first.
