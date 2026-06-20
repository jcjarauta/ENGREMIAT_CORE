$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$Legacy=Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1"
$DocCenter=Join-Path $Core "tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1"
function UX([string]$m,[string]$role="info"){$c=switch($role){"title"{"Cyan"}"route"{"DarkGray"}"role"{"Gray"}"principle"{"DarkGray"}"section"{"Yellow"}"ok"{"Green"}"warn"{"Yellow"}"err"{"Red"}"next"{"Cyan"}"muted"{"DarkGray"}default{"Gray"}};try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function UXOk([string]$m){UX ("[OK] "+$m) "ok"}
function UXWarn([string]$m){UX ("[WARN] "+$m) "warn"}
function P(){Write-Host "";Read-Host "[Enter] volver / refrescar"|Out-Null}
function Header([string]$section=""){Clear-Host;UX "==== ENGREMIAT / INICIO ====" "title";UX "Ruta: INICIO" "route";UX "Rol: hub raiz del sistema" "role";UX "Principio: entrar por bloques funcionales, no por listado largo" "principle";if($section){UX $section "section"};Write-Host ""}
function Placeholder([string]$title){Header $title;UXWarn "Pantalla raiz creada. Este bloque se cableara en una fase posterior.";P}
function OpenDocCenter(){if(Test-Path $DocCenter){& powershell -NoProfile -ExecutionPolicy Bypass -File $DocCenter}else{Header "MEMORIA Y DOCUMENTACION";UXWarn ("No encontrado: "+$DocCenter);P}}
function OpenLegacy(){if(Test-Path $Legacy){& powershell -NoProfile -ExecutionPolicy Bypass -File $Legacy}else{Header "LEGACY";UXWarn ("No encontrado: "+$Legacy);P}}
function Status(){Header "ESTADO";UXOk "Inicio normalizado en modo hub";UXOk "Centro Documental normalizado disponible";UXWarn "Resto de bloques pendientes de cableado";P}
function Menu(){while($true){Header;UX "[1] Proyectos";UX "[2] Memoria y documentacion";UX "[3] Operador y workers";UX "[4] Control y estado";UX "[5] Herramientas y configuracion";UX "[6] Sistema legacy";UX "[7] Estado y ayuda";Write-Host "";UX "[q] salir | [Enter] refrescar | ? = ayuda" "muted";Write-Host "";$op=Read-Host "INICIO";switch($op){"1"{Placeholder "PROYECTOS"};"2"{OpenDocCenter};"3"{Placeholder "OPERADOR Y WORKERS"};"4"{Placeholder "CONTROL Y ESTADO"};"5"{Placeholder "HERRAMIENTAS Y CONFIGURACION"};"6"{OpenLegacy};"7"{Status};"q"{return};""{continue};"?"{Header "AYUDA";UX "Inicio normalizado agrupa el sistema por bloques funcionales.";UX "El listado legacy completo queda en [6] mientras se normaliza por fases." "muted";P};default{UXWarn "Opcion no reconocida";Start-Sleep -Milliseconds 700}}}}
Menu
