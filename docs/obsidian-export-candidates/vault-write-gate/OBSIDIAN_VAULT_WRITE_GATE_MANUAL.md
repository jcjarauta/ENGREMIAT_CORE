# OBSIDIAN_VAULT_WRITE_GATE_001

## Objetivo
Preparar un gate controlado para exportar notas candidatas de ENGREMIAT a un vault real de Obsidian.

## Estado inicial
Bloqueado por defecto. Preview-only.

## Entrada
docs/obsidian-export-candidates/notes/*.md

## Salida preview
docs/obsidian-export-candidates/vault-write-gate/vault-write-preview.*.md
docs/obsidian-export-candidates/vault-write-gate/vault-write-plan.*.json

## Tool
tools/kanban-local/Invoke-ObsidianVaultWriteGate.ps1

## Comando preview seguro
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ObsidianVaultWriteGate.ps1 -Root C:\ENGREMIAT_CORE

## Comando apply con vault real
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ObsidianVaultWriteGate.ps1 -Root C:\ENGREMIAT_CORE -VaultPath "RUTA_DEL_VAULT_OBSIDIAN" -Apply

## Autorización humana requerida
AUTORIZO_OBSIDIAN_VAULT_WRITE_GATE_001

## Seguridad
- No escribe por defecto.
- Solo preview si no hay -Apply.
- Requiere VaultPath para aplicar.
- Copia a ENGREMIAT/Inbox dentro del vault.
- No ejecuta Obsidian.
- No modifica Kanban nativo.
