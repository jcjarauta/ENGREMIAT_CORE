# E03 Review Home Render Binding Plan And Trace Call Chain

Estado: PASS
Patched: NO
Root patched: NO
ScreenEngine patched: NO
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1

## Diagnostico
Show-EngRootMenu era demasiado pequena para aplicar bind directo. Se revisa cadena de llamadas y candidatas reales de render.

## Show-EngRootMenu
- lines: 
23
-
25
- length: 
3
- calls: 
Get-EngScreens, Get-EngScreen, Get-EngLevelSortKey, Show-EngFooter, Read-EngCmd, Show-EngMaintenance, Show-EngScreen

```powershell
function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}}

# LIVE_CONTEXT_SCREEN_010_RENDERER_BEGIN
```

## Candidatos por llamadas desde Show-EngRootMenu
- score=55 | lines=22-22 | len=1 | Show-EngScreen | why=output,template
- score=30 | lines=11-11 | len=1 | Show-EngFooter | why=output
- score=30 | lines=14-15 | len=2 | Show-EngMaintenance | why=output
- score=25 | lines=8-8 | len=1 | Get-EngScreen | why=template
- score=25 | lines=7-7 | len=1 | Get-EngScreens | why=template
- score=0 | lines=9-9 | len=1 | Get-EngLevelSortKey | why=
- score=0 | lines=12-12 | len=1 | Read-EngCmd | why=

## Candidatos globales de render
- score=280 | lines=23-25 | len=3 | Show-EngRootMenu | why=title,menu,root,output,template,name
- score=140 | lines=19-19 | len=1 | Show-EngLayoutRulesScreen | why=menu,output,template,name
- score=140 | lines=18-18 | len=1 | Show-EngScreenStatesScreen | why=menu,output,template,name
- score=140 | lines=16-16 | len=1 | Show-EngBody | why=menu,output,template,name
- score=140 | lines=17-17 | len=1 | Show-EngUxRegistryScreen | why=menu,output,template,name
- score=80 | lines=21-21 | len=1 | Show-EngProgressPendingScreen | why=output,template,name
- score=80 | lines=20-20 | len=1 | Show-EngPendingUxRepairsScreen | why=output,template,name
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

## Candidato resuelto
- name: Show-EngRootMenu
- lines: 23-25
- score: 280
- why: title,menu,root,output,template,name

### Preview
```text
function Show-EngRootMenu{while($true){$roots=@(Get-EngScreens|Where-Object{[string]$_.level -notmatch "\."}|Sort-Object {Get-EngLevelSortKey $_});$map=@{};Clear-Host;Write-Host "==== ENGREMIAT / OPERADOR V2 ====" -ForegroundColor Cyan;Write-Host "";Write-Host ("Root: "+$script:EngV2Root);Write-Host "";Write-Host "MENU";$i=1;foreach($s in $roots){Write-Host (" ["+$i+"] "+$s.title+"  ["+$s.status+" · "+$s.progress+"%]");$map[[string]$i]=$s.id;$i++};Show-EngFooter;$cmd=Read-EngCmd;switch($cmd){"refresh"{continue}"b"{break}"q"{break}"m"{Show-EngMaintenance;continue}"?"{Write-Host "Selecciona una pantalla principal. Enter refresca.";Start-Sleep -Seconds 1;continue}default{if($map.ContainsKey($cmd)){Show-EngScreen $map[$cmd];continue};Write-Host "Opcion no reconocida" -ForegroundColor Yellow;Start-Sleep -Milliseconds 700}}}} |  | # LIVE_CONTEXT_SCREEN_010_RENDERER_BEGIN
```

## Siguiente
E04_DUMP_PRIMARY_AND_CALL_CHAIN_FOR_MANUAL_MAPPING
