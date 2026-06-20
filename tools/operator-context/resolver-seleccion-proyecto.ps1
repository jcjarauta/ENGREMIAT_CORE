param([string]$InputValue="")
$ErrorActionPreference="Stop"
$root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$registryPath=Join-Path $root "data\operator-state\project-registry.json"
$activePath=Join-Path $root "data\operator-state\active-context.json"
$viewPath=Join-Path $root "data\operator-state\last-view.json"
if(!(Test-Path $registryPath)){throw "Falta project-registry.json"}
if(!(Test-Path $activePath)){throw "Falta active-context.json"}
$raw=($InputValue -as [string]).Trim()
if(!$raw){$raw=Read-Host "Numero o ID de proyecto"}
$r=Get-Content -LiteralPath $registryPath -Raw|ConvertFrom-Json
$items=@($r.projects)|Where-Object{$_.name -like "ENGREMIAT_PROJECT*" -and $_.name -ne "ENGREMIAT_PROJECT_VAULT_TEMPLATE" -and $_.path -notmatch "\\templates\\"}|Sort-Object name -Descending
$p=$null
if($raw -match "^\s*(\d+)\s*\.?"){$n=[int]$Matches[1];if($n -ge 1 -and $n -le @($items).Count){$p=@($items)[$n-1]}}
if(!$p -and $raw -match "(ENGREMIAT_PROJECT[A-Z0-9_]+)"){$candidate=$Matches[1];$p=@($items)|Where-Object{$_.id -eq $candidate}|Select-Object -First 1}
if(!$p){$p=@($items)|Where-Object{$_.id -eq $raw -or $_.name -eq $raw -or $_.path -eq $raw}|Select-Object -First 1}
if(!$p){Write-Host "NO_GO proyecto_no_encontrado=$raw" -ForegroundColor Yellow;Write-Host "Usa: proyectos y luego solo el numero, por ejemplo 1" -ForegroundColor Magenta;exit 2}
$ctx=Get-Content -LiteralPath $activePath -Raw|ConvertFrom-Json
$ctx|Add-Member -Force -NotePropertyName active_project -NotePropertyValue ([pscustomobject]@{id=$p.id;name=$p.name;path=$p.path;type="ENGREMIAT_PROJECT";opened_at=(Get-Date).ToString("s");status="ACTIVE"})
$ctx|ConvertTo-Json -Depth 10|Set-Content -LiteralPath $activePath -Encoding UTF8
[pscustomobject]@{last_view="project_opened";active_project=$p.id;path=$p.path;updated_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 6|Set-Content -LiteralPath $viewPath -Encoding UTF8
Write-Host ("OK active_project={0}" -f $p.id) -ForegroundColor Green
Write-Host ("path={0}" -f $p.path) -ForegroundColor Cyan
Write-Host "next=E04_PROJECT_MODULE_TARGET_DECISION" -ForegroundColor Magenta
