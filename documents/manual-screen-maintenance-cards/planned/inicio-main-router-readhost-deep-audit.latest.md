# E05G deep audit INICIO main router ReadHost no apply

## Decision
NO_GO_MAIN_ROUTER_NOT_CLEAR

## Diagnosis
MULTIPLE_READHOSTS_FIRST_ONE_NOT_MAIN_PROMPT

## Critical finding
- first_readhost_var: 
NONE
- candidate_main_readhost_line: 
43
- candidate_main_readhost_var: 
NONE
- main_prompt_line: 
-1

## Checks
- parse_ok: 
True
- has_function_New_EngremiatMaintenanceCard: 
True
- has_hint_m: 
True
- has_old_m_route: 
True
- has_bad_guard_E05C: 
False

## ReadHosts
- line 29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
- line 31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
- line 32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
- line 33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
- line 34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
- line 35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
- line 38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
- line 39:   $exp = Read-Host "Esperado"
- line 40:   $obs = Read-Host "Observado / que falla"
- line 41:   $act = Read-Host "Accion realizada antes del fallo"
- line 43:   Read-Host "Enter para volver a INICIO" | Out-Null

## Help/prompts
- line 30 [SCREEN_TITLE,HELP_LINE,FLOW_OR_UNKNOWN]: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
- line 30 [SCREEN_TITLE,HELP_LINE,FLOW_OR_UNKNOWN]: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
- line 32 [READHOST,HELP_LINE,FLOW_OR_UNKNOWN,NORMALIZE]: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}

## Normalizers
- line 31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
- line 32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
- line 35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}

## Command compares
- line 17:   if($null -eq $Q){ $Q = [pscustomobject]@{ status="OPEN"; cards=@() } }
- line 36: if ($c -eq "m") {
- line 42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
- line 46: if ($c -eq '5') {

## Unknown handlers
- line 32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
- line 35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}

## Contexts
## Router context windows
### around line 17
    7:   $Index = Join-Path $Base "MAINTENANCE_CARDS_INDEX.md"
    8:   foreach($p in @($Base,$Cards)){ if(!(Test-Path $p)){ New-Item -ItemType Directory -Force -Path $p | Out-Null } }
    9:   $Id = "MCARD-" + (Get-Date -Format "yyyyMMdd-HHmmss")
   10:   if([string]::IsNullOrWhiteSpace($Severity)){ $Severity = "MEDIUM" }
   11:   $CardPath = Join-Path $Cards ($Id + ".md")
   12:   @("# " + $Id,"","## Identidad","- card_id: " + $Id,"- screen_id: " + $ScreenId,"- route: " + $Route,"- severity: " + $Severity,"- status: OPEN","","## Evidencia humana","- expected: " + $Expected,"- observed: " + $Observed,"- action_done: " + $ActionDone,"","## Diagnostico inicial","- suspected_file: PENDING","- suspected_function: PENDING","- risk: " + $Severity,"","## Reparacion propuesta","- minimal_frontier: PENDING","- no_apply_first: yes","- rollback_needed: PENDING") | Set-Content -Encoding UTF8 $CardPath
   13:   if(!(Test-Path $Index)){ @("# Indice tarjetas mantenimiento","","## Tarjetas") | Set-Content -Encoding UTF8 $Index }
   14:   Add-Content -Encoding UTF8 $Index ("- OPEN | " + $Severity + " | " + $ScreenId + " | " + $Id + " | " + $CardPath)
   15:   $Obj = [ordered]@{ card_id=$Id; screen_id=$ScreenId; route=$Route; severity=$Severity; status="OPEN"; expected=$Expected; observed=$Observed; action_done=$ActionDone; created_at=(Get-Date).ToString("s"); card_path=$CardPath }
   16:   if(Test-Path $Queue){ try { $Q = Get-Content $Queue -Raw -Encoding UTF8 | ConvertFrom-Json } catch { $Q = $null } } else { $Q = $null }
   17:   if($null -eq $Q){ $Q = [pscustomobject]@{ status="OPEN"; cards=@() } }
   18:   $Arr = @($Q.cards); $Arr += $Obj; $Q.cards = $Arr; $Q | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $Queue
   19:   Write-Host ("OK tarjeta_mantenimiento_creada=" + $CardPath) -ForegroundColor Green
   20:   return $CardPath
   21: }
   22: 
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'

### around line 29
   19:   Write-Host ("OK tarjeta_mantenimiento_creada=" + $CardPath) -ForegroundColor Green
   20:   return $CardPath
   21: }
   22: 
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"

### around line 30
   20:   return $CardPath
   21: }
   22: 
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"

### around line 31
   21: }
   22: 
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"

### around line 32
   22: 
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null

### around line 33
   23: $ErrorActionPreference='Stop'
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null

### around line 34
   24: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue

### around line 35
   25: $Core='C:\ENGREMIAT_CORE'
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }

### around line 36
   26: $LauncherDir=Join-Path $Core 'tools\launcher'
   27: $CardBase=Join-Path $Core 'documents\module-cards'
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {

### around line 38
   28: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {

### around line 39
   29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher

### around line 40
   30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {

### around line 41
   31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {
   51:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow

### around line 42
   32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {
   51:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   52:   }

### around line 43
   33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {
   51:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   52:   }
   53:   return

### around line 46
   36: if ($c -eq "m") {
   37:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   38:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   39:   $exp = Read-Host "Esperado"
   40:   $obs = Read-Host "Observado / que falla"
   41:   $act = Read-Host "Accion realizada antes del fallo"
   42:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   43:   Read-Host "Enter para volver a INICIO" | Out-Null
   44:   continue
   45: }
   46: if ($c -eq '5') {
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {
   51:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   52:   }
   53:   return
   54: }


## Recommendation
E05H debe preparar parche NO_APPLY solo si candidate_main_readhost_var es claro. La reparación debe insertarse después del Read-Host principal, no después del primer Read-Host del archivo.

## Rule
NO_APPLY. No modifica INICIO real ni git.

## Next
E05H_PREPARE_M_GUARD_ON_MAIN_PROMPT_READHOST_NO_APPLY
