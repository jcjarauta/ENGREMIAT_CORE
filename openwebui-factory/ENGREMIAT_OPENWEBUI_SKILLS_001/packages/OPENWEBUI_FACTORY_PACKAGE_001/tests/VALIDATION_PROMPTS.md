# VALIDATION PROMPTS - PACKAGE 001

## Test 1 - Estado
Usa la Skill de resumir estado ENGREMIAT y dime: estado actual, último bloque cerrado y siguiente paso.

## Test 2 - Roadmap
Usa la Skill de roadmap y dime cuál es el siguiente bloque lógico y por qué.

## Test 3 - Evidencia
Valida este log ficticio: OK status=PASS next=B05 report=C:\tmp\report.json. Devuelve status, evidencia y siguiente acción.

## PASS esperado
- Respuesta breve.
- Usa contexto ENGREMIAT.
- No inventa instalación OpenClaw.
- No propone API real sin gate.
- Identifica B05 como siguiente si el paquete funciona.
