# TOOL LINKING INITIAL OPERATING MANUAL

## Estado
Primer objetivo de vinculación inicial de herramientas cerrado.

## Decisión
GO_TOOL_LINKING_INITIAL_OBJECTIVE_READY

## Flujo operativo validado
OpenWebUI/OpenClaw/manual JSON -> sandbox inbox -> readonly inbox -> detected-input -> recurrent card -> Obsidian candidate -> inline batch -> human review.

## Carpeta de entrada
C:\ENGREMIAT_CORE\runtime\tool-linking-sandbox\openclaw-openwebui-inbox

## Comando recurrente
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ToolLinkingSandboxIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt

## Política de cola
- Los JSON del sandbox se archivan tras copiarse.
- Los JSON del readonly inbox se mueven a processed tras procesarse.
- Los inbox deben quedar limpios tras cada ciclo.

## Seguridad
- No OpenWebUI API real.
- No OpenClaw API real.
- No escritura Kanban nativa.
- No escritura Obsidian real.
- No ejecución desde el contenido del JSON.
- Revisión humana primero.

## Para añadir una entrada nueva
1. Crear o copiar un JSON compatible en runtime/tool-linking-sandbox/openclaw-openwebui-inbox.
2. Ejecutar el comando recurrente.
3. Revisar el batch inline abierto.
4. Decidir PASS/WARN/NO_GO.

## Campos mínimos JSON
- thread_id
- source
- via
- title
- user_intent
- assistant_summary
- proposed_kind
- priority
- risk
- target_consumers

## Siguiente frontera
Elegir entre:
A) Conectar OpenClaw real para producir este JSON.
B) Conectar OpenWebUI export/read-only real.
C) Configurar VaultPath de Obsidian y aplicar gate de escritura controlada.
