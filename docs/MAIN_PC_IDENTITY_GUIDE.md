# MAIN_PC_IDENTITY_GUIDE

Objetivo: capturar identidad de MAIN-PC sin abrir puertos ni cambiar firewall.

En OLD-PC ya se creo:
tools/node-link/Test-MainPcNodeIdentity.ps1

Modo recomendado:
1. Copiar ese script a MAIN-PC.
2. Ejecutarlo en PowerShell de MAIN-PC.
3. Copiar el JSON generado desde el Escritorio de MAIN-PC.
4. Pegar ese JSON en OLD-PC como data/node-link/main-pc-node-identity-report.json.

Reglas:
- read_only=True
- firewall_changed=False
- services_changed=False
- no Ollama en OLD-PC
- no inferencia todavía
