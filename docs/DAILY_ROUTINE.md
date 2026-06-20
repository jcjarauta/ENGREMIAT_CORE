# DAILY_ROUTINE

## Rutina diaria ENGREMIAT post-MVP

1. Abrir terminal en `C:\ENGREMIAT_CORE`.
2. Ejecutar `.\eng.ps1 daily`.
3. Revisar `.\eng.ps1 status`.
4. Consultar `.\eng.ps1 next`.
5. Ver bandeja con `.\eng.ps1 inbox`.
6. Revisar propuesta con `.\eng.ps1 review`.
7. Registrar decision humana con `.\tools\eng-decision.ps1 -Decision DEFER -Reason "daily_review"`.

## Reglas
- ENGREMIAT prepara, valida y registra.
- El humano decide.
- Cline/Ollama proponen, no ejecutan libremente.
- Kanban es vista humana, no motor.
- No auto_apply.
- No remote_execution.
- No git_write sin autorizacion.
- No red externa por defecto.

## Siguiente
E47_OPERATIONAL_INBOX
