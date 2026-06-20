# ERROR PLAYBOOK

Generated: 
2026-06-17T11:12:34.7808940+02:00

## Reglas preventivas

1. No parsear stdout de PowerShell hijo si puede contener logs; usar archivos JSON.
2. Validar Test-Path justo despues de generar artefactos.
3. Calcular variables antes de concatenar Write-Host o HTML.
4. No usar `.Trim()` directo sobre salidas nativas.
5. Ante ERR, detener y reparar antes de avanzar.

## Comandos
```powershell
.\tools\eng-errors.ps1 known
.\tools\eng-errors.ps1 last
.\tools\eng-errors.ps1 hints
```
