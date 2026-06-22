# HEALTH LAUNCHERS GATE PREPARE READONLY v1

## Pantalla modificada
tools/operator-v1/operator-v1-health-launchers-screen.ps1

## Backup
C:\ENGREMIAT_CORE\backups\operator-v1-action-gates\operator-v1-health-launchers-screen.before-e16-gates-20260622-120920.ps1

## Acciones integradas
- numero = ver detalle readonly
- gN = preparar gate readonly
- gate N = preparar gate readonly
- Enter/refrescar = redibujar
- b/q/volver = volver
- ? = ayuda

## Gate inicial
- action_id: preparar_ejecucion_healthcheck / preparar_ejecucion_smoke / preparar_ejecucion_repair / preparar_apertura_launcher
- risk: HIGH por defecto; MEDIUM para docs/reports/data json
- command_preview: PREVIEW_ONLY Health/Smoke/Repair/Launcher <path> -- NOT EXECUTED
- requires_human_authorization=True
- real_execution=False

## Bloqueos
- ejecutar healthcheck sin gate
- ejecutar smoke sin gate
- ejecutar repair sin gate
- abrir launcher sin gate
- ejecutar gate sin autorizacion
- push/fetch/merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard

## Smoke
- Health screen: 
OPERATOR_V1_HEALTH_LAUNCHERS
- Gate previewer: 
OPERATOR_V1_GATE_PREVIEWER_READONLY
- Health items: 
4848

## NEXT
E17_VALIDATE_HEALTH_LAUNCHERS_GATE_PREPARE_AND_COMMIT_SCOPED
