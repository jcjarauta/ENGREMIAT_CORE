$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
function Line($t='',$c='Gray'){ Write-Host $t -ForegroundColor $c }
function Pause($m='Enter para volver'){ Read-Host $m | Out-Null }
function Header {
  Clear-Host
  Line '==== PROYECTOS ==== ' 'Cyan'
  Line 'Ruta: INICIO > Proyectos' 'DarkGray'
  Line 'Rol: seleccionar proyectos, revisar historicos y navegar hacia modulos/tarjetas.' 'DarkGray'
  Line 'Estado: PENDING_MIGRATION' 'DarkGray'
  Line 'Principio: pantalla candidata aislada; contrato humano estandar; launcher general intacto' 'DarkGray'
  Line ""
  Line "INDICADORES" "Yellow"
  Line " parse=OK | isolated=True | launcher_patch=False | registry_write=False | git=False" "DarkGray"
  Line " comandos: Enter/refrescar/f5 | ?/ayuda | m/mantenimiento | b/q/salir" "DarkGray"
  Line ""
}
function Help {
  Header
  Line "AYUDA" "Cyan"
  Line 'Que hace: Permite seleccionar proyectos, revisar historicos y navegar hacia modulos/tarjetas.' 'Gray'
  Line ""
  Line "Comandos normalizados:" "Cyan"
  Line " Enter/refrescar/f5 = redibujar pantalla" "Gray"
  Line " ? = abrir ayuda; dentro de ayuda pulsa Enter para volver" "Gray"
  Line " m = mantenimiento/dry-run; dentro pulsa Enter para volver" "Gray"
  Line " b/q = salir y volver al adapter/runner" "Gray"
  Line ""
  Pause
}
function Maintenance {
  Header
  Line "MANTENIMIENTO / DRY-RUN" "Yellow"
  Line "screen_id=PROYECTOS" "Gray"
  Line "maintenance_mode=DRY_RUN" "Gray"
  Line "candidate_isolated=True" "Gray"
  Line "launcher_general_untouched=True" "Gray"
  Line "patch_existing_launchers=False" "Gray"
  Line "registry_write=False" "Gray"
  Line "migration_applied=False" "Gray"
  Line "git=False" "Gray"
  Line ""
  Pause
}
function Main {
  while($true){
    Header
    Line "PANTALLA" "Cyan"
    Line 'Permite seleccionar proyectos, revisar historicos y navegar hacia modulos/tarjetas.' 'Gray'
    Line ""
    Line "COMANDOS" "Cyan"
    Line " Enter/refrescar/f5 = redibujar | ? = ayuda | m = mantenimiento | b/q = volver" "DarkGray"
    Line ""
    $c = Read-Host "ENGREMIAT"
    if([string]::IsNullOrWhiteSpace($c) -or $c -eq "f5" -or $c -eq "refrescar"){ continue }
    if($c -eq "?" -or $c -eq "ayuda"){ Help; continue }
    if($c -eq "m" -or $c -eq "mantenimiento"){ Maintenance; continue }
    if($c -eq "b" -or $c -eq "q" -or $c -eq "salir"){ break }
    Line "Comando no reconocido. Usa Enter, f5, ?, m, b o q." "Yellow"
    Start-Sleep -Milliseconds 700
  }
}
Main