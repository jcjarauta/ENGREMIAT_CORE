   5:   Write-Host "==== AYUDA - LAUNCHER ACTUAL ====" -ForegroundColor Cyan
   6:   Write-Host "Ruta: LAUNCHER ACTUAL" -ForegroundColor DarkCyan
   7:   Write-Host ""
   8: Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor Gray
   9:   Write-Host "q/b = salir o volver" -ForegroundColor Gray
  10:   Write-Host "m = mantenimiento contextual si ya existe en esta pantalla" -ForegroundColor Gray
  11:   Write-Host "? = ayuda" -ForegroundColor Gray
  12:   Write-Host ""
  13:   Read-Host "Enter para volver" | Out-Null
  14: }
  15: # ENG_LAUNCHER_ACTUAL_SCREEN_MASTER_E29_END
  16: 
----
  10:   Write-Host "m = mantenimiento contextual si ya existe en esta pantalla" -ForegroundColor Gray
  11:   Write-Host "? = ayuda" -ForegroundColor Gray
  12:   Write-Host ""
  13:   Read-Host "Enter para volver" | Out-Null
  14: }
  15: # ENG_LAUNCHER_ACTUAL_SCREEN_MASTER_E29_END
  16: 
  17: $ErrorActionPreference="Stop"
  18: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
  19: 
  20: $Core="C:\ENGREMIAT_CORE"
  21: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
----
  20: $Core="C:\ENGREMIAT_CORE"
  21: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
  22: 
  23: function Invoke-HumanCardAssistant(){ $assistant = Join-Path $Root "tools\human-card-assistant.ps1"; if(Test-Path $assistant){ & powershell -NoProfile -ExecutionPolicy Bypass -File $assistant } else { W "PENDIENTE asistente tarjetas humanas" Yellow; Read-Host "Enter = volver" | Out-Null } }
  24: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
  25: function P(){ [void](Read-Host "Enter") }
  26: 
  27: function ActiveProject(){
  28:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
  29:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
  30:   if(Test-Path $j){
  31:     try{
----
  22: 
  23: function Invoke-HumanCardAssistant(){ $assistant = Join-Path $Root "tools\human-card-assistant.ps1"; if(Test-Path $assistant){ & powershell -NoProfile -ExecutionPolicy Bypass -File $assistant } else { W "PENDIENTE asistente tarjetas humanas" Yellow; Read-Host "Enter = volver" | Out-Null } }
  24: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
  25: function P(){ [void](Read-Host "Enter") }
  26: 
  27: function ActiveProject(){
  28:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
  29:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
  30:   if(Test-Path $j){
  31:     try{
  32:       $x=Get-Content $j -Raw | ConvertFrom-Json
  33:       if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }
----
 120:     W "[8] Refrescar grafo de modulos del proyecto activo" White
 121:     W "[9] Abrir carpeta tools launcher" White
 122:     W ""
 123: W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" Cyan
 124:     W ""
 125:     $cmd=Read-Host "ENGREMIAT"
 126: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_BEGIN
 127: $__eng_launcher_cmd = if($null -eq $cmd) { "" } else { [string]$cmd }
 128: $__eng_launcher_cmd = $__eng_launcher_cmd.Trim().ToLowerInvariant()
 129: if($__eng_launcher_cmd -eq "?"){ Show-EngLauncherActualHelp; continue }
 130: if($__eng_launcher_cmd -eq "b"){ return }
 131: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_END
----
 122:     W ""
 123: W "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" Cyan
 124:     W ""
 125:     $cmd=Read-Host "ENGREMIAT"
 126: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_BEGIN
 127: $__eng_launcher_cmd = if($null -eq $cmd) { "" } else { [string]$cmd }
 128: $__eng_launcher_cmd = $__eng_launcher_cmd.Trim().ToLowerInvariant()
 129: if($__eng_launcher_cmd -eq "?"){ Show-EngLauncherActualHelp; continue }
 130: if($__eng_launcher_cmd -eq "b"){ return }
 131: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_END
 132: 
 133:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
----
 126: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_BEGIN
 127: $__eng_launcher_cmd = if($null -eq $cmd) { "" } else { [string]$cmd }
 128: $__eng_launcher_cmd = $__eng_launcher_cmd.Trim().ToLowerInvariant()
 129: if($__eng_launcher_cmd -eq "?"){ Show-EngLauncherActualHelp; continue }
 130: if($__eng_launcher_cmd -eq "b"){ return }
 131: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_END
 132: 
 133:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
 134:     if($cmd -eq "q"){ return }
 135: 
 136:     if($cmd -eq "1"){
 137:       $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
----
 127: $__eng_launcher_cmd = if($null -eq $cmd) { "" } else { [string]$cmd }
 128: $__eng_launcher_cmd = $__eng_launcher_cmd.Trim().ToLowerInvariant()
 129: if($__eng_launcher_cmd -eq "?"){ Show-EngLauncherActualHelp; continue }
 130: if($__eng_launcher_cmd -eq "b"){ return }
 131: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_END
 132: 
 133:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
 134:     if($cmd -eq "q"){ return }
 135: 
 136:     if($cmd -eq "1"){
 137:       $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
 138:       if(Test-Path $main){ RunScript $main }
----
 131: # ENG_LAUNCHER_ACTUAL_ROUTER_E29_END
 132: 
 133:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
 134:     if($cmd -eq "q"){ return }
 135: 
 136:     if($cmd -eq "1"){
 137:       $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
 138:       if(Test-Path $main){ RunScript $main }
 139:       else{
 140:         $alt=Join-Path $ToolDir "eng-terminal-operator.ps1"
 141:         RunScript $alt
 142:       }
----
