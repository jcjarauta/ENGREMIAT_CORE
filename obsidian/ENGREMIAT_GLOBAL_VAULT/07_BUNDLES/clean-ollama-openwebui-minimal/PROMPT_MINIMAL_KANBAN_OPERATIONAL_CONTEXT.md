# PROMPT_MINIMAL_KANBAN_OPERATIONAL_CONTEXT

Actua como analista de arquitectura ENGREMIAT local-first. Usa solo el contexto minimo proporcionado.

Responde:

1. Confirmas continuar con SYSTEM_NEED_004?
2. Cual es la primera accion local segura?
3. Que contexto falta, si falta alguno?
4. Que riesgos concretos hay?
5. Que no debe hacerse todavia?
6. Cual debe ser el siguiente bloque PowerShell seguro?

Restricciones:

- analysis_only=true
- no git
- no network
- no worker_real_execution
- no auto_apply
- no modificar arquitectura sin gate humano

Formato:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_CONTEXT
continue_with:
first_safe_action:
missing_context:
risks:
do_not_do_yet:
next_block:
```
