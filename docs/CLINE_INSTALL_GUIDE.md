# CLINE_INSTALL_GUIDE

Objetivo: dejar Cline CLI disponible como worker gobernado, sin auto-apply ni ejecucion real.

Estado detectado:
- node_version: 
v24.16.0
- npm_version: 
11.13.0
- cline_installed: 
False
- npm_prefix_g: 
C:\Users\sacan\AppData\Roaming\npm
- npm_root_g: 
C:\Users\sacan\AppData\Roaming\npm\node_modules

Instalacion con gate explicito:
powershell -NoProfile -ExecutionPolicy Bypass -File tools/runtime/Install-ClineCliManualGate.ps1 -Execute

Despues de instalar:
1. Cerrar y reabrir PowerShell si no aparece cline.
2. Reejecutar E05.

Reglas:
- No lanzar tareas Cline desde esta etapa.
- No auto-approve.
- No auto-apply.
- No git write.
- No workers reales.
- Solo detectar CLI y dejar contrato preparado.
