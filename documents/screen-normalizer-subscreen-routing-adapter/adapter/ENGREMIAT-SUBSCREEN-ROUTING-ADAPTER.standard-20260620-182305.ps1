$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# ENGREMIAT isolated subscreen routing adapter - STANDARD TEMPLATE
# Safe mode: no patch launcher, no registry write, no git, no network, no workers

$Root = 'C:\ENGREMIAT_CORE'
$Screens = @(
    [pscustomobject]@{ id='PROYECTOS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\PROYECTOS.candidate.isolated.ps1'; sha256='F56F1F3C73F22CFFD5F6E6E5FFF1CA87EA97B8282B69CB656B13A1E013E7F465' },
    [pscustomobject]@{ id='MEMORIA_DOCUMENTACION'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\MEMORIA_DOCUMENTACION.candidate.isolated.ps1'; sha256='CA09A41904F9C0FB923457DFC7BBEE8B1A7C05CD8668526915A3FED5F07A0C24' },
    [pscustomobject]@{ id='CONTROL_ESTADO'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\CONTROL_ESTADO.candidate.isolated.ps1'; sha256='72E585DAC556CBC0B903F1B109814250F56E3CEC44D072C8997F601BD0049FEB' },
    [pscustomobject]@{ id='LAUNCHERS_CONFIGURACION'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\LAUNCHERS_CONFIGURACION.candidate.isolated.ps1'; sha256='58608C17B1BCFDB421A6CF2122DA9F1CB6D79CFB2C92242217B8B6E294618F59' },
    [pscustomobject]@{ id='OPERADOR_WORKERS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\OPERADOR_WORKERS.candidate.isolated.ps1'; sha256='25BFF4B6AD3252F4CC180F094D8F81732AA865007B5FEB0CF8471D947FFD9E35' },
    [pscustomobject]@{ id='TARJETAS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\TARJETAS.candidate.isolated.ps1'; sha256='ADBACC220A4D00CE025211FD7436F08698913D42F1B6465DB0F731EAAAE6AD92' }
)

function Line($t='',$c='Gray'){ Write-Host $t -ForegroundColor $c }
function Box($title,$lines,$color='Cyan'){ Line ""; Line ("==== {0} ====" -f $title) $color; foreach($l in @($lines)){ Line $l 'Gray' } }
function Show-Header {
  Clear-Host
  Line "==== ENGREMIAT SUBSCREEN ROUTING ADAPTER ====" 'Cyan'
  Line "Ruta: INICIO > ADAPTER AISLADO > SUBPANTALLAS NORMALIZADAS" 'DarkGray'
  Line "Rol: probar navegacion a pantallas normalizadas sin tocar launcher general" 'DarkGray'
  Line "Estado: AISLADO / NO_PATCH / READONLY_NAVIGATION" 'DarkGray'
  Line "Principio: registry/helper primero; launcher general intacto; una pantalla por prueba" 'DarkGray'
  Line ""
  Line "INDICADORES" 'Yellow'
  Line " adapter_parse=OK | screens=6 | launcher_patch=False | registry_write=False | git=False" 'DarkGray'
  Line " mantenimiento=m dry-run | ayuda=? | refrescar=Enter | salir=b/q" 'DarkGray'
  Line ""
}

function Show-Menu {
  Show-Header
  Line "SUBPANTALLAS NORMALIZADAS" 'Cyan'
  for($i=0;$i -lt $Screens.Count;$i++){ Line (" [{0}] {1}" -f ($i+1),$Screens[$i].id) 'Gray' }
  Line ""
  Line "COMANDOS" 'Cyan'
  Line " Enter/refrescar/f5 = redibujar pantalla | ? = ayuda | m = mantenimiento | q/b = salir" 'DarkGray'
  Line " numero = abrir subpantalla aislada" 'DarkGray'
  Line ""
}

function Show-Help {
  Show-Header
  Box "AYUDA" @(
    "Este adapter prueba subpantallas normalizadas generadas desde registry/helper.",
    "No modifica ENGREMIAT-LAUNCHER-ACTUAL.ps1.",
    "No escribe registry, no usa git, no red, no workers.",
    "Flujo recomendado: elegir numero, revisar pantalla, volver con b/q, validar visualmente.",
    "Criterio PASS: header claro, indicadores, Enter refresca, ? ayuda, m mantenimiento, b/q salir."
  )
  Read-Host "Enter para volver" | Out-Null
}

function Show-Maintenance {
  Show-Header
  Box "MANTENIMIENTO / DRY-RUN" @(
    "maintenance_mode=DRY_RUN",
    "adapter=C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1",
    "launcher_general_untouched=True",
    "patch_existing_launchers=False",
    "registry_write=False",
    "migration_applied=False",
    "git=False",
    "next=visual_smoke_repair_then_retry"
  ) 'Yellow'
  Read-Host "Enter para volver" | Out-Null
}

while($true){
  Show-Menu
  $c = Read-Host "ENGREMIAT_ADAPTER"
  if([string]::IsNullOrWhiteSpace($c) -or $c -eq "f5" -or $c -eq "refrescar"){ continue }
  if($c -eq "q" -or $c -eq "b"){ break }
  if($c -eq "?"){ Show-Help; continue }
  if($c -eq "m"){ Show-Maintenance; continue }
  $n = 0
  if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $Screens.Count){
    $s = $Screens[$n-1]
    Line ""
    Line ("OPEN_SUBSCREEN screen={0} path={1}" -f $s.id,$s.path) 'Green'
    & powershell -NoProfile -ExecutionPolicy Bypass -File $s.path
    Line ""
    Read-Host "Enter para volver al adapter" | Out-Null
    continue
  }
  Line "Comando no reconocido. Usa numero, Enter, f5, ?, m, b o q." 'Yellow'
  Start-Sleep -Milliseconds 700
}