# OPENWEBUI DOCKER PREP

status: DOCKER_ENGINE_NOT_READY

## Rutas
- compose: C:\ENGREMIAT_TOOLS\openwebui\docker-compose.yml
- data: C:\ENGREMIAT_TOOLS\openwebui\data
- start: C:\ENGREMIAT_TOOLS\openwebui\start-openwebui.ps1
- stop: C:\ENGREMIAT_TOOLS\openwebui\stop-openwebui.ps1

## Siguiente si Docker está READY
Ejecutar:
powershell -NoProfile -ExecutionPolicy Bypass -File C:\ENGREMIAT_TOOLS\openwebui\start-openwebui.ps1

Luego abrir:
http://localhost:3000

## Si Docker no está READY
Abrir Docker Desktop manualmente y esperar a que el engine esté running.
