# E04 Primary And Call Chain Dump

Estado: PASS
Patched: NO
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1

## Lectura
Show-EngRootMenu es demasiado corto para insertar el panel directamente. Este volcado muestra la cadena real para elegir el punto de render seguro.

## Show-EngRootMenu
- lines: 
23
-
25
- length: 
3
- calls detected: 
Get-EngScreens, Get-EngLevelSortKey, Show-EngFooter, Read-EngCmd, Show-EngMaintenance, Show-EngScreen

```powershell
function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}

# LIVE_CONTEXT_SCREEN_010_RENDERER_BEGIN
```

## Funciones llamadas desde Show-EngRootMenu

### Show-EngScreen
- lines: 22-22
- length: 1
- score: 55
- why: output,template
```powershell
function Show-EngScreen([string]$Id){if($Id -eq "progreso_pendientes"){Show-EngProgressPendingScreen;return};if($Id -eq "ux_registry"){Show-EngUxRegistryScreen;return};if($Id -eq "screen_states"){Show-EngScreenStatesScreen;return};if($Id -eq "layout_rules"){Show-EngLayoutRulesScreen;return};if($Id -eq "pending_ux_repairs"){Show-EngPendingUxRepairsScreen;return};$s=Get-EngScreen $Id;if(!$s){Clear-Host;Write-Host ("Pantalla no encontrada: "+$Id) -ForegroundColor Yellow;Read-Host "Enter para volver"|Out-Null;return};while($true){Show-EngHeader $s.title ($s.level+" · "+$s.id) $s.status ([int]$s.progress) $s.purpose;$map=Show-EngBody $s;Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{return}"q"{return}"m"{Show-EngMaintenance;continue}"?"{Show-EngHelp $s;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}
```

### Show-EngMaintenance
- lines: 14-15
- length: 2
- score: 30
- why: output
```powershell
function Show-EngMaintenance{Show-EngHeader "MANTENIMIENTO V2" "mantenimiento" "PLANNED" 0 "Mantenimiento contextual pendiente";Write-Host "Pendiente: conectar tarjetas de mantenimiento.";Show-EngFooter;Read-Host "Enter para volver"|Out-Null}
Write-Host "[b/q] volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
```

### Show-EngFooter
- lines: 11-11
- length: 1
- score: 30
- why: output
```powershell
function Show-EngFooter{Write-Host "";Write-Host $script:EngFooter -ForegroundColor Gray;Write-Host ""}
```

### Get-EngScreens
- lines: 7-7
- length: 1
- score: 25
- why: template
```powershell
function Get-EngScreens{$r=Get-EngRegistry;if($r -and $r.screens){return @($r.screens)};return @()}
```

### Read-EngCmd
- lines: 12-12
- length: 1
- score: 0
- why: 
```powershell
function Read-EngCmd{$x=Read-Host $script:EngPrompt;if([string]::IsNullOrWhiteSpace($x)){return "refresh"};return $x.Trim().ToLowerInvariant()}
```

### Get-EngLevelSortKey
- lines: 9-9
- length: 1
- score: 0
- why: 
```powershell
function Get-EngLevelSortKey($s){$parts=(([string]$s.level).Split("."));$nums=@();foreach($p in $parts){$n=0;[void][int]::TryParse(($p -replace "[^0-9]",""),[ref]$n);$nums+=("{0:D4}" -f $n)};return ($nums -join ".")}
```

## Candidatos globales si la cadena no basta
- score=140 | lines=17-17 | len=1 | Show-EngUxRegistryScreen | why=menu,output,template,name
- score=140 | lines=19-19 | len=1 | Show-EngLayoutRulesScreen | why=menu,output,template,name
- score=140 | lines=18-18 | len=1 | Show-EngScreenStatesScreen | why=menu,output,template,name
- score=140 | lines=16-16 | len=1 | Show-EngBody | why=menu,output,template,name
- score=80 | lines=20-20 | len=1 | Show-EngPendingUxRepairsScreen | why=output,template,name
- score=80 | lines=21-21 | len=1 | Show-EngProgressPendingScreen | why=output,template,name
- score=80 | lines=22-22 | len=1 | Show-EngScreen | why=output,template,name
- score=80 | lines=48-72 | len=25 | Show-EngOperatorV2LiveContextOverviewPanel | why=output,template,name
- score=55 | lines=11-11 | len=1 | Show-EngFooter | why=output,name
- score=55 | lines=13-13 | len=1 | Show-EngHeader | why=output,name
- score=55 | lines=14-15 | len=2 | Show-EngMaintenance | why=output,name
- score=50 | lines=8-8 | len=1 | Get-EngScreen | why=template,name
- score=50 | lines=7-7 | len=1 | Get-EngScreens | why=template,name
- score=25 | lines=6-6 | len=1 | Get-EngRegistry | why=template
- score=25 | lines=26-37 | len=12 | Get-EngOperatorV2LiveContextOverviewTemplateItem | why=template
- score=25 | lines=10-10 | len=1 | Get-EngChildren | why=template

## Mejor candidato provisional
- Show-EngScreen
- lines: 22-22
- length: 1

## Siguiente
E05_PREPARE_BIND_ON_CONFIRMED_RENDER_BODY_NO_APPLY
