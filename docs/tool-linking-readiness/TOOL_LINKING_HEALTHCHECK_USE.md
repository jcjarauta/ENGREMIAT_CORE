# TOOL_LINKING_HEALTHCHECK_USE

## Objetivo
Validar si ENGREMIAT está preparado para vincular herramientas reales mediante sandbox local readonly.

## Comando
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Test-EngremiatToolLinkingReadiness.ps1 -Root C:\ENGREMIAT_CORE -OpenReport

## Reparación incorporada
Evita el error PowerShell de variable seguida de dos puntos usando formato seguro en vez de "$k:".
