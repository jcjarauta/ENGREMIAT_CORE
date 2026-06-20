---
type: human_machine_manual
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: ACTIVE
---
# MANUAL HUMANO-MAQUINA · SKILL FACTORY LIGHT

## Para que sirve

Sirve para capturar respuestas utiles y convertirlas en candidatas de skill sin oficializarlas prematuramente.

## Flujo operativo

1. Capturar una respuesta util.
2. Convertirla en candidata con `SKILL_CAPTURE_TO_CANDIDATE`.
3. Usar plantilla estricta rellenable.
4. Ejecutar test manual en OpenWebUI.
5. Registrar PASS/WARN/FAIL.
6. Si PASS, oficializar como manual-only.
7. Si WARN, reparar prompt/schema.
8. Si FAIL_CONTEXT, crear bundle Markdown unico importable.

## Skills oficiales disponibles

- `SKILL_ESTADO_ENGREMIAT`: resume estado, ultimo bloque, siguiente paso y riesgos.
- `SKILL_CAPTURE_TO_CANDIDATE`: convierte capturas utiles en candidatas de skill.

## Reglas clave

- No usar prompts abiertos cuando se necesite schema estricto.
- Preferir plantilla rellenable.
- No oficializar sin PASS.
- No automatizar ejecucion todavia.
- Si OpenWebUI no ve archivos, usar Markdown unico importable.
