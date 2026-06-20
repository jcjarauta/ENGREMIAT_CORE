# QUEUE CLEANUP AND REPROCESSING POLICY

## Problema detectado
Los inbox acumulaban JSON y podían reprocesar elementos antiguos.

## Solución
- Sandbox inbox: mueve JSON procesados a runtime/tool-linking-sandbox/archive.
- Readonly inbox: mueve JSON procesados a docs/openwebui-openclaw-readonly-adapter/processed.
- Cada ejecución procesa solo los archivos nuevos que quedan en inbox.

## Comando recurrente
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ToolLinkingSandboxIntake.ps1 -Root C:\ENGREMIAT_CORE -RunRecurrentModel -OpenPrompt
