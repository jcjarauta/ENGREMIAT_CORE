# E23B audit projects-center router after manual fail

## Decision
NO_GO_ROUTER_VISIBLE_BUT_COMMANDS_NOT_CAPTURED_PREPARE_REPAIR

## Target
- path: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- parse: 
True

## Checks
- has_menu: 
True
- has_function: 
True
- has_help_function: 
True
- has_router_marker: 
True
- has_m_if: 
True
- has_help_if: 
True
- has_q_if: 
True

## ReadHost lines
- line 10 :: $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
- line 12 :: $exp = Read-Host "Esperado"
- line 14 :: $obs = Read-Host "Observado / que falla"
- line 16 :: $act = Read-Host "Accion realizada antes del fallo"
- line 41 :: Read-Host "Enter para volver a PROYECTOS" | Out-Null
- line 56 :: Read-Host "Enter para volver" | Out-Null
- line 91 :: Read-Host 'Enter'|Out-Null}}
- line 93 :: Read-Host 'Enter'|Out-Null;
- line 110 :: $c=Read-Host 'PROYECTOS';
- line 141 :: $c=Read-Host 'PROYECTO';
- line 156 :: $c=Read-Host 'MODULOS';
- line 176 :: $c=Read-Host 'MODULO';
- line 190 :: Read-Host|Out-Null}

## Context
```powershell
### around line 1
    1: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_BEGIN
    2: function New-EngProjectsCenterMaintenanceCard {
    3:   Clear-Host
    4:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
    5:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
    6:   Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
    7:   Write-Host ""
    8: 
    9:   $cancelTokens = @("b","q","c","cancelar","cancel","salir")
   10:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }

### around line 2
    1: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_BEGIN
    2: function New-EngProjectsCenterMaintenanceCard {
    3:   Clear-Host
    4:   Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
    5:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
    6:   Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
    7:   Write-Host ""
    8: 
    9:   $cancelTokens = @("b","q","c","cancelar","cancel","salir")
   10:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   12:   $exp = Read-Host "Esperado"

### around line 10
    5:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
    6:   Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
    7:   Write-Host ""
    8: 
    9:   $cancelTokens = @("b","q","c","cancelar","cancel","salir")
   10:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   12:   $exp = Read-Host "Esperado"
   13:   if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   14:   $obs = Read-Host "Observado / que falla"
   15:   if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   16:   $act = Read-Host "Accion realizada antes del fallo"
   17:   if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   18: 
   19:   if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
   20:   if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }

### around line 12
    7:   Write-Host ""
    8: 
    9:   $cancelTokens = @("b","q","c","cancelar","cancel","salir")
   10:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   12:   $exp = Read-Host "Esperado"
   13:   if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   14:   $obs = Read-Host "Observado / que falla"
   15:   if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   16:   $act = Read-Host "Accion realizada antes del fallo"
   17:   if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   18: 
   19:   if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
   20:   if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
   21:   if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
   22:   if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }

### around line 14
    9:   $cancelTokens = @("b","q","c","cancelar","cancel","salir")
   10:   $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   12:   $exp = Read-Host "Esperado"
   13:   if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   14:   $obs = Read-Host "Observado / que falla"
   15:   if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   16:   $act = Read-Host "Accion realizada antes del fallo"
   17:   if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   18: 
   19:   if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
   20:   if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
   21:   if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
   22:   if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }
   23: 
   24:   $cardsDir = "C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards"

### around line 16
   11:   if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   12:   $exp = Read-Host "Esperado"
   13:   if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   14:   $obs = Read-Host "Observado / que falla"
   15:   if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   16:   $act = Read-Host "Accion realizada antes del fallo"
   17:   if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
   18: 
   19:   if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
   20:   if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
   21:   if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
   22:   if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }
   23: 
   24:   $cardsDir = "C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards"
   25:   if(!(Test-Path $cardsDir)){ New-Item -ItemType Directory -Force -Path $cardsDir | Out-Null }
   26:   $id = "MCARD-" + (Get-Date -Format "yyyyMMdd-HHmmss") + "-projects-center"

### around line 41
   36:     "- action_done: " + $act,
   37:     "- status: OPEN",
   38:     "- created_at: " + (Get-Date).ToString("s")
   39:   ) | Set-Content -Encoding UTF8 $card
   40:   Write-Host ("OK tarjeta_mantenimiento_creada=" + $card) -ForegroundColor Green
   41:   Read-Host "Enter para volver a PROYECTOS" | Out-Null
   42: }
   43: 
   44: function Show-EngProjectsCenterHelp {
   45:   Clear-Host
   46:   Write-Host "==== AYUDA - PROYECTOS ====" -ForegroundColor Cyan
   47:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
   48:   Write-Host ""
   49:   Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
   50:   Write-Host "numero = abrir proyecto" -ForegroundColor Gray
   51:   Write-Host "b = volver" -ForegroundColor Gray

### around line 44
   39:   ) | Set-Content -Encoding UTF8 $card
   40:   Write-Host ("OK tarjeta_mantenimiento_creada=" + $card) -ForegroundColor Green
   41:   Read-Host "Enter para volver a PROYECTOS" | Out-Null
   42: }
   43: 
   44: function Show-EngProjectsCenterHelp {
   45:   Clear-Host
   46:   Write-Host "==== AYUDA - PROYECTOS ====" -ForegroundColor Cyan
   47:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
   48:   Write-Host ""
   49:   Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
   50:   Write-Host "numero = abrir proyecto" -ForegroundColor Gray
   51:   Write-Host "b = volver" -ForegroundColor Gray
   52:   Write-Host "q = salir / volver" -ForegroundColor Gray
   53:   Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
   54:   Write-Host "? = ayuda" -ForegroundColor Gray

### around line 50
   45:   Clear-Host
   46:   Write-Host "==== AYUDA - PROYECTOS ====" -ForegroundColor Cyan
   47:   Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
   48:   Write-Host ""
   49:   Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
   50:   Write-Host "numero = abrir proyecto" -ForegroundColor Gray
   51:   Write-Host "b = volver" -ForegroundColor Gray
   52:   Write-Host "q = salir / volver" -ForegroundColor Gray
   53:   Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
   54:   Write-Host "? = ayuda" -ForegroundColor Gray
   55:   Write-Host ""
   56:   Read-Host "Enter para volver" | Out-Null
   57: }
   58: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_END
   59: $ErrorActionPreference='Stop'
   60: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

### around line 54
   49:   Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
   50:   Write-Host "numero = abrir proyecto" -ForegroundColor Gray
   51:   Write-Host "b = volver" -ForegroundColor Gray
   52:   Write-Host "q = salir / volver" -ForegroundColor Gray
   53:   Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
   54:   Write-Host "? = ayuda" -ForegroundColor Gray
   55:   Write-Host ""
   56:   Read-Host "Enter para volver" | Out-Null
   57: }
   58: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_END
   59: $ErrorActionPreference='Stop'
   60: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   61: $Core='C:\ENGREMIAT_CORE'
   62: $ProjectsDir=Join-Path $Core 'projects'
   63: $LauncherDir=Join-Path $Core 'tools\launcher'
   64: $CardsView=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1'

### around line 56
   51:   Write-Host "b = volver" -ForegroundColor Gray
   52:   Write-Host "q = salir / volver" -ForegroundColor Gray
   53:   Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
   54:   Write-Host "? = ayuda" -ForegroundColor Gray
   55:   Write-Host ""
   56:   Read-Host "Enter para volver" | Out-Null
   57: }
   58: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_END
   59: $ErrorActionPreference='Stop'
   60: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   61: $Core='C:\ENGREMIAT_CORE'
   62: $ProjectsDir=Join-Path $Core 'projects'
   63: $LauncherDir=Join-Path $Core 'tools\launcher'
   64: $CardsView=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1'
   65: $SignalsConfig=Join-Path $Core 'documents\worker-sync\worker-signals-config.json'
   66: $LatestSignal=Join-Path $Core 'documents\worker-sync\project-signal-latest.json'

### around line 58
   53:   Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
   54:   Write-Host "? = ayuda" -ForegroundColor Gray
   55:   Write-Host ""
   56:   Read-Host "Enter para volver" | Out-Null
   57: }
   58: # ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_END
   59: $ErrorActionPreference='Stop'
   60: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
   61: $Core='C:\ENGREMIAT_CORE'
   62: $ProjectsDir=Join-Path $Core 'projects'
   63: $LauncherDir=Join-Path $Core 'tools\launcher'
   64: $CardsView=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1'
   65: $SignalsConfig=Join-Path $Core 'documents\worker-sync\worker-signals-config.json'
   66: $LatestSignal=Join-Path $Core 'documents\worker-sync\project-signal-latest.json'
   67: function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
   68: function SafeId($p){$j=Join-Path $p 'project.json';

### around line 91
   86: if($o.module_id){return [string]$o.module_id};
   87: if($o.id){return [string]$o.id};
   88: if($o.name){return [string]$o.name}}catch{}};
   89: return (Split-Path $ModulePath -Leaf)}
   90: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;
   91: Read-Host 'Enter'|Out-Null}}
   92: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;
   93: Read-Host 'Enter'|Out-Null;
   94: return};
   95: & powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
   96: function Header(){Clear-Host;
   97: W '==== PROYECTOS ====' Cyan;
   98: W 'Ruta: INICIO > Proyectos' DarkCyan;
   99: W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan;
  100: W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan;
  101: W ''}

### around line 93
   88: if($o.name){return [string]$o.name}}catch{}};
   89: return (Split-Path $ModulePath -Leaf)}
   90: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;
   91: Read-Host 'Enter'|Out-Null}}
   92: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;
   93: Read-Host 'Enter'|Out-Null;
   94: return};
   95: & powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
   96: function Header(){Clear-Host;
   97: W '==== PROYECTOS ====' Cyan;
   98: W 'Ruta: INICIO > Proyectos' DarkCyan;
   99: W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan;
  100: W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan;
  101: W ''}
  102: function ProjectList(){while($true){Header;
  103: $items=GetProjects;

### around line 109
  104: if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;
  105: foreach($p in $items){$i++;
  106: $ProjectIdValue=SafeId $p.FullName;
  107: W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};
  108: W '';
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};

### around line 110
  105: foreach($p in $items){$i++;
  106: $ProjectIdValue=SafeId $p.FullName;
  107: W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};
  108: W '';
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;

### around line 111
  106: $ProjectIdValue=SafeId $p.FullName;
  107: W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};
  108: W '';
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;

### around line 112
  107: W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};
  108: W '';
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}

### around line 113
  108: W '';
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}
  123: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;

### around line 114
  109: W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}
  123: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;
  124: while($true){Clear-Host;

### around line 115
  110: $c=Read-Host 'PROYECTOS';
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}
  123: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;
  124: while($true){Clear-Host;
  125: W '==== PROYECTO / ACCIONES ====' Cyan;

### around line 116
  111: # ENG_PROJECTS_CENTER_ROUTER_E21E_BEGIN
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}
  123: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;
  124: while($true){Clear-Host;
  125: W '==== PROYECTO / ACCIONES ====' Cyan;
  126: W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;

### around line 117
  112: $__eng_projects_center_cmd = if($null -eq $a) { "" } else { [string]$a }
  113: $__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
  114: if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
  115: if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
  116: if($__eng_projects_center_cmd -eq "q"){ return }
  117: # ENG_PROJECTS_CENTER_ROUTER_E21E_END
  118: if([string]::IsNullOrWhiteSpace($c)){continue};
  119: if($c.ToLower() -eq 'b'){break};
  120: $n=0;
  121: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  122: Start-Sleep -Milliseconds 700}}}
  123: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;
  124: while($true){Clear-Host;
  125: W '==== PROYECTO / ACCIONES ====' Cyan;
  126: W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;
  127: W 'Rol: acciones locales del proyecto' DarkCyan;

### around line 141
  136: W '[2] abrir project.json' White;
  137: W '[3] modulos' White;
  138: W '[4] tarjetas canon navegacion' White;
  139: W '[5] estado/ayuda' White;
  140: W '[b] volver a cartera | Enter = refrescar' DarkGray;
  141: $c=Read-Host 'PROYECTO';
  142: if([string]::IsNullOrWhiteSpace($c)){continue};
  143: switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;
  144: Start-Sleep -Milliseconds 700}}}}
  145: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;
  146: W '==== MODULOS ====' Cyan;
  147: W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;
  148: W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;
  149: W '';
  150: $mods=GetModules $ProjectPath;
  151: if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;

### around line 143
  138: W '[4] tarjetas canon navegacion' White;
  139: W '[5] estado/ayuda' White;
  140: W '[b] volver a cartera | Enter = refrescar' DarkGray;
  141: $c=Read-Host 'PROYECTO';
  142: if([string]::IsNullOrWhiteSpace($c)){continue};
  143: switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;
  144: Start-Sleep -Milliseconds 700}}}}
  145: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;
  146: W '==== MODULOS ====' Cyan;
  147: W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;
  148: W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;
  149: W '';
  150: $mods=GetModules $ProjectPath;
  151: if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;
  152: foreach($m in $mods){$i++;
  153: W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};

### around line 156
  151: if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;
  152: foreach($m in $mods){$i++;
  153: W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};
  154: W '';
  155: W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray;
  156: $c=Read-Host 'MODULOS';
  157: if([string]::IsNullOrWhiteSpace($c)){continue};
  158: if($c.ToLower() -eq 'b'){return};
  159: $n=0;
  160: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow;
  161: Start-Sleep -Milliseconds 700}}}
  162: function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath;
  163: while($true){Clear-Host;
  164: W '==== MODULO / ACCIONES ====' Cyan;
  165: W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan;
  166: W 'Rol: acciones locales del modulo' DarkCyan;

### around line 176
  171: W '';
  172: W '[1] abrir carpeta del modulo' White;
  173: W '[2] abrir module.json' White;
  174: W '[3] tarjetas del modulo' White;
  175: W '[b] volver a modulos | Enter = refrescar' DarkGray;
  176: $c=Read-Host 'MODULO';
  177: if([string]::IsNullOrWhiteSpace($c)){continue};
  178: switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;
  179: Start-Sleep -Milliseconds 700}}}}
  180: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;
  181: W '==== PROYECTO / ESTADO ====' Cyan;
  182: W ('Proyecto: '+$ProjectId) White;
  183: W ('Ruta: '+$ProjectPath) Gray;
  184: W ('Workers: '+(WorkersState)) Yellow;
  185: W ('Ultima senal: '+(LatestWorkerText)) Gray;
  186: W '';

### around line 178
  173: W '[2] abrir module.json' White;
  174: W '[3] tarjetas del modulo' White;
  175: W '[b] volver a modulos | Enter = refrescar' DarkGray;
  176: $c=Read-Host 'MODULO';
  177: if([string]::IsNullOrWhiteSpace($c)){continue};
  178: switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;
  179: Start-Sleep -Milliseconds 700}}}}
  180: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;
  181: W '==== PROYECTO / ESTADO ====' Cyan;
  182: W ('Proyecto: '+$ProjectId) White;
  183: W ('Ruta: '+$ProjectPath) Gray;
  184: W ('Workers: '+(WorkersState)) Yellow;
  185: W ('Ultima senal: '+(LatestWorkerText)) Gray;
  186: W '';
  187: W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;
  188: W '';

### around line 190
  185: W ('Ultima senal: '+(LatestWorkerText)) Gray;
  186: W '';
  187: W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;
  188: W '';
  189: W '[Enter] volver' DarkGray;
  190: Read-Host|Out-Null}
  191: ProjectList

```

## Diagnóstico
La cabecera visible confirma que el archivo aplicado se ejecuta, pero el flujo real no pasa por las condiciones m/? o las evalúa con variable incorrecta/orden incorrecto. El siguiente bloque debe reparar la frontera real, probablemente reescribiendo el bucle/router completo en multilinea estable.

## Next
E23C_PREPARE_PROJECTS_CENTER_ROUTER_REPAIR_NO_APPLY
