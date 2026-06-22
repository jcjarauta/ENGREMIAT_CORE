# NEXT OBJECTIVE

ID: ENGREMIAT_OPERATOR_V2_NAVIGATION_004

Objetivo: normalizar navegación real del operador V2 manteniendo el launcher estable.

Prioridad:
1. Validar UX manual real de Enter/e/m/?/b/q.
2. Si PASS, integrar acciones con navegación visible.
3. Si FAIL, reparar solo el punto de input/router afectado.
4. Evitar reescritura completa del launcher salvo bloqueo de parse.

Regla: guarded write, backup, parse, smoke, flujo legacy preservado.
