# DOCKER WINDOWS REQUIREMENTS DIAG
decision: WARN_DOCKER_ENGINE_NOT_READY
next: OPEN_DOCKER_DESKTOP_ACCEPT_SETUP_AND_RERUN

## Features
- Microsoft-Windows-Subsystem-Linux: Enabled
- VirtualMachinePlatform: Enabled
- HypervisorPlatform: Disabled
- Microsoft-Hyper-V-All: Enabled

## Docker
- docker_desktop_exists: True
- docker_info_ok: False

## Accion
Abrir Docker Desktop manualmente, aceptar configuracion/WSL/terminos y repetir validacion.
