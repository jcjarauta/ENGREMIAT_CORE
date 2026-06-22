# E06 Root Loop Router Planned Diff NO_APPLY

Estado: PASS
Patched: NO
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Contract: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_LOOP_ROUTER.json
Reader: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-loop-router-reader.ps1
Adapter: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-loop-router-dry-run-adapter.ps1
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer: 
False
Primary Read-Host line: 
11
 | 
function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
Primary switch line: 
13
 | 
# mode=DRY_RUN_ONLY observer; legacy switch/router preserved
Unknown feedback hits: 
1
Help hits: 
2

## Planned patch sketch
```powershell
# ROOT_LOOP_ROUTER_007 planned integration - NO_APPLY
# Punto previsto: dentro del switch principal posterior al Read-Host, no como observer externo.
# Cargar router antes del bucle o al inicio controlado:
$engRootRouterAdapter = "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\root-loop-router-dry-run-adapter.ps1"
if (Test-Path $engRootRouterAdapter) {
  # En apply real, evitar dot-source bloqueado por ExecutionPolicy: usar scriptblock controlado.
  $engRootRouterCode = Get-Content $engRootRouterAdapter -Raw -Encoding UTF8
  . ([scriptblock]::Create($engRootRouterCode))
}

# Dentro del switch principal:
$route = Invoke-EngRootLoopRouterDryRun -InputText $input -ScreenId "root_launcher"
switch ($route.route_id) {
  "root.refresh" { continue }
  "root.help" { <mantener ayuda legacy actual>; continue }
  "root.maintenance" { Write-Host $route.feedback -ForegroundColor Yellow; continue }
  "root.status" { Write-Host $route.feedback -ForegroundColor Yellow; continue }
  "root.unknown" { Write-Host $route.feedback -ForegroundColor Yellow; continue }
  default { <dejar rutas legacy 1..5 b/q en switch actual> }
}
```

## Risks
- NO aplicar automaticamente aun: hay rutas legacy 1..5 y b/q que no deben reescribirse a ciegas.
- La integracion debe entrar dentro del switch principal, no despues de Read-Host.
- Debe evitar dot-source directo por ExecutionPolicy; usar scriptblock controlado si se carga adapter.
- Debe preservar ayuda legacy actual porque ya funciona.
- Debe tratar e/m/desconocido como feedback, no como observer externo.

## Decision
GO_NO_APPLY_PLAN_READY_RECOMMEND_MANUAL_REVIEW_BEFORE_PATCH

## Siguiente
E07_REVIEW_PLANNED_DIFF_AND_DECIDE_APPLY_OR_CLOSE_PREPARED
