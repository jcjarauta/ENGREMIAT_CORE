# OPENCLAW_SKILL_PACKET_FOR_READONLY_INTAKE_001

## Objetivo
Crear un paquete de skill para que OpenClaw actúe como punto medio entre OpenWebUI y ENGREMIAT sin ejecutar acciones reales.

## Estado
Preparado localmente. No instalado en OpenClaw real.

## Skill
docs/openclaw-skill-packet/engremiat-readonly-intake-skill/SKILL.md

## Contrato
contracts/openclaw-skill-packet/openclaw-readonly-intake-output-contract.json

## Funcionamiento esperado
1. OpenWebUI genera conversación/resumen.
2. OpenClaw aplica la skill engremiat-readonly-intake.
3. La skill devuelve JSON compatible.
4. El JSON se deposita en docs/openwebui-openclaw-readonly-adapter/inbox.
5. ENGREMIAT procesa el inbox con Invoke-OpenWebUIOpenClawReadonlyIntake.ps1.
6. Se crea tarjeta, nota candidata y batch inline.

## Seguridad
- No ejecución.
- No navegador.
- No Kanban nativo.
- No Obsidian real.
- Human review first.

## Comando ENGREMIAT para procesar inbox
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Siguiente paso
Crear simulador de handoff: copiar example output al inbox y procesarlo automáticamente.
