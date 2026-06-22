# ENGREMIAT · Context Guarded Patch Usage

Uso obligatorio antes de escribir en archivos del operador V2:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_CORE\tools\context-guardian\Start-EngremiatGuardedWrite.ps1 -TargetPath "<TARGET>" -PackageId "<PACKAGE>" -Stage "<STAGE>"
```

Reglas:
- GO_GUARDED_WRITE_PREFLIGHT permite continuar sobre ese target.
- NO_GO_GUARDED_WRITE_BLOCKED detiene el bloque.
- El wrapper devuelve exit 0 si permite y exit 11 si bloquea.
- Siempre se crea backup antes de tocar un target permitido.
- Rutas protegidas: C:\ENGREMIAT_CORE\ENGREMIAT.ps1 y launcher legacy.
