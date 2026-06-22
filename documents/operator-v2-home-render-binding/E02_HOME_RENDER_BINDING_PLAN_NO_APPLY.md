# E02 Home Render Binding Plan No Apply

Estado: PASS
Patched: NO
Root patched: NO
ScreenEngine patched: NO
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
Function: Show-EngRootMenu
Function lines: 
23
-
25
Insert after line: 
23
Insert strategy: 
AFTER_ROOT_LINE_BEFORE_MENU
Already bound: 
False
Safe to apply: 
False
Decision: 
NO_GO_REVIEW_PLANNED_INSERT_MANUALLY

## Validacion funcion
- Has title: 
True
- Has root line: 
True
- Has menu: 
True
- Has prompt: 
False
- Renderer exists: True
- Template item exists: True
- Overview binding ready: 
True

## Diff planificado
```text
L19: function Show-EngLayoutRulesScreen{while($true){Show-EngHeader "REGLAS VISUALES" "1.2.3 · layout_rules" "PLANNED" 20 "Reglas simples de lectura";Write-Host "REGLAS:";Write-Host " - Una pantalla = una decision clara.";Write-Host " - Menu corto: maximo 5 opciones visibles.";Write-Host " - Listas largas solo como resumen + accion.";Write-Host " - Footer corto y comun.";Write-Host " - Context Guardian obligatorio antes de parchear.";Write-Host "";Write-Host "SIGUIENTE:";Write-Host " - Convertir reglas en validador automatico.";Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Reglas UX actuales del operador.";Start-Sleep -Seconds 1;continue}default{Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
L20: function Show-EngPendingUxRepairsScreen{while($true){$screens=Get-EngScreens;$items=@();foreach($s in ($screens|Sort-Object {Get-EngLevelSortKey $_})){foreach($p in @($s.pending)){$items+=[pscustomobject]@{level=$s.level;title=$s.title;pending=$p;status=$s.status}}};Show-EngHeader "REPARACIONES UX" "1.2.4 · pending_ux_repairs" "ACTIVE" 35 "Pendientes priorizados";Write-Host ("Pendientes totales: "+$items.Count);Write-Host "";Write-Host "TOP 8:";foreach($x in ($items|Select-Object -First 8)){Write-Host (" - "+$x.level+" "+$x.title+": "+$x.pending)};if($items.Count -gt 8){Write-Host (" - +"+($items.Count-8)+" pendientes mas")};Write-Host "";Write-Host "GUARDIAN:";Write-Host " - active_root debe coincidir antes de parchear.";Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Lista corta de reparaciones UX.";Start-Sleep -Seconds 1;continue}default{Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
L21: function Show-EngProgressPendingScreen{while($true){$screens=Get-EngScreens;$total=$screens.Count;$avg=0;if($total -gt 0){$avg=[math]::Round((($screens|ForEach-Object{[int]$_.progress}|Measure-Object -Average).Average),2)};$pendingCount=0;foreach($s in $screens){$pendingCount+=@($s.pending).Count};Show-EngHeader "PROGRESO Y PENDIENTES" "1.3 · progreso_pendientes" "ACTIVE" 25 "Resumen operativo";Write-Host ("Pantallas: "+$total);Write-Host ("Progreso medio: "+$avg+"%");Write-Host ("Pendientes: "+$pendingCount);Write-Host "";Write-Host "ACCIONES:";Write-Host " [e] Estados";Write-Host " [r] Reparaciones UX";Write-Host " [x] Registry";Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"e"{Show-EngScreenStatesScreen;continue}"r"{Show-EngPendingUxRepairsScreen;continue}"x"{Show-EngUxRegistryScreen;continue}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Resumen global de progreso.";Start-Sleep -Seconds 1;continue}default{Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
L22: function Show-EngScreen([string]$Id){if($Id -eq "progreso_pendientes"){Show-EngProgressPendingScreen;return};if($Id -eq "ux_registry"){Show-EngUxRegistryScreen;return};if($Id -eq "screen_states"){Show-EngScreenStatesScreen;return};if($Id -eq "layout_rules"){Show-EngLayoutRulesScreen;return};if($Id -eq "pending_ux_repairs"){Show-EngPendingUxRepairsScreen;return};$s=Get-EngScreen $Id;if(!$s){Clear-Host;Write-Host ("Pantalla no encontrada: "+$Id) -ForegroundColor Yellow;Read-Host "Enter para volver"|Out-Null;return};while($true){Show-EngHeader $s.title ($s.level+" · "+$s.id) $s.status ([int]$s.progress) $s.purpose;$map=Show-EngBody $s;Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Show-EngHelp $s;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
L23: function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
L24: 
L25: # LIVE_CONTEXT_SCREEN_010_RENDERER_BEGIN
L26: function Get-EngOperatorV2LiveContextOverviewTemplateItem {
L27:   $style = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\contracts\SCREEN_UX_STYLE.json'
L28:   if(!(Test-Path $style)){ return $null }
L29:   try {
--- planned insert after line 23 ---
+   # HOME_RENDER_BINDING_011_BEGIN
+   Show-EngOperatorV2LiveContextOverviewPanel
+   # HOME_RENDER_BINDING_011_END
```

## Bloque previsto
```powershell
  # HOME_RENDER_BINDING_011_BEGIN
  Show-EngOperatorV2LiveContextOverviewPanel
  # HOME_RENDER_BINDING_011_END
```

## Siguiente
E03_MANUAL_REVIEW_HOME_RENDER_BINDING_PLAN
