param([string]$Command="",[string]$Arg="",[string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Get-State{if(!(Test-Path -LiteralPath $StateFile)){return $null};return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
function HasActiveProject{$s=Get-State;return ($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project))}
function HasActiveModule{$s=Get-State;return ($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module))}
$cmd=([string]$Command).Trim().ToLowerInvariant()
# E10O_NEW_PROJECT_SAFE_ROUTE_BEGIN
if($cmd -eq "nuevo-proyecto"){
  & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-new-project-safe.ps1")
  exit
}
# E10O_NEW_PROJECT_SAFE_ROUTE_END
$cmdArg=([string]$Arg).Trim()
if($cmd -eq "abrir" -and $cmdArg -eq "proyecto"){$cmd="abrir-proyecto"}
if($cmd -eq "abrir" -and $cmdArg -eq "modulo"){$cmd="abrir-modulo"}
if($cmd -in @("abrir-proyecto","nuevo-proyecto","projects","proyectos","abrir-modulo","nuevo-modulo")){if($cmd -in @("abrir-modulo","nuevo-modulo") -and !(HasActiveProject)){L "WARN abre primero un proyecto" Yellow;exit};if($cmd -eq "proyectos"){$cmd="projects"};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-context.ps1") $cmd;exit}
if($cmd -in @("estado","status","compact-status","estado-compacto")){& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-status.ps1");exit}
if($cmd -in @("biblioteca","biblioteca-modulos","importar-modulo")){if(!(HasActiveProject)){L "WARN abre primero un proyecto" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-library-import.ps1");exit}
if($cmd -in @("revisar-proyecto")){if(!(HasActiveProject)){L "WARN abre primero un proyecto" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-review-project.ps1");exit}
if($cmd -in @("preparar-smoke")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-smoke.ps1");exit}
if($cmd -in @("contrato","tareas","evidencias","gates")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-artifact.ps1") $cmd;exit}
if($cmd -in @("objetivo")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-objective.ps1");exit}
if($cmd -in @("editar")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-edit.ps1");exit}
if($cmd -in @("cerrar-modulo")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-close.ps1");exit}
if($cmd -in @("promover")){if(!(HasActiveModule)){L "WARN entra primero en un modulo" Yellow;exit};& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-promote.ps1");exit}
L ("WARN comando_no_soportado="+$cmd) Yellow;exit

# ENGREMIAT_E02E_PROJECTS_MANAGER_ROUTE
function Invoke-EngremiatProjectsManager {
  $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  if(Test-Path -LiteralPath $manager){
    & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
    return
  }
  Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
  Read-Host "Enter para volver"
}
function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
function Show-Projects { Invoke-EngremiatProjectsManager }
function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }
