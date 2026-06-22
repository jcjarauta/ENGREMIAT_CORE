# Project Module Card View Contract

Estado: PASS

Jerarquia canonica:
- PROYECTO
  - MODULO
    - TARJETA

Reglas:
- Una tarjeta nunca existe suelta.
- Toda tarjeta pertenece a un modulo.
- Todo modulo pertenece a un proyecto.
- La primera vista sera readonly.
- El autodiagnostico solo genera tarjetas PROPOSED con gate humano.

Columnas canonicas:
num, card_id, project_id, module_id, type, status, priority, risk, title, human_gate, suggested_action

Comandos propuestos:
numero = abrir tarjeta | m = filtrar modulo | p = filtrar proyecto | a = crear propuesta | v = validar | b = volver | Enter = refrescar

Next: E93B_CREATE_FIRST_CARD_VIEW_READONLY