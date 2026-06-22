# HEALTH LAUNCHERS ACTIONABLE READONLY v1

## Pantalla modificada
tools/operator-v1/operator-v1-health-launchers-screen.ps1

## Backup
C:\ENGREMIAT_CORE\backups\operator-v1-actionable-navigation\operator-v1-health-launchers-screen.before-e17-actionable-20260622-112903.ps1

## Acciones read-only integradas
- numero = ver detalle readonly
- Enter/refrescar = redibujar
- b/q/volver = volver
- ? = ayuda

## Acciones bloqueadas
- ejecutar smoke sin gate
- ejecutar healthcheck sin gate
- ejecutar repair sin gate
- abrir launcher externo sin gate
- modificar launcher sin gate
- push/fetch/merge automatico
- delete files
- worker real
- API externa
- navegador
- clipboard

## Smoke
- Health Launchers screen: 
OPERATOR_V1_HEALTH_LAUNCHERS
- Detail viewer: 
OPERATOR_V1_DETAIL_VIEWER_READONLY
- Health items: 
1200

## NEXT
E18_VALIDATE_ACTIONABLE_HEALTH_LAUNCHERS_AND_COMMIT_SCOPED
