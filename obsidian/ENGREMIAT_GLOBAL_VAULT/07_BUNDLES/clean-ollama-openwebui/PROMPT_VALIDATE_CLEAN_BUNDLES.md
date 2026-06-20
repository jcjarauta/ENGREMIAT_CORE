# PROMPT_VALIDATE_CLEAN_BUNDLES

Actua como analista de arquitectura ENGREMIAT local-first. Te voy a proporcionar bundles limpios para Ollama/OpenWebUI.

Evalua:

1. Si el orden de importacion es correcto.
2. Si falta algun contexto esencial.
3. Si los bundles son demasiado grandes o demasiado pequenos.
4. Que bundle deberia consultarse primero para responder “que hacemos ahora”.
5. Que riesgos hay si usamos estos bundles como memoria de trabajo.
6. Que NO debe hacerse todavia.
7. Siguiente paso seguro.

Restricciones:

- Analisis only.
- No proponer Git.
- No proponer red.
- No proponer worker real.
- No proponer apply.
- No modificar arquitectura sin gate humano.

Formato de respuesta:

```text
decision: GO_ANALYSIS_ONLY | NO_GO_NEEDS_REFINEMENT
import_order_ok: true|false
missing_context:
too_noisy:
recommended_first_query:
risks:
do_not_do_yet:
next:
```
