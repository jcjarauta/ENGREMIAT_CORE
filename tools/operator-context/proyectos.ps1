param([string]$Filter="")
$ErrorActionPreference="Stop"
$root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$registryPath=Join-Path $root "data\operator-state\project-registry.json"
$activePath=Join-Path $root "data\operator-state\active-context.json"
$r=Get-Content -LiteralPath $registryPath -Raw|ConvertFrom-Json
$ctx=Get-Content -LiteralPath $activePath -Raw|ConvertFrom-Json
$items=@($r.projects)|Where-Object{$_.name -like "ENGREMIAT_PROJECT*" -and $_.name -ne "ENGREMIAT_PROJECT_VAULT_TEMPLATE" -and $_.path -notmatch "\\templates\\"}|Sort-Object name -Descending
if($Filter){$items=$items|Where-Object{$_.id -like "*$Filter*" -or $_.name -like "*$Filter*" -or $_.path -like "*$Filter*"}}
$activeId="";if($ctx.active_project){$activeId=$ctx.active_project.id}
$histIds=@();if($ctx.historical_projects){$histIds=@($ctx.historical_projects|ForEach-Object{$_.id})}
Write-Host "ENGREMIAT: proyectos" -ForegroundColor Cyan
Write-Host "PROYECTOS HISTORICOS / DISPONIBLES" -ForegroundColor Cyan
$i=0;$items|ForEach-Object{$i++;$tag="";if($_.id -eq $activeId){$tag=" ACTIVE"}elseif($histIds -contains $_.id){$tag=" HISTORICO"};$dt="";try{$dt=(Get-Item -LiteralPath $_.path).CreationTime.ToString("yyyy-MM-dd HH:mm")}catch{};Write-Host (" [{0}] {1}  {2}{3}" -f $i,$_.name,$dt,$tag)}
Write-Host ""
Write-Host "proyectos = listar | abrir-proyecto 3 = seleccionar activo" -ForegroundColor Magenta
