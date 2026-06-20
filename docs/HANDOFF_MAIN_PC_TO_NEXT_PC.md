# HANDOFF MAIN PC TO NEXT PC

Objective: ENGREMIAT_MAIN_PC_REAL_LINKING_010

## Estado
MAIN-PC preparado para continuar sin perder contexto.

## Regla central
Solo un PC escritor activo por objetivo o bloque. Git es la fuente de verdad.

## Handoff
- Leer data/main-pc-linking/main-pc-handoff-schema.json
- Leer data/main-pc-linking/main-pc-to-current-pc-handoff-template.json
- Leer data/main-pc-linking/main-pc-state-snapshot.json

## Prohibiciones
- No secretos
- No .env
- No tokens
- No git write automatico
- No auto apply
- No shared repo edit

## Siguiente
Volver al otro PC solo con un unico escritor activo y repo local validado.
