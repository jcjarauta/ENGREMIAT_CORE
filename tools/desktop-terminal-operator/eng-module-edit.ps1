$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_module_vault)){throw "no_active_module_vault"}
$vault=[string]$s.active_module_vault
$map=@{ "1"="CONTRATO.md"; "contrato"="CONTRATO.md"; "c"="CONTRATO.md"; "2"="TAREAS.md"; "tareas"="TAREAS.md"; "t"="TAREAS.md"; "3"="EVIDENCIAS.md"; "evidencias"="EVIDENCIAS.md"; "ev"="EVIDENCIAS.md"; "4"="GATES.md"; "gates"="GATES.md"; "g"="GATES.md" }
$kind=if($args.Count -gt 0){([string]$args[0]).Trim().ToLowerInvariant()}else{""}
if([string]::IsNullOrWhiteSpace($kind)){L "EDITAR ARTEFACTO" Cyan;L " [1] Contrato" Green;L " [2] Tareas" Green;L " [3] Evidencias" Green;L " [4] Gates" Green;$kind=(Read-Host "Elige artefacto").Trim().ToLowerInvariant()}
if(!$map.ContainsKey($kind)){throw "unknown_artifact=$kind"}
$file=Join-Path $vault $map[$kind]
if(!(Test-Path -LiteralPath $file)){& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-artifact.ps1") ($map[$kind].Replace(".md","").ToLowerInvariant()) | Out-Null}
L ("OPEN editor="+$file) Cyan
Start-Process notepad.exe -ArgumentList @($file)
L "OK editor_abierto=True" Green
L "NEXT guarda el archivo en Notepad y vuelve al launcher; Enter refresca pantalla limpia" Magenta
