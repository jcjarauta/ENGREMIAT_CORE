$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectsCenter=Join-Path $Core "tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1"
$DocCenter=Join-Path $Core "tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1"
$Legacy=Join-Path $Core "tools\launcher\ENGREMIAT-INICIO.ps1"
function UX([string]$m,[string]$role="info"){$c=switch($role){"title"{"Cyan"}"route"{"DarkGray"}"role"{"Gray"}"principle"{"DarkGray"}"section"{"Yellow"}"ok"{"Green"}"warn"{"Yellow"}"err"{"Red"}"next"{"Cyan"}"muted"{"DarkGray"}default{"Gray"}};try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function UXOk([string]$m){UX ("[OK] "+$m) "ok"}
function UXWarn([string]$m){UX ("[WARN] "+$m) "warn"}
function P(){Write-Host "";Read-Host "[Enter] volver / refrescar"|Out-Null}
function Header([string]$section=""){Clear-Host;UX "==== ENGREMIAT / INICIO ====" "title";UX "Ruta: INICIO" "route";UX "Rol: hub raiz del sistema" "role";UX "Principio: entrar por bloques funcionales, no por listado largo" "principle";if($section){UX $section "section"};Write-Host ""}
function OpenProjectsCenter(){if(Test-Path $ProjectsCenter){& powershell -NoProfile -ExecutionPolicy Bypass -File $ProjectsCenter}else{Header "PROYECTOS";UXWarn ("No encontrado: "+$ProjectsCenter);P}}
function OpenDocCenter(){if(Test-Path $DocCenter){& powershell -NoProfile -ExecutionPolicy Bypass -File $DocCenter}else{Header "MEMORIA Y DOCUMENTACION";UXWarn ("No encontrado: "+$DocCenter);P}}
function OpenLegacy(){if(Test-Path $Legacy){& powershell -NoProfile -ExecutionPolicy Bypass -File $Legacy}else{Header "LEGACY";UXWarn ("No encontrado: "+$Legacy);P}}
function Placeholder([string]$title){Header $title;UXWarn "Bloque raiz pendiente de cablear en fase posterior.";P}
function Status(){Header "ESTADO";UXOk "Inicio normalizado en modo hub";if(Test-Path $ProjectsCenter){UXOk "Proyectos normalizado conectado"}else{UXWarn "Proyectos normalizado no encontrado"};if(Test-Path $DocCenter){UXOk "Centro Documental normalizado conectado"}else{UXWarn "Centro Documental normalizado no encontrado"};UXWarn "Operador/workers, Control/estado y Herramientas/configuracion pendientes";P}
function Help(){Header "AYUDA";UX "Inicio normalizado agrupa el sistema por bloques funcionales.";UX "[1] Proyectos ya conecta con Centro de Proyectos normalizado.";UX "[2] Memoria y documentacion ya conecta con Centro Documental normalizado.";UX "[6] Sistema legacy conserva el launcher original como respaldo." "muted";P}
function Menu(){while($true){Header;UX "[1] Proyectos";UX "[2] Memoria y documentacion";UX "[3] Operador y workers";UX "[4] Control y estado";UX "[5] Herramientas y configuracion";UX "[6] Sistema legacy";UX "[7] Estado y ayuda";Write-Host "";UX "[q] salir | [Enter] refrescar | ? = ayuda" "muted";Write-Host "";$op=Read-Host "INICIO";switch($op){"1"{OpenProjectsCenter};"2"{OpenDocCenter};"3"{Placeholder "OPERADOR Y WORKERS"};"4"{Placeholder "CONTROL Y ESTADO"};"5"{Placeholder "HERRAMIENTAS Y CONFIGURACION"};"6"{OpenLegacy};"7"{Status};"q"{return};""{continue};"?"{Help};default{UXWarn "Opcion no reconocida";Start-Sleep -Milliseconds 700}}}}
Menu
