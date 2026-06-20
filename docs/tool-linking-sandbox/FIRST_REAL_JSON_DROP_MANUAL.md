# FIRST REAL JSON DROP MANUAL

## Objetivo
Probar el primer vínculo realista entre OpenWebUI/OpenClaw y ENGREMIAT mediante archivo JSON local.

## Archivo a editar
C:\ENGREMIAT_CORE\runtime\tool-linking-sandbox\openclaw-openwebui-inbox\REAL-OPENWEBUI-OPENCLAW-DROP-20260618-110124.json

## Qué hacer
1. Sustituir title, user_intent y assistant_summary con contenido real de una conversación.
2. Ajustar proposed_kind: need, capability, project, evidence, blocker, decision o memory.
3. Ajustar priority de 0 a 100.
4. Ajustar risk: LOW, MEDIUM o HIGH.
5. Guardar.
6. Ejecutar el comando de ingestión.

## Comando
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ToolLinkingSandboxIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Seguridad
- No API real.
- No ejecución.
- No escritura Kanban nativa.
- No escritura Obsidian real.
- El JSON se convierte en detected-input, tarjeta recurrente, nota candidata y batch inline.
