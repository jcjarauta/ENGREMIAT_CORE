# SET_MAIN_PC_IP_FOR_REMOTE_OLLAMA

No se pudo resolver automaticamente la IP de MAIN-PC.

En MAIN-PC ejecuta:
ipconfig

Busca IPv4 de la red local, por ejemplo 192.168.1.50.

Luego en OLD-PC ejecuta:
powershell -NoProfile -ExecutionPolicy Bypass -File tools/runtime/Set-RemoteOllamaMainPcIp.ps1 -Ip 192.168.1.50

Despues ejecutaremos el safe probe /api/tags. No se permite inferencia ni descarga de modelos.
