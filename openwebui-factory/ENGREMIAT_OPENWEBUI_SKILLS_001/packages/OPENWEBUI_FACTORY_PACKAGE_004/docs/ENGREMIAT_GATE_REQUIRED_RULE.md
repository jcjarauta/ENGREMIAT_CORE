# ENGREMIAT_GATE_REQUIRED_RULE

## Regla obligatoria
gate_required debe calcularse siempre. Nunca responder "no se menciona" si existen flags de seguridad.

## Fórmula
gate_required=true si cualquiera de estos campos es true: real_write, api_called, openwebui_write, git, browser, clipboard, worker_execute, external_network.

gate_required=false si todos esos campos son false o si la evidencia declara explícitamente operación LOCAL_ONLY sin escritura real.

## Para STATE_CAPSULE
Si STATE_CAPSULE contiene real_write=false api_called=false openwebui_write=false git=false, entonces gate_required=False.

## Si faltan flags
Si faltan flags y la acción podría escribir o ejecutar, responder gate_required=UNKNOWN y decision=WARN_REQUEST_EVIDENCE.
