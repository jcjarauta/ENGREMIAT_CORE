# E05 Bind Live Context Resource To Screen Template

Estado: PASS
Root patched: NO
ScreenEngine patched: NO
Template contract patched: SI
Style contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json
Backup style: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\backups\guarded-write\SCREEN_UX_STYLE.before-E05_BIND_LIVE_CONTEXT_RESOURCE_TO_SCREEN_TEMPLATE_GUARDED_WRITE-20260622-062839.json.bak
Resource: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\OPERATOR_V2_LIVE_CONTEXT_RESOURCE.json
Reader: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-live-context-resource-reader.ps1
Backup reader: 
Plan command: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\plan-v2.ps1

## Resultado
El informe vivo del plan queda enlazado como recurso de plantilla en SCREEN_UX_STYLE.json. Esto permite que Operador V2 lo use como hoja de tareas viva sin parchear texto visible ni tocar ENGREMIAT.ps1.

## Validacion
- Binding detectado: 
True
- Topics plan-v2: 
9
- Functions plan-v2: 
6

## Comandos
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\operator-v2-live-context-resource-reader.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\plan-v2.ps1"
```

## Siguiente
E06_SHOW_LIVE_CONTEXT_IN_OPERATOR_V2_OVERVIEW_READONLY_OR_TEMPLATE_RENDER
