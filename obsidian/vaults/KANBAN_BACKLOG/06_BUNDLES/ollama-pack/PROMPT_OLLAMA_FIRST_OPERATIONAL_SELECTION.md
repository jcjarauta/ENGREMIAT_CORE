# PROMPT_OLLAMA_FIRST_OPERATIONAL_SELECTION

Actua como analista de arquitectura ENGREMIAT local-first. Usa el contexto adjunto sobre las 3 primeras tarjetas operativas seleccionadas desde KANBAN_BACKLOG.

Necesito que respondas con:

1. Orden recomendado de ejecucion de las 3 tarjetas.
2. Motivo de cada posicion.
3. Dependencias entre tarjetas.
4. Riesgos y gates necesarios.
5. Evidencia local que conviene revisar antes de avanzar.
6. Primera accion segura recomendada.
7. Que NO debe hacerse todavia.

Restricciones obligatorias:

- No propongas apply real.
- No propongas git write, commit, push, fetch ni merge.
- No propongas red externa.
- No propongas worker real ni Cline real.
- No propongas automatizacion sin gate humano.
- Trabaja solo como consulta/analisis.

Formato de respuesta deseado:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_MORE_CONTEXT
recommended_first_card:
reason:
dependencies:
risks:
required_gates:
evidence_to_review:
first_safe_action:
do_not_do_yet:
next:
```
