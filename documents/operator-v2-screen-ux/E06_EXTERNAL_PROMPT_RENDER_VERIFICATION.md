# E06 External Prompt Render Verification

Estado: PASS
ScreenEngine: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1
Legend OK: 
True
External prompt found: 
True
Best prompt candidate: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-style-reader.ps1
Patched: NO

## Prompt hits
### C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-ux-style-reader.ps1 line 27 score 24 why literal_prompt,prompt_v2_token
```powershell
   24:   if($null -eq $Style){ throw 'Style requerido' }
   25:   if($null -eq $Text){ $Text = '' }
   26:   $legend = [string]$Style.legend.canonical
   27:   return [pscustomobject]@{ has_canonical_legend=$Text.Contains($legend); has_title=($Text.Contains('ENGREMIAT /')); has_menu=($Text.Contains('MENU') -or $Text.Contains('SUBMENU')); has_prompt=($Text.Contains('ENGREMIAT:') -or $Text.Contains('ENGREMIAT_V2:')); text_length=$Text.Length }
   28: }
```
### C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.ScreenEngine.ps1 line 4 score 4 why prompt_v2_token
```powershell
    1: $script:EngV2Root="C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2"
    2: $script:EngCoreRoot="C:\ENGREMIAT_CORE"
    3: "[b/q] volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
    4: $script:EngPrompt="ENGREMIAT_V2"
    5: function Read-EngJson([string]$Path){try{if(Test-Path -LiteralPath $Path){return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}}catch{};return $null}
    6: function Get-EngRegistry{Read-EngJson (Join-Path $script:EngV2Root "contracts\SCREEN_REGISTRY.json")}
    7: function Get-EngScreens{$r=Get-EngRegistry;if($r -and $r.screens){return @($r.screens)};return @()}
    8: function Get-EngScreen([string]$Id){return @(Get-EngScreens|Where-Object{[string]$_.id -eq $Id}|Select-Object -First 1)}
```
### C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\operator\lib\OperatorV2.UI.ps1 line 4 score 4 why prompt_v2_token
```powershell
    1: $script:EngV2Root = "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2"
    2: $script:EngCoreRoot = "C:\ENGREMIAT_CORE"
    3: $script:EngFooter = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
    4: $script:EngPrompt = "ENGREMIAT_V2"
    5: function Read-EngJson { param([string]$Path) try { if(Test-Path -LiteralPath $Path){ return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json } } catch {} return $null }
    6: function Get-EngState { $obs=Read-EngJson (Join-Path $script:EngCoreRoot "reports\observer\latest-observer.json"); $watch=Read-EngJson (Join-Path $script:EngCoreRoot "memory\development\watch-state.json"); return [ordered]@{ observer_status = if($obs){[string]$obs.status}else{"NO_LATEST"}; observer_needs = if($obs){@($obs.needs).Count}else{-1}; watch_status = if($watch){[string]$watch.status}else{"NO_STATE"}; watch_changes = if($watch){[int]$watch.changes_count}else{-1}; watch_tracked = if($watch){[int]$watch.tracked_files}else{-1}; core_root = $script:EngCoreRoot; v2_root = $script:EngV2Root } }
    7: function Show-EngHeader { param([string]$Title,[string]$Route,[string]$Purpose) Clear-Host; Write-Host ("==== ENGREMIAT / " + $Title + " ====") -ForegroundColor Cyan; Write-Host ""; Write-Host "Modo: paralelo / no rompe operador actual"; Write-Host ("Core: " + $script:EngCoreRoot); if($Route){ Write-Host ("Ruta: " + $Route) }; if($Purpose){ Write-Host ("Proposito: " + $Purpose) }; $s=Get-EngState; Write-Host ""; Write-Host ("Observer: " + $s.observer_status + " | needs=" + $s.observer_needs); Write-Host ("Watch: " + $s.watch_status + " | changes=" + $s.watch_changes + " | tracked=" + $s.watch_tracked); Write-Host "" }
    8: function Show-EngFooter { Write-Host ""; Write-Host $script:EngFooter -ForegroundColor Gray; Write-Host "" }
```

## Decision
GO_CLOSE_SCREEN_UX_WITH_EXTERNAL_PROMPT_ACCEPTED

## Siguiente
E07_MANUAL_SCREEN_UX_CHECK_AND_CLOSE_IF_PASS
