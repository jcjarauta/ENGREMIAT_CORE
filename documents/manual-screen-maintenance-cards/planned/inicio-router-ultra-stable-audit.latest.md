# E05G ultra stable audit INICIO router no apply

Decision: 
GO_MAIN_ROUTER_CANDIDATE_FOUND_NO_APPLY
Parse OK: 
True
Inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
Main prompt line: 
30
Candidate ReadHost line: 
38
Candidate variable: $
sev
Candidate: 
38: $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"

## ReadHost lines
29: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
31: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
33: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
34: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
38: $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
39: $exp = Read-Host "Esperado"
40: $obs = Read-Host "Observado / que falla"
41: $act = Read-Host "Accion realizada antes del fallo"
43: Read-Host "Enter para volver a INICIO" | Out-Null

## Prompt lines
30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}

## Help lines
30: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}

## Unknown handler lines
32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}

## Command compare lines
32: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
35: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
36: if ($c -eq "m") {
46: if ($c -eq '5') {

## Next
E05H_PREPARE_M_CONTEXTUAL_CARD_ON_REAL_ROUTER_NO_APPLY
