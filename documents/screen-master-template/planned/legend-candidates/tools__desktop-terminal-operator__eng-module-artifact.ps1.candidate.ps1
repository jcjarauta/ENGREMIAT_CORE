Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_module_vault)){throw "no_active_module_vault"}
$kind=if($args.Count -gt 0){([string]$args[0]).Trim().ToLowerInvariant()}else{"contrato"}
$map=@{contrato="CONTRATO.md";tareas="TAREAS.md";evidencias="EVIDENCIAS.md";gates="GATES.md"}
if(!$map.ContainsKey($kind)){throw "unknown_artifact=$kind"}
$vault=[string]$s.active_module_vault
D $vault
$file=Join-Path $vault $map[$kind]
if(!(Test-Path -LiteralPath $file)){
  $title=$kind.ToUpperInvariant()
  Set-Content -LiteralPath $file -Encoding UTF8 -Value "# $title $($s.active_module)`r`n`r`nProyecto: $($s.active_project)`r`nModulo: $($s.active_module)`r`nEstado: ACTIVE_IN_PROJECT`r`n`r`nPendiente de completar.`r`n"
  L ("OK created="+$file) Green
}
L ("ARTEFACTO "+$kind.ToUpperInvariant()) Cyan
L ("file="+$file) DarkCyan
L "----------------------------------------" DarkGray
Get-Content -LiteralPath $file -Encoding UTF8 | Select-Object -First 80 | ForEach-Object{Write-Host $_}
L "----------------------------------------" DarkGray
L ("NEXT editar archivo o continuar: modulo | tareas | evidencias | gates | preparar-smoke") Magenta
