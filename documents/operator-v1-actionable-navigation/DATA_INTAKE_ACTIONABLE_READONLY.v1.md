# DATA INTAKE ACTIONABLE READONLY v1

## Pantalla modificada
tools/operator-v1/operator-v1-data-intake-screen.ps1

## Backup
C:\ENGREMIAT_CORE\backups\operator-v1-actionable-navigation\operator-v1-data-intake-screen.before-e13-actionable-20260622-112217.ps1

## Acciones read-only integradas
- numero = ver detalle readonly
- Enter/refrescar = redibujar
- b/q/volver = volver
- ? = ayuda

## Acciones bloqueadas
- importar fuente sin gate
- modificar staging sin gate
- transformar datos sin gate
- enviar a Sheets sin gate
- abrir archivo externo sin gate
- push/fetch/merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard

## Smoke
- Data Intake screen: 
OPERATOR_V1_DATA_INTAKE
- Detail viewer: 
OPERATOR_V1_DETAIL_VIEWER_READONLY
- Data items: 
762

## NEXT
E14_VALIDATE_ACTIONABLE_DATA_INTAKE_AND_COMMIT_SCOPED
