param([string]$InputValue="")
$ErrorActionPreference="Stop"
$target=Join-Path $PSScriptRoot "abrir-proyecto.ps1"
if(!(Test-Path $target)){throw "Falta abrir-proyecto.ps1"}
if($InputValue){& powershell -NoProfile -ExecutionPolicy Bypass -File $target -InputValue $InputValue}else{& powershell -NoProfile -ExecutionPolicy Bypass -File $target}
