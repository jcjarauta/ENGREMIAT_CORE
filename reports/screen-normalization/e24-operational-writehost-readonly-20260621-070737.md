# E24 Operational Launcher WriteHost Readonly

target: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
write_lines: 
40
suspects: 
2

## Suspects
   8: Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor Gray
 123: W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" Cyan

## All WriteHost/W lines
   5:   Write-Host "==== AYUDA - LAUNCHER ACTUAL ====" -ForegroundColor Cyan
   6:   Write-Host "Ruta: LAUNCHER ACTUAL" -ForegroundColor DarkCyan
   7:   Write-Host ""
   8: Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor Gray
   9:   Write-Host "q/b = salir o volver" -ForegroundColor Gray
  10:   Write-Host "m = mantenimiento contextual si ya existe en esta pantalla" -ForegroundColor Gray
  11:   Write-Host "? = ayuda" -ForegroundColor Gray
  12:   Write-Host ""
  24: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
  45:     W "NO_GO script_no_encontrado=$file" Red
  55:   W "==== ESTADO ENGREMIAT ====" Cyan
  56:   W "Core: $Core" White
  68:   W ""
  69:   W "Pantallas detectadas:" Cyan
  78:     W ""
  79:     W "Modulos proyecto activo: $mods" White
  86:   W "Biblioteca: $la activos / $lh historicos" White
 100: W "==== ENGREMIAT / LAUNCHER ACTUAL ====" Cyan
 101: W ""
 102: W ("Ruta: " + $PSCommandPath) DarkGray
 103: W "Principio: panel central del sistema actual" DarkGray
 104:     W ""
 107:     W ""
 108:     W "OPERADOR / PROYECTO" Yellow
 109:     W "[1] Abrir operador terminal principal" White
 110:     W "[2] Abrir carpeta proyecto activo" White
 111:     W "[3] Estado compacto del launcher" White
 112:     W ""
 113:     W "MODULOS / BIBLIOTECA" Yellow
 114:     W "[4] Pantalla modulos del proyecto" White
 115:     W "[5] Biblioteca de modulos" White
 116:     W "[6] Workspace de modulo" White
 117:     W "[7] Tarjetas de modulo" White
 118:     W ""
 119:     W "MANTENIMIENTO" Yellow
 120:     W "[8] Refrescar grafo de modulos del proyecto activo" White
 121:     W "[9] Abrir carpeta tools launcher" White
 122:     W ""
 123: W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" Cyan
 124:     W ""
