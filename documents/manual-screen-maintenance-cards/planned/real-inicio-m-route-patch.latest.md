# E05I prepare m contextual card on real INICIO prompt no apply

Decision: 
GO_REAL_INICIO_PROMPT_M_ROUTE_PATCH_READY_NO_APPLY
Parse before: 
True
Selected parse: 
True
Anchor line: 
35
Anchor variable: $
c
Has function: 
True
Has hint: 
True
Inserted: 
True
Guard present selected: 
True

## Anchor context
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
   47:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   48:   if (Test-Path $operatorLauncher) {
   49:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   50:   } else {
   51:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   52:   }
   53:   return

## Paths
inicio=
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
selected=
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.real-inicio-m-route-selected.latest.ps1

## Next
E05J_APPLY_REAL_INICIO_PROMPT_M_ROUTE_WITH_GATE
