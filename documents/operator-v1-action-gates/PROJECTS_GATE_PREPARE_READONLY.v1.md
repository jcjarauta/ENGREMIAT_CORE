# PROJECTS GATE PREPARE READONLY v1

## Pantalla modificada
tools/operator-v1/operator-v1-projects-screen.ps1

## Backup
C:\ENGREMIAT_CORE\backups\operator-v1-action-gates\operator-v1-projects-screen.before-e04-gates-20260622-114151.ps1

## Acciones integradas
- numero = ver detalle readonly
- gN = preparar gate readonly
- gate N = preparar gate readonly
- Enter/refrescar = redibujar
- b/q/volver = volver
- ? = ayuda

## Gate inicial
- action_id: abrir_carpeta_proyecto
- risk: MEDIUM
- command_preview: PREVIEW_ONLY Start-Process <path> -- NOT EXECUTED
- requires_human_authorization=True
- real_execution=False

## Bloqueos
- abrir carpeta sin gate
- ejecutar gate sin autorizacion
- push/fetch/merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard

## Smoke
- Projects screen: 
OPERATOR_V1_PROJECTS
- Gate previewer: 
OPERATOR_V1_GATE_PREVIEWER_READONLY
- Project candidates: 
10

## NEXT
E05_VALIDATE_PROJECTS_GATE_PREPARE_AND_COMMIT_SCOPED
