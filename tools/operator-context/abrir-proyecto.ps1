param([string]$InputValue="")
$ErrorActionPreference="Stop"
$root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$registryPath=Join-Path $root "data\operator-state\project-registry.json"
$activePath=Join-Path $root "data\operator-state\active-context.json"
$r=Get-Content -LiteralPath $registryPath -Raw|ConvertFrom-Json
$items=@($r.projects)|Where-Object{$_.name -like "ENGREMIAT_PROJECT*" -and $_.name -ne "ENGREMIAT_PROJECT_VAULT_TEMPLATE" -and $_.path -notmatch "\\templates\\"}|Sort-Object name -Descending
if(!$InputValue){Write-Host "PROYECTOS DISPONIBLES PARA ACTIVAR" -ForegroundColor Cyan;$i=0;$items|ForEach-Object{$i++;Write-Host (" [{0}] {1}" -f $i,$_.name)};$InputValue=Read-Host "Numero o ID"}
$raw=($InputValue -as [string]).Trim()
$p=$null
if($raw -match "^\d+$"){$n=[int]$raw;if($n -ge 1 -and $n -le @($items).Count){$p=@($items)[$n-1]}}
if(!$p -and $raw -match "(ENGREMIAT_PROJECT[A-Z0-9_]+)"){$candidate=$Matches[1];$p=@($items)|Where-Object{$_.id -eq $candidate}|Select-Object -First 1}
if(!$p){$p=@($items)|Where-Object{$_.id -eq $raw -or $_.name -eq $raw -or $_.path -eq $raw}|Select-Object -First 1}
if(!$p){throw "Proyecto activo no encontrado. Usa: abrir-proyecto 1, abrir-proyecto 2 o abrir-proyecto 3."}
$ctx=Get-Content -LiteralPath $activePath -Raw|ConvertFrom-Json
$history=@($items|Where-Object{$_.id -ne $p.id}|Select-Object -First 2)
$ctx|Add-Member -Force -NotePropertyName historical_projects -NotePropertyValue @($history|ForEach-Object{[pscustomobject]@{id=$_.id;name=$_.name;path=$_.path;type="HISTORICAL_PROJECT";status="HISTORICAL"}})
$ctx|Add-Member -Force -NotePropertyName active_project -NotePropertyValue ([pscustomobject]@{id=$p.id;name=$p.name;path=$p.path;type="ENGREMIAT_PROJECT";opened_at=(Get-Date).ToString("s");status="ACTIVE"})
$ctx|ConvertTo-Json -Depth 12|Set-Content -LiteralPath $activePath -Encoding UTF8
Write-Host ("OK active_project={0}" -f $p.id) -ForegroundColor Green
Write-Host ("path={0}" -f $p.path) -ForegroundColor Cyan
Write-Host "next=E04_PROJECT_MODULE_TARGET_DECISION" -ForegroundColor Magenta
