# HANDOFF CURRENT PC TO MAIN PC

Objective: ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B

## Estado
Este handoff prepara el cambio futuro desde el PC actual hacia MAIN-PC. No obliga a ir a MAIN-PC ahora.

## PC actual
computer_name=
DESKTOP-RLPN1LL
cwd=
C:\Users\sacan\Desktop\ENGREMIAT_CORE

## Regla principal
Un solo PC escritor activo por objetivo/bloque. Git es fuente de verdad del codigo. ENGREMIAT_SHARED es puente de handoff/evidencias, no repo vivo.

## Antes de ir a MAIN-PC
1. Confirmar que el bloque actual queda cerrado.
2. Copiar o consultar este handoff.
3. No iniciar Cline/Ollama real desde este PC.
4. Esperar instruccion explicita para volver a MAIN-PC.

## Al llegar a MAIN-PC
1. Validar repo local.
2. Leer data/dual-pc-development-workflow/current-to-main-pc-handoff-template.json.
3. Leer data/dual-pc-development-workflow/current-pc-state-snapshot.json.
4. Ejecutar readiness MAIN-PC antes de escribir codigo.

## Prohibiciones
No usar carpeta compartida como repo vivo.
No ejecutar scripts automaticamente desde shared.
No guardar secretos ni tokens.
No hacer git remoto automatico.
No crear tarea Cline real sin gate.

## Siguiente
Continuar E03 en este PC: readiness de repo local por PC.
