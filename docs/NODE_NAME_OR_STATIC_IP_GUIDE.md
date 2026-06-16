# NODE_NAME_OR_STATIC_IP_GUIDE

Objetivo: mantener MAIN-PC localizable desde OLD-PC.

Opciones recomendadas:
1. Reserva DHCP en el router para MAIN-PC.
2. Usar IP local fija documentada.
3. Usar hostname solo si DNS local funciona de forma estable.

Comando para fijar IP manual en OLD-PC:
powershell -NoProfile -ExecutionPolicy Bypass -File tools/node-link/Set-MainPcEndpoint.ps1 -Ip 192.168.1.X -HostName MAIN-PC

Reglas:
- No abrir firewall desde OLD-PC.
- No exponer servicios a Internet.
- No activar Ollama remoto hasta tener endpoint estable.
- Ping puede fallar si ICMP esta bloqueado; no significa que HTTP LAN vaya a fallar.
