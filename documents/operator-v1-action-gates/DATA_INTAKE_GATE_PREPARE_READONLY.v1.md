# DATA INTAKE GATE PREPARE READONLY v1

## Pantalla modificada
tools/operator-v1/operator-v1-data-intake-screen.ps1

## Backup
C:\ENGREMIAT_CORE\backups\operator-v1-action-gates\operator-v1-data-intake-screen.before-e12-gates-20260622-120045.ps1

## Acciones integradas
- numero = ver detalle readonly
- gN = preparar gate readonly
- gate N = preparar gate readonly
- Enter/refrescar = redibujar
- b/q/volver = volver
- ? = ayuda

## Gate inicial
- action_id: preparar_importacion_fuente
- risk: HIGH
- command_preview: PREVIEW_ONLY Import/Validate/Stage <path> -- NOT EXECUTED
- requires_human_authorization=True
- real_execution=False

## Bloqueos
- importar fuente sin gate
- validar fuente sin gate
- procesar staging sin gate
- exportar dataset sin gate
- ejecutar gate sin autorizacion
- push/fetch/merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard

## Smoke
- Data screen: 
OPERATOR_V1_DATA_INTAKE
- Gate previewer: 
OPERATOR_V1_GATE_PREVIEWER_READONLY
- Data items: 
2738

## NEXT
E13_VALIDATE_DATA_INTAKE_GATE_PREPARE_AND_COMMIT_SCOPED
