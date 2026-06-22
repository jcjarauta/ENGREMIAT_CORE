# E05M show INICIO router direct no apply

Decision: ROUTER_DIRECT_EXCERPT_READY_NO_APPLY
Inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
Range: 
25
-
67

## Router excerpt
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
   36: # AUTO_MAINTENANCE_CARD_REAL_INICIO_PROMPT_E05I_BEGIN
   37: $__eng_inicio_cmd = [string]$c
   38: if ($__eng_inicio_cmd.Trim().ToLowerInvariant() -eq "m") {
   39:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   40:   $sev2 = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   41:   $exp2 = Read-Host "Esperado"
   42:   $obs2 = Read-Host "Observado / que falla"
   43:   $act2 = Read-Host "Accion realizada antes del fallo"
   44:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp2 -Observed $obs2 -ActionDone $act2 -Severity $sev2 | Out-Null
   45:   Read-Host "Enter para volver a INICIO" | Out-Null
   46:   continue
   47: }
   48: # AUTO_MAINTENANCE_CARD_REAL_INICIO_PROMPT_E05I_END
   49: if ($c -eq "m") {
   50:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
   51:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   52:   $exp = Read-Host "Esperado"
   53:   $obs = Read-Host "Observado / que falla"
   54:   $act = Read-Host "Accion realizada antes del fallo"
   55:   New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
   56:   Read-Host "Enter para volver a INICIO" | Out-Null
   57:   continue
   58: }
   59: if ($c -eq '5') {
   60:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   61:   if (Test-Path $operatorLauncher) {
   62:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   63:   } else {
   64:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   65:   }
   66:   return
   67: }

## Next
E05N_REPAIR_OR_ROLLBACK_FROM_DIRECT_ROUTER_EXCERPT_NO_APPLY
