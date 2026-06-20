# FINAL MVP MANUAL

## Propósito
Este MVP final consolida ENGREMIAT como sistema local-first antifricción con worker asistido gobernado.

## Qué incluye
- Command hub `eng.ps1`.
- Artifact Registry.
- Context Snapshot.
- Gate Center.
- Readiness Checker.
- Error Memory.
- Doc Sync.
- MVP Dashboard.
- Assisted Worker Adapter.

## Rutina diaria
```powershell
.\eng.ps1 status
.\eng.ps1 readiness
.\eng.ps1 gates
.\eng.ps1 context
.\eng.ps1 artifacts
.\eng.ps1 docs
.\eng.ps1 dashboard
```

## Regla central
El humano decide. DEV_SYSTEM prepara y valida. Cline/Ollama propone. El runner aplica solo con evidencia y gate.
