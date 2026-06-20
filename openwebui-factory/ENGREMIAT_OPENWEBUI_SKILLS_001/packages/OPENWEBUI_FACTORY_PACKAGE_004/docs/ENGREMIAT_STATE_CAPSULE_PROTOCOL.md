# ENGREMIAT_STATE_CAPSULE_PROTOCOL

## Objetivo
Evitar que OpenWebUI invente estado cuando el RAG no contiene evidencia suficiente.

## Formato requerido
```text
ENGREMIAT_STATE_CAPSULE_BEGIN
objective=
last_closed_block=
last_status=PASS/WARN/FAIL/PENDING
current_step=
next_expected=
evidence_path=
known_risks=
real_write=false
api_called=false
openwebui_write=false
git=false
ENGREMIAT_STATE_CAPSULE_END
```

## Regla de respuesta
Si falta STATE_CAPSULE o evidencia equivalente, responder WARN y pedir evidencia. No inventar estado, roadmap ni cierre.

## Salida obligatoria
status=PASS/WARN/FAIL
estado_actual=
ultimo_bloque_cerrado=
siguiente_paso=
riesgos=
gate_required=
