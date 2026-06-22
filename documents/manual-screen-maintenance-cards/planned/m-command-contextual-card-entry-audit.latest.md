# E02 audit m command and contextual card entry no apply

## Decision
NO_GO_M_COMMAND_ROUTE_NOT_CONFIRMED

## Principle
La tarjeta de mantenimiento debe poder crearse desde la pantalla donde se detecta el fallo. El comando m debe capturar contexto: screen_id/ruta/pantalla actual/accion/observado/esperado.

## Target rows
- master exists=True parse_ok=True has_m_hint=False has_m_route=False has_cards=False path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- inicio exists=True parse_ok=True has_m_hint=True has_m_route=False has_cards=True path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- operator exists=True parse_ok=True has_m_hint=True has_m_route=False has_cards=True path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Candidate screen host
inicio :: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1

## Contexts
## master context
### around line 9
    1: $ErrorActionPreference="Stop"
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core="C:\ENGREMIAT_CORE"
    4: $Registry=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-REGISTRY.json"
    5: $Health=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1"
    6: function UX($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
    8: function OpenLauncher($id){$reg=Get-Content $Registry -Raw|ConvertFrom-Json;$l=$reg.launchers|Where-Object{$_.id -eq $id}|Select-Object -First 1;if($null -eq $l){UX ("Launcher no registrado: "+$id) Red;Start-Sleep -Milliseconds 900;return};$p=Join-Path $Core $l.path;if(!(Test-Path $p)){UX ("No existe: "+$p) Red;Start-Sleep -Milliseconds 900;return};ParseOk $p;& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    9: while($true){Clear-Host;UX "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan;UX "Ruta: C:\ENGREMIAT_CORE\ENGREMIAT.ps1" DarkGray;UX "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray;UX "";UX "[1] Inicio operador" Cyan;UX "[2] Proyectos" Cyan;UX "[3] Memoria y documentacion" Cyan;UX "[4] Data Intake" Cyan;UX "[5] Health launchers" Cyan;UX "[b/q] salir" DarkGray;$op=Read-Host "ENGREMIAT";if([string]::IsNullOrWhiteSpace($op)){continue};if($op -eq "1"){OpenLauncher "inicio"}elseif($op -eq "2"){OpenLauncher "proyectos"}elseif($op -eq "3"){OpenLauncher "documentacion"}elseif($op -eq "4"){OpenLauncher "data-intake"}elseif($op -eq "5"){& powershell -NoProfile -ExecutionPolicy Bypass -File $Health;Read-Host "HEALTH"}elseif($op -eq "b" -or $op -eq "q"){break}else{UX "opcion no reconocida" Yellow;Start-Sleep -Milliseconds 700}}

## inicio context
### around line 8
    1: $ErrorActionPreference='Stop'
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core='C:\ENGREMIAT_CORE'
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {

### around line 9
    1: $ErrorActionPreference='Stop'
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core='C:\ENGREMIAT_CORE'
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {
   17:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher

### around line 12
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {
   17:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   18:   } else {
   19:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   20:   }

### around line 7
    1: $ErrorActionPreference='Stop'
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core='C:\ENGREMIAT_CORE'
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"

### around line 10
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core='C:\ENGREMIAT_CORE'
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {
   17:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   18:   } else {

### around line 11
    3: $Core='C:\ENGREMIAT_CORE'
    4: $LauncherDir=Join-Path $Core 'tools\launcher'
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {
   17:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   18:   } else {
   19:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow

### around line 13
    5: $CardBase=Join-Path $Core 'documents\module-cards'
    6: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function RunPs1($p){if(!(Test-Path $p)){W "NO_GO falta launcher: $p" Red;Read-Host 'Enter';return};& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    8: function Header(){Clear-Host;W '==== ENGREMIAT / INICIO ====' Cyan;W 'Ruta: INICIO' DarkCyan;W 'Rol: hub humano principal del operador' DarkCyan;W 'Principio: local-first | workers OFF | worker real' DarkCyan;W '';W '[1] Proyectos' White;W '[2] Memoria y documentacion' White;W '[3] Control y estado' White;W '[4] Launchers y configuracion' White;W '[5] Operador y workers' Yellow;W '[6] Tarjetas' White;W '[?] Ayuda' White;W '[b/q] salir | m = mantenimiento | Enter = refrescar' DarkGray}
    9: function StatusPanel(){Clear-Host;W '==== CONTROL Y ESTADO ====' Cyan;W 'Estado compacto del operador local.' DarkCyan;W '';$schema=Join-Path $CardBase 'module-linked-card.schema.json';$index=Join-Path $CardBase 'module-linked-card.index.json';$flow=Join-Path $CardBase 'card-to-module-flow.json';$checker=Join-Path $Core 'tools\module-cards\check-card-to-module-flow.ps1';$view=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1';W 'OK entrada humana: .\ENGREMIAT.cmd' Green;W 'OK launchers: usar [4] para health' Green;W 'PAUSADO worker real: no ejecutar hasta cerrar operador' Yellow;if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){W 'OK canon tarjetas-modulos: schema + index + flow + checker' Green;W 'REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI' Magenta}else{W 'WARN canon tarjetas-modulos incompleto' Yellow};if(Test-Path $view){W 'OK vista tarjetas: [6] Tarjetas' Green}else{W 'WARN vista tarjetas no enlazada' Yellow};W 'FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas' Magenta;W '';W 'Siguiente recomendado: revisar Tarjetas o Launchers/configuracion.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   10: function LauncherTools(){while($true){Clear-Host;W '==== LAUNCHERS Y CONFIGURACION ====' Cyan;W 'Ruta: INICIO > Launchers y configuracion' DarkCyan;W '';W '[1] Health launchers' White;W '[2] Helper update dry-run' White;W '[3] Data Intake' White;W '[b] volver | Enter = refrescar' DarkGray;$x=Read-Host 'CONFIG';if([string]::IsNullOrWhiteSpace($x)){continue};switch($x.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-HEALTH.ps1');Read-Host 'Enter'}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1');Read-Host 'Enter'}'3'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1')}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   11: function WorkersPaused(){Clear-Host;W '==== OPERADOR Y WORKERS ====' Cyan;W 'Estado: PAUSADO' Yellow;W '';W 'Worker real pausado tras E80.' Yellow;W 'Siguiente solo cuando cerremos navegacion y control humano.' Yellow;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   12: function Help(){Clear-Host;W '==== AYUDA / INICIO ====' Cyan;W 'Enter refresca la pantalla actual.' DarkGray;W 'b/q vuelve o sale segun pantalla.' DarkGray;W '[1] Proyectos: cartera y acciones locales.' Gray;W '[2] Memoria/documentacion: conocimiento del sistema.' Gray;W '[3] Control y estado: resumen operativo y canon tarjetas-modulos.' Gray;W '[4] Launchers/configuracion: health y helper.' Gray;W '[5] Workers: pausado por seguridad.' Gray;W '[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA.' Gray;W '';W 'Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos.' Magenta;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   13: while($true){Header;$c=Read-Host 'INICIO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1')}'2'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1')}'3'{StatusPanel}'4'{LauncherTools}'5'{WorkersPaused}'6'{RunPs1 (Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1')}'?'{Help}'7'{Help}'b'{break}'q'{break}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   14: if ($c -eq '5') {
   15:   $operatorLauncher = Join-Path $Root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   16:   if (Test-Path $operatorLauncher) {
   17:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   18:   } else {
   19:     Write-Host "Operador versionado no encontrado: $operatorLauncher" -ForegroundColor Yellow
   20:   }
   21:   return

## operator context
### around line 178
  170:   L "q sale desde GLOBAL." Gray
  171: }
  172: Set-BootGlobalKeepContext
  173: while($true){
  174:   Refresh-Screen
  175:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  176:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  177:   
  178: if($cmd -in @("m","mant","mantenimiento")){
  179:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  180:     continue
  181:   }
  182:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  183:   if($cmd -eq "__refresh__"){continue}
  184:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  185:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  186:   if($cmd -eq "atras"){Go-Back;continue}

### around line 201
  193: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  194: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {

### around line 204
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan

### around line 212
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema
  215: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  216:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  217:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  218:   $title=Read-Host "Titulo breve"
  219:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  220:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"

### around line 215
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema
  215: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  216:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  217:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  218:   $title=Read-Host "Titulo breve"
  219:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  220:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  221:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  222:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  223:   if($dimension -notin $allowedDimensions){$dimension="other"}

### around line 219
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema
  215: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  216:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  217:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  218:   $title=Read-Host "Titulo breve"
  219:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  220:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  221:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  222:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  223:   if($dimension -notin $allowedDimensions){$dimension="other"}
  224:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  225:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  226:   $severity=$severity.ToUpperInvariant()
  227:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}

### around line 197
  189: 
  190: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  191: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  192: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  193: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  194: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END

### around line 199
  191: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  192: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  193: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  194: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 

### around line 245
  237:       Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
  238:     }
  239:     return
  240:   }
  241:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  242:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  243:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  244:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  245:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  246:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  247:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  248: }
  249: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
  250: 
  251: 

### around line 176
  168:   L "Enter/refrescar/f5 redibuja pantalla." Gray
  169:   L "a/b/atras vuelve al nivel anterior." Gray
  170:   L "q sale desde GLOBAL." Gray
  171: }
  172: Set-BootGlobalKeepContext
  173: while($true){
  174:   Refresh-Screen
  175:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  176:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  177:   
  178: if($cmd -in @("m","mant","mantenimiento")){
  179:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  180:     continue
  181:   }
  182:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  183:   if($cmd -eq "__refresh__"){continue}
  184:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}

### around line 179
  171: }
  172: Set-BootGlobalKeepContext
  173: while($true){
  174:   Refresh-Screen
  175:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  176:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  177:   
  178: if($cmd -in @("m","mant","mantenimiento")){
  179:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  180:     continue
  181:   }
  182:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  183:   if($cmd -eq "__refresh__"){continue}
  184:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  185:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  186:   if($cmd -eq "atras"){Go-Back;continue}
  187:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd

### around line 182
  174:   Refresh-Screen
  175:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  176:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  177:   
  178: if($cmd -in @("m","mant","mantenimiento")){
  179:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  180:     continue
  181:   }
  182:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  183:   if($cmd -eq "__refresh__"){continue}
  184:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  185:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  186:   if($cmd -eq "atras"){Go-Back;continue}
  187:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  188: }
  189: 
  190: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN

### around line 196
  188: }
  189: 
  190: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  191: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  192: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  193: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  194: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.

### around line 200
  192: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  193: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  194: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN

### around line 203
  195: 
  196: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""

### around line 205
  197: function Invoke-EngremiatHumanMaintenanceCard {
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual

### around line 206
  198:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  199:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema

### around line 208
  200:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema
  215: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  216:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray

### around line 209
  201:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar
  202: }
  203: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_BEGIN
  204: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  205: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  206: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  207: 
  208: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  209: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  210:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  211:   Write-Host ""
  212:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  213: Ruta: INICIO > Pantalla actual
  214: Rol: operacion guiada del sistema
  215: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  216:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  217:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan

### around line 246
  238:     }
  239:     return
  240:   }
  241:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  242:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  243:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  244:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  245:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  246:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  247:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  248: }
  249: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
  250: 
  251: 


## Recommendation
Si m existe pero no crea tarjeta contextual, E03 debe preparar NO_APPLY para conectar m a un creador de tarjeta contextual en la pantalla host, preferentemente INICIO, reutilizando documents/manual-screen-maintenance-cards/cards y MAINTENANCE_QUEUE.json.

## Rule
NO_APPLY. No modifica runtime. No git.

## Next
E03_PREPARE_CONTEXTUAL_MAINTENANCE_CARD_COMMAND_NO_APPLY
