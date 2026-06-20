# OPENCLAW INSTALLATION OPTIONS ASSESSMENT

## Objetivo
Evaluar opciones de instalacion de OpenClaw para ENGREMIAT sin instalar ni ejecutar nada en este bloque.

## Opciones detectadas
1. Installer oficial: instalador que detecta sistema, instala Node si hace falta, instala OpenClaw y lanza onboarding.
2. Docker / docker compose: opcion preferible para aislamiento y reproducibilidad.
3. Windows Hub companion app: opcion de escritorio para Windows con setup, tray status, chat, node mode y local MCP mode.
4. Repo/hackable install: opcion para desarrollo, pero con mayor superficie tecnica.

## Decision ENGREMIAT
No instalar todavia. Si se instala, preferir laboratorio aislado y controlado, no workstation principal con permisos amplios.

## Requisitos previos minimos antes de instalar
- Definir usuario/cuenta no sensible.
- Definir carpeta aislada.
- Definir puertos.
- Definir modo read-only.
- Definir secrets policy.
- Definir rollback.
- Definir logs/evidencias.
- Confirmar no acceso a repo completo ni credenciales.

## Opcion preferida para primera prueba
Docker aislado o entorno dedicado, con volumen minimo read-only y sin credenciales reales.

## NO_GO actual
No instalar hasta cerrar B04 con plan de laboratorio y gate humano.
