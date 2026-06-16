# ERROR_PLAYBOOK

Generado desde `data/errors/error-memory.jsonl`.

| Error | Firma | Causa | Reparación | Prevención | Estado |
|---|---|---|---|---|---|
| ERR-JSON-001 | JSON invalid or missing required fields | Contrato generado sin campos obligatorios o JSON mal formado. | Validar ConvertFrom-Json y campos required antes de marcar VALIDATED. | Todo JSON crítico debe parsear y declarar campos required antes de avanzar. | KNOWN |
| ERR-PS-001 | PowerShell variable PID is read-only | Uso de variable reservada $pid o nombres reservados de PowerShell. | Usar nombres explícitos como projectId, processIdValue o taskPid. | No usar variables reservadas: PID, HOME, Host, Error, Args, Input. | KNOWN |
| ERR-PS-002 | Trim on native command output can fail or hide null | Uso directo de .Trim() sobre salida nativa potencialmente nula. | Usar helper TS($v) antes de tratar stdout/stderr. | No usar .Trim() directo sobre salida de comandos nativos; usar TS(). | KNOWN |
| ERR-PS-003 | Unexpected token from fragile nested strings | Here-strings anidados, comillas frágiles o bloques fragmentados. | Reescribir script completo, evitar here-strings anidados y validar parse antes de ejecutar. | Preferir arrays de líneas y Set-Content; no dejar funciones fuera del wrapper. | KNOWN |
