# E05 Confirmed Render Body Bind Plan No Apply

Estado: PASS
Patched: NO
Root patched: NO
ScreenEngine patched: NO
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
Decision: 
GO_CREATE_HOME_PREVIEW_COMPOSER_NO_SCREEN_PATCH

## Lectura
Show-EngRootMenu y Show-EngScreen son demasiado compactas para insertar panel directamente con seguridad. La ruta correcta es componer una preview home desde contrato/plantilla y solo despues decidir si el ScreenEngine debe llamarla.

## Funciones objetivo

### Show-EngRootMenu
- lines: 23-25
- length: 3
- line_text: function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
```powershell
function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}

# LIVE_CONTEXT_SCREEN_010_RENDERER_BEGIN
```

### Show-EngScreen
- lines: 22-22
- length: 1
- line_text: function Show-EngScreen([string]$Id){if($Id -eq "progreso_pendientes"){Show-EngProgressPendingScreen;return};if($Id -eq "ux_registry"){Show-EngUxRegistryScreen;return};if($Id -eq "screen_states"){Show-EngScreenStatesScreen;return};if($Id -eq "layout_rules"){Show-EngLayoutRulesScreen;return};if($Id -eq "pending_ux_repairs"){Show-EngPendingUxRepairsScreen;return};$s=Get-EngScreen $Id;if(!$s){Clear-Host;Write-Host ("Pantalla no encontrada: "+$Id) -ForegroundColor Yellow;Read-Host "Enter para volver"|Out-Null;return};while($true){Show-EngHeader $s.title ($s.level+" · "+$s.id) $s.status ([int]$s.progress) $s.purpose;$map=Show-EngBody $s;Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Show-EngHelp $s;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
```powershell
function Show-EngScreen([string]$Id){if($Id -eq "progreso_pendientes"){Show-EngProgressPendingScreen;return};if($Id -eq "ux_registry"){Show-EngUxRegistryScreen;return};if($Id -eq "screen_states"){Show-EngScreenStatesScreen;return};if($Id -eq "layout_rules"){Show-EngLayoutRulesScreen;return};if($Id -eq "pending_ux_repairs"){Show-EngPendingUxRepairsScreen;return};$s=Get-EngScreen $Id;if(!$s){Clear-Host;Write-Host ("Pantalla no encontrada: "+$Id) -ForegroundColor Yellow;Read-Host "Enter para volver"|Out-Null;return};while($true){Show-EngHeader $s.title ($s.level+" · "+$s.id) $s.status ([int]$s.progress) $s.purpose;$map=Show-EngBody $s;Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Show-EngHelp $s;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
```

### Show-EngOperatorV2LiveContextOverviewPanel
- lines: 48-72
- length: 25
- line_text: function Show-EngOperatorV2LiveContextOverviewPanel {
```powershell
function Show-EngOperatorV2LiveContextOverviewPanel {
  $item = Get-EngOperatorV2LiveContextOverviewTemplateItem
  $data = Get-EngOperatorV2LiveContextOverviewData
  if($null -eq $item -or $null -eq $data){
    Write-Host "VISION GENERAL: contexto vivo no disponible" -ForegroundColor Yellow
    return
  }
  Write-Host ""
  Write-Host "VISION GENERAL / HOJA DE TAREAS" -ForegroundColor Cyan
  Write-Host (" Readiness plan: "+$data.readiness+"%") -ForegroundColor Green
  Write-Host (" Root estable: "+$data.root_stable+" | Wrapper LAB: "+$data.wrapper_lab+" | Feedback wrapper: "+$data.feedback_inside_wrapper) -ForegroundColor Green
  Write-Host (" Cerrados: "+$data.closed_count+" | Activos/LAB: "+$data.active_count+" | Pendientes: "+$data.pending_count+" | Total: "+$data.topics_total) -ForegroundColor Cyan
  Write-Host (" NEXT: "+$data.next_recommended) -ForegroundColor Magenta
  Write-Host ""
  Write-Host " Tareas principales:" -ForegroundColor Cyan
  foreach($t in @($data.topics | Select-Object -First 8)){
    $color = "Gray"
    if($t.status -match "CLOSED"){ $color = "Green" } elseif($t.status -match "ACTIVE|LAB|PREPARED"){ $color = "Yellow" }
    Write-Host ("  ["+$t.status+"] "+$t.area+" · "+$t.readiness+"% · falta: "+$t.missing) -ForegroundColor $color
  }
  Write-Host ""
  Write-Host " Acceso directo: plan / informe / estado-plan / 13" -ForegroundColor Cyan
}
# LIVE_CONTEXT_SCREEN_010_RENDERER_END

```

## Llamadas detectadas desde Show-EngScreen
- Get-EngScreen
- Show-EngFooter
- Read-EngCmd
- Show-EngHeader
- Show-EngMaintenance
- Show-EngBody
- Show-EngUxRegistryScreen
- Show-EngScreenStatesScreen
- Show-EngLayoutRulesScreen
- Show-EngPendingUxRepairsScreen
- Show-EngProgressPendingScreen

## Contratos candidatos reales
- score=360 | json=True | why=operator-title,prompt,overview-template-item,live-context-policy,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json
- score=160 | json=True | why=dev-system-item,reports-item,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.json
- score=160 | json=True | why=dev-system-item,reports-item,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e05b-20260621-175913.json
- score=160 | json=True | why=dev-system-item,reports-item,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e04b-20260621-175346.json
- score=160 | json=True | why=dev-system-item,reports-item,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_REGISTRY.before-e03-20260621-175039.json
- score=120 | json=True | why=prompt,template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\OPERATOR_V2_UI_CONTRACT.json
- score=60 | json=True | why=live-context-policy | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\OPERATOR_V2_LIVE_CONTEXT_RESOURCE.json
- score=30 | json=True | why=template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\COMMAND_FEEDBACK.json
- score=30 | json=True | why=template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_LOOP_ROUTER.json
- score=30 | json=True | why=template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\NAVIGATION_COMMANDS.json
- score=30 | json=True | why=template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_ARCHITECTURE_CONTRACT.json
- score=30 | json=True | why=template-structure | C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\ROOT_WRAPPER.json

## Referencias JSON en ScreenEngine
- \Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json
- contracts\SCREEN_REGISTRY.json

## Estado overview/template
- overview binding_ready: True
- style binding: True
- topics: 9
- functions: 6

## Siguiente
E06_CREATE_SAFE_HOME_PREVIEW_COMPOSER_USING_TEMPLATE_ITEM_NO_SCREEN_PATCH
