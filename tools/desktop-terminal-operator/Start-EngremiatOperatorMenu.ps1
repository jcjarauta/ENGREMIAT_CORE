$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Host "";Write-Host "==== $t ====" -ForegroundColor $c;foreach($x in $l){Write-Host ([string]$x) -ForegroundColor $c}}
$root="C:\ENGREMIAT_CORE"
$tools=Join-Path $root "tools\desktop-terminal-operator"
$manager=Join-Path $tools "eng-projects-manager.ps1"
$creator=Join-Path $tools "eng-new-project-safe.ps1"
Set-Location $root
while($true){
  Clear-Host
  B "ENGREMIAT TERMINAL OPERATOR" @("Workspace: C:\ENGREMIAT_CORE","Sistema: MENU_V2_ESTABLE") "Cyan"
  Write-Host ""
  Write-Host "GLOBAL" -ForegroundColor Cyan
  Write-Host " [1] Abrir / gestionar proyectos     p" -ForegroundColor Green
  Write-Host " [2] Nuevo proyecto                  n" -ForegroundColor Green
  Write-Host " [3] Ver proyectos activos/historico" -ForegroundColor Green
  Write-Host " [4] Estado compacto                 e" -ForegroundColor Yellow
  Write-Host " [q] Salir" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "Enter = refrescar | p/1/3 = proyectos | n/2 = nuevo proyecto | q = salir" -ForegroundColor DarkGray
  Write-Host ""
  $a=Read-Host "ENGREMIAT"
  if([string]::IsNullOrWhiteSpace($a)){continue}
  $a=$a.Trim().ToLowerInvariant()
  if($a -eq "q"){break}
  if($a -eq "1" -or $a -eq "3" -or $a -eq "p" -or $a -eq "proyectos"){
    if(Test-Path -LiteralPath $manager){& powershell -NoProfile -ExecutionPolicy Bypass -File $manager}else{B "NO_GO" @("No encuentro gestor: $manager") "Yellow";Read-Host "Enter"}
    continue
  }
  if($a -eq "2" -or $a -eq "n" -or $a -eq "nuevo"){
    if(Test-Path -LiteralPath $creator){& powershell -NoProfile -ExecutionPolicy Bypass -File $creator}else{B "NO_GO" @("No encuentro creador: $creator") "Yellow";Read-Host "Enter"}
    if(Test-Path -LiteralPath $manager){& powershell -NoProfile -ExecutionPolicy Bypass -File $manager}
    continue
  }
  if($a -eq "4" -or $a -eq "e" -or $a -eq "estado"){
    $base="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR"
    $projects=@()
    if(Test-Path -LiteralPath $base){$projects=@(Get-ChildItem -LiteralPath $base -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue)}
    B "ESTADO COMPACTO" @("projects=$($projects.Count)","manager=$manager","creator=$creator","root=$root") "Cyan"
    Read-Host "Enter para volver"
    continue
  }
}
