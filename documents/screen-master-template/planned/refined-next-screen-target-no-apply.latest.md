# E28 refined next screen target NO_APPLY

## Decision
GO_REFINED_TARGET_AUDITED_READY_FOR_CANDIDATE_NO_APPLY

## Target
- path: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
- parse: 
True
- strategy: 
PREPARE_ROUTER_PATCH_NO_APPLY
- compressed: 
False

## Coverage
- enter: 
True
- b: 
False
- q: 
True
- m: 
True
- help: 
False

## ReadHost list
- line 8 shape=UNKNOWN var=UNKNOWN :: function P(){ [void](Read-Host "Enter") }
- line 106 shape=ASSIGNMENT var=cmd :: $cmd=Read-Host "ENGREMIAT"

## Context
```powershell
### around line 4
    1: $ErrorActionPreference="Stop"
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: 
    4: $Core="C:\ENGREMIAT_CORE"
    5: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
    6: 
    7: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
    8: function P(){ [void](Read-Host "Enter") }
    9: 
   10: function ActiveProject(){
   11:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
   12:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
   13:   if(Test-Path $j){

### around line 7
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: 
    4: $Core="C:\ENGREMIAT_CORE"
    5: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
    6: 
    7: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
    8: function P(){ [void](Read-Host "Enter") }
    9: 
   10: function ActiveProject(){
   11:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
   12:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
   13:   if(Test-Path $j){
   14:     try{
   15:       $x=Get-Content $j -Raw | ConvertFrom-Json
   16:       if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }

### around line 8
    3: 
    4: $Core="C:\ENGREMIAT_CORE"
    5: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
    6: 
    7: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
    8: function P(){ [void](Read-Host "Enter") }
    9: 
   10: function ActiveProject(){
   11:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
   12:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
   13:   if(Test-Path $j){
   14:     try{
   15:       $x=Get-Content $j -Raw | ConvertFrom-Json
   16:       if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }
   17:     }catch{}

### around line 10
    5: $ToolDir=Join-Path $Core "tools\desktop-terminal-operator"
    6: 
    7: function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
    8: function P(){ [void](Read-Host "Enter") }
    9: 
   10: function ActiveProject(){
   11:   $j=Join-Path $Core "data\desktop-terminal-operator\active-project.json"
   12:   $t=Join-Path $Core "data\desktop-terminal-operator\active-project.txt"
   13:   if(Test-Path $j){
   14:     try{
   15:       $x=Get-Content $j -Raw | ConvertFrom-Json
   16:       if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }
   17:     }catch{}
   18:   }
   19:   if(Test-Path $t){

### around line 26
   21:     if(Test-Path $y){ return $y }
   22:   }
   23:   return ""
   24: }
   25: 
   26: function RunScript($file,$args=@()){
   27:   if(-not(Test-Path $file)){
   28:     W "NO_GO script_no_encontrado=$file" Red
   29:     P
   30:     return
   31:   }
   32:   & powershell -NoProfile -ExecutionPolicy Bypass -File $file @args
   33: }
   34: 
   35: function ShowStatus(){

### around line 35
   30:     return
   31:   }
   32:   & powershell -NoProfile -ExecutionPolicy Bypass -File $file @args
   33: }
   34: 
   35: function ShowStatus(){
   36:   Clear-Host
   37:   $p=ActiveProject
   38:   W "==== ESTADO ENGREMIAT ====" Cyan
   39:   W "Core: $Core" White
   40:   if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green; W "Ruta: $p" DarkGray }
   41:   else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   42: 
   43:   $checks=@(
   44:     @{name="Pantalla proyectos/modulos"; path=(Join-Path $ToolDir "eng-project-modules-screen.ps1")},

### around line 38
   33: }
   34: 
   35: function ShowStatus(){
   36:   Clear-Host
   37:   $p=ActiveProject
   38:   W "==== ESTADO ENGREMIAT ====" Cyan
   39:   W "Core: $Core" White
   40:   if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green; W "Ruta: $p" DarkGray }
   41:   else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   42: 
   43:   $checks=@(
   44:     @{name="Pantalla proyectos/modulos"; path=(Join-Path $ToolDir "eng-project-modules-screen.ps1")},
   45:     @{name="Biblioteca modulos"; path=(Join-Path $ToolDir "eng-module-library-screen.ps1")},
   46:     @{name="Workspace modulo"; path=(Join-Path $ToolDir "eng-module-workspace-screen.ps1")},
   47:     @{name="Tarjetas modulo"; path=(Join-Path $ToolDir "eng-module-cards-screen.ps1")},

### around line 40
   35: function ShowStatus(){
   36:   Clear-Host
   37:   $p=ActiveProject
   38:   W "==== ESTADO ENGREMIAT ====" Cyan
   39:   W "Core: $Core" White
   40:   if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green; W "Ruta: $p" DarkGray }
   41:   else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   42: 
   43:   $checks=@(
   44:     @{name="Pantalla proyectos/modulos"; path=(Join-Path $ToolDir "eng-project-modules-screen.ps1")},
   45:     @{name="Biblioteca modulos"; path=(Join-Path $ToolDir "eng-module-library-screen.ps1")},
   46:     @{name="Workspace modulo"; path=(Join-Path $ToolDir "eng-module-workspace-screen.ps1")},
   47:     @{name="Tarjetas modulo"; path=(Join-Path $ToolDir "eng-module-cards-screen.ps1")},
   48:     @{name="Grafo modulos"; path=(Join-Path $ToolDir "eng-refresh-project-module-graph.ps1")}
   49:   )

### around line 65
   60:     $mods=if(Test-Path $modsDir){ @(Get-ChildItem $modsDir -Directory -ErrorAction SilentlyContinue).Count }else{0}
   61:     W ""
   62:     W "Modulos proyecto activo: $mods" White
   63:   }
   64: 
   65:   $libAct="C:\ENGREMIAT_CORE\library\modules"
   66:   $libHist="C:\ENGREMIAT_CORE\library\modules_historico"
   67:   $la=if(Test-Path $libAct){ @(Get-ChildItem $libAct -Directory -ErrorAction SilentlyContinue).Count }else{0}
   68:   $lh=if(Test-Path $libHist){ @(Get-ChildItem $libHist -Directory -ErrorAction SilentlyContinue).Count }else{0}
   69:   W "Biblioteca: $la activos / $lh historicos" White
   70:   P
   71: }
   72: 
   73: function OpenActiveProjectFolder(){
   74:   $p=ActiveProject

### around line 66
   61:     W ""
   62:     W "Modulos proyecto activo: $mods" White
   63:   }
   64: 
   65:   $libAct="C:\ENGREMIAT_CORE\library\modules"
   66:   $libHist="C:\ENGREMIAT_CORE\library\modules_historico"
   67:   $la=if(Test-Path $libAct){ @(Get-ChildItem $libAct -Directory -ErrorAction SilentlyContinue).Count }else{0}
   68:   $lh=if(Test-Path $libHist){ @(Get-ChildItem $libHist -Directory -ErrorAction SilentlyContinue).Count }else{0}
   69:   W "Biblioteca: $la activos / $lh historicos" White
   70:   P
   71: }
   72: 
   73: function OpenActiveProjectFolder(){
   74:   $p=ActiveProject
   75:   if($p){ Start-Process explorer.exe $p }

### around line 73
   68:   $lh=if(Test-Path $libHist){ @(Get-ChildItem $libHist -Directory -ErrorAction SilentlyContinue).Count }else{0}
   69:   W "Biblioteca: $la activos / $lh historicos" White
   70:   P
   71: }
   72: 
   73: function OpenActiveProjectFolder(){
   74:   $p=ActiveProject
   75:   if($p){ Start-Process explorer.exe $p }
   76:   else{ W "NO_GO no_hay_proyecto_activo" Yellow; P }
   77: }
   78: 
   79: function Main(){
   80:   while($true){
   81:     $p=ActiveProject
   82:     Clear-Host

### around line 79
   74:   $p=ActiveProject
   75:   if($p){ Start-Process explorer.exe $p }
   76:   else{ W "NO_GO no_hay_proyecto_activo" Yellow; P }
   77: }
   78: 
   79: function Main(){
   80:   while($true){
   81:     $p=ActiveProject
   82:     Clear-Host
   83:     W "==== ENGREMIAT LAUNCHER ACTUAL ====" Cyan
   84:     W "Un clic -> panel central del sistema actual" DarkCyan
   85:     W ""
   86:     if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
   87:     else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   88:     W ""

### around line 80
   75:   if($p){ Start-Process explorer.exe $p }
   76:   else{ W "NO_GO no_hay_proyecto_activo" Yellow; P }
   77: }
   78: 
   79: function Main(){
   80:   while($true){
   81:     $p=ActiveProject
   82:     Clear-Host
   83:     W "==== ENGREMIAT LAUNCHER ACTUAL ====" Cyan
   84:     W "Un clic -> panel central del sistema actual" DarkCyan
   85:     W ""
   86:     if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
   87:     else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   88:     W ""
   89:     W "OPERADOR / PROYECTO" Yellow

### around line 83
   78: 
   79: function Main(){
   80:   while($true){
   81:     $p=ActiveProject
   82:     Clear-Host
   83:     W "==== ENGREMIAT LAUNCHER ACTUAL ====" Cyan
   84:     W "Un clic -> panel central del sistema actual" DarkCyan
   85:     W ""
   86:     if($p){ W "Proyecto activo: $(Split-Path $p -Leaf)" Green }
   87:     else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   88:     W ""
   89:     W "OPERADOR / PROYECTO" Yellow
   90:     W "1 = abrir operador terminal principal" White
   91:     W "2 = abrir carpeta proyecto activo" White
   92:     W "3 = estado compacto del launcher" White

### around line 92
   87:     else{ W "Proyecto activo: NO_DETECTADO" Yellow }
   88:     W ""
   89:     W "OPERADOR / PROYECTO" Yellow
   90:     W "1 = abrir operador terminal principal" White
   91:     W "2 = abrir carpeta proyecto activo" White
   92:     W "3 = estado compacto del launcher" White
   93:     W ""
   94:     W "MODULOS / BIBLIOTECA" Yellow
   95:     W "4 = pantalla modulos del proyecto" White
   96:     W "5 = biblioteca de modulos" White
   97:     W "6 = workspace de modulo" White
   98:     W "7 = tarjetas de modulo" White
   99:     W ""
  100:     W "MANTENIMIENTO" Yellow
  101:     W "8 = refrescar grafo de modulos del proyecto activo" White

### around line 100
   95:     W "4 = pantalla modulos del proyecto" White
   96:     W "5 = biblioteca de modulos" White
   97:     W "6 = workspace de modulo" White
   98:     W "7 = tarjetas de modulo" White
   99:     W ""
  100:     W "MANTENIMIENTO" Yellow
  101:     W "8 = refrescar grafo de modulos del proyecto activo" White
  102:     W "9 = abrir carpeta tools launcher" White
  103:     W ""
  104:     W "q = salir | Enter = refrescar" Cyan
  105:     W ""
  106:     $cmd=Read-Host "ENGREMIAT"
  107: 
  108:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
  109:     if($cmd -eq "q"){ return }

### around line 102
   97:     W "6 = workspace de modulo" White
   98:     W "7 = tarjetas de modulo" White
   99:     W ""
  100:     W "MANTENIMIENTO" Yellow
  101:     W "8 = refrescar grafo de modulos del proyecto activo" White
  102:     W "9 = abrir carpeta tools launcher" White
  103:     W ""
  104:     W "q = salir | Enter = refrescar" Cyan
  105:     W ""
  106:     $cmd=Read-Host "ENGREMIAT"
  107: 
  108:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
  109:     if($cmd -eq "q"){ return }
  110: 
  111:     if($cmd -eq "1"){

### around line 104
   99:     W ""
  100:     W "MANTENIMIENTO" Yellow
  101:     W "8 = refrescar grafo de modulos del proyecto activo" White
  102:     W "9 = abrir carpeta tools launcher" White
  103:     W ""
  104:     W "q = salir | Enter = refrescar" Cyan
  105:     W ""
  106:     $cmd=Read-Host "ENGREMIAT"
  107: 
  108:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
  109:     if($cmd -eq "q"){ return }
  110: 
  111:     if($cmd -eq "1"){
  112:       $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
  113:       if(Test-Path $main){ RunScript $main }

### around line 106
  101:     W "8 = refrescar grafo de modulos del proyecto activo" White
  102:     W "9 = abrir carpeta tools launcher" White
  103:     W ""
  104:     W "q = salir | Enter = refrescar" Cyan
  105:     W ""
  106:     $cmd=Read-Host "ENGREMIAT"
  107: 
  108:     if([string]::IsNullOrWhiteSpace($cmd)){ continue }
  109:     if($cmd -eq "q"){ return }
  110: 
  111:     if($cmd -eq "1"){
  112:       $main=Join-Path $ToolDir "eng-desktop-terminal-operator.ps1"
  113:       if(Test-Path $main){ RunScript $main }
  114:       else{
  115:         $alt=Join-Path $ToolDir "eng-terminal-operator.ps1"

```

## Next
E29_PREPARE_REFINED_TARGET_ROUTER_PATCH_NO_APPLY
