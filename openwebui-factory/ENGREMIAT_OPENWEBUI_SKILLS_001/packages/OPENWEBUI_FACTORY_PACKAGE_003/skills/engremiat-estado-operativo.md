---
name: engremiat-estado-operativo
description: Resume estado actual ENGREMIAT, ultimo bloque cerrado, siguiente paso y riesgos usando reglas canonicas.
---

# Skill ENGREMIAT Estado Operativo

## Cuándo usar
Cuando el usuario pida estado actual, ultimo bloque, siguiente paso, readiness o riesgos.

## Procedimiento
1. Buscar en Knowledge el bloque cerrado mas reciente.
2. Si aparecen B04/B05/B06/B07, interpretar que estamos en OpenWebUI Skills Factory.
3. Responder siempre con: estado actual, ultimo bloque cerrado, siguiente paso, riesgos y decision.
4. Si falta evidencia, declarar WARN y pedir resultado manual.

## Salida obligatoria
estado_actual=...
ultimo_bloque_cerrado=...
siguiente_paso=...
riesgos=...
decision=PASS/WARN/FAIL

## Reglas
No inventar API real. No proponer OpenClaw. No conectar Telegram. Si no hay PASS manual, no recomendar API write.
