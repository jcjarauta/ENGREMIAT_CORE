$ErrorActionPreference = "Stop"

function Write-EngremiatUiLine {
  param([string]$Text,[string]$Color = "Gray")
  Write-Host $Text -ForegroundColor $Color
}

function Show-EngremiatScreenHeader {
  param(
    [Parameter(Mandatory=$true)][hashtable]$Screen
  )
  Clear-Host
  Write-EngremiatUiLine ("==== " + $Screen.title + " ====") "Cyan"
  Write-EngremiatUiLine ("Ruta: " + $Screen.route) "DarkCyan"
  Write-EngremiatUiLine ("Rol: " + $Screen.role) "DarkCyan"
  Write-EngremiatUiLine ("Estado: " + $Screen.status) "DarkCyan"
  Write-EngremiatUiLine ("Principio: " + $Screen.principle) "DarkCyan"
  if($Screen.description){ Write-EngremiatUiLine ""; Write-EngremiatUiLine $Screen.description "Gray" }
}

function Show-EngremiatScreenCommands {
  param([hashtable]$Screen)
  Write-EngremiatUiLine ""
  $cmds = @()
  if($Screen.commands){ $cmds += $Screen.commands }
  if(-not ($cmds -match "m = mantenimiento")){ $cmds += "m = mantenimiento" }
  if(-not ($cmds -match "Enter = refrescar")){ $cmds += "Enter = refrescar" }
  if(-not ($cmds -match "\? = ayuda")){ $cmds += "? = ayuda" }
  Write-EngremiatUiLine ($cmds -join " | ") "DarkGray"
}

function Show-EngremiatScreenHelp {
  param([hashtable]$Screen)
  Clear-Host
  Write-EngremiatUiLine ("==== AYUDA / " + $Screen.screen_id + " ====") "Cyan"
  Write-EngremiatUiLine ("Ruta: " + $Screen.route) "DarkCyan"
  Write-EngremiatUiLine ""
  Write-EngremiatUiLine ("Que hace: " + $Screen.description) "Gray"
  Write-EngremiatUiLine ("Estado: " + $Screen.status) "Gray"
  Write-EngremiatUiLine ""
  Write-EngremiatUiLine "Comandos normalizados:" "White"
  Show-EngremiatScreenCommands -Screen $Screen
  Write-EngremiatUiLine ""
  Read-Host "Enter para volver" | Out-Null
}

function Read-EngremiatScreenCommand {
  param([hashtable]$Screen)
  $prompt = if($Screen.prompt){ $Screen.prompt } else { $Screen.screen_id }
  $value = Read-Host $prompt
  if([string]::IsNullOrWhiteSpace($value)){ return "REFRESH" }
  return $value.Trim().ToLowerInvariant()
}

function New-EngremiatHumanMaintenanceCard {
  param([hashtable]$Screen,[switch]$DryRun)
  $root = (Get-Location).Path
  $cardsDir = Join-Path $root "documents\human-maintenance-cards\inbox"
  $ts = Get-Date -Format "yyyyMMdd-HHmmss"
  $id = "HMC-"+$Screen.screen_id+"-"+$ts
  $card = [ordered]@{
    schema = "engremiat.human_maintenance_card.v1"
    id = $id
    created_at = (Get-Date).ToString("s")
    source = "screen-normalizer"
    source_screen = $Screen.screen_id
    route = $Screen.route
    title = "Mantenimiento humano desde " + $Screen.screen_id
    dimension = "ux"
    severity = "MEDIUM"
    observation = "Observacion humana pendiente de detalle"
    suggested_action = "Revisar y convertir en mejora/tarea si procede"
    status = "PENDING_REVIEW"
    dry_run = [bool]$DryRun
  }
  if($DryRun){ return $card }
  New-Item -ItemType Directory -Force -Path $cardsDir | Out-Null
  $path = Join-Path $cardsDir ($id + ".json")
  $card | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $path -Encoding UTF8
  return $path
}

function Invoke-EngremiatMaintenanceFlow {
  param([hashtable]$Screen,[switch]$DryRun)
  $result = New-EngremiatHumanMaintenanceCard -Screen $Screen -DryRun:$DryRun
  if($DryRun){ Write-EngremiatUiLine "OK maintenance_card_dry_run_ready" "Yellow"; return $result }
  Write-EngremiatUiLine ("OK maintenance_card_created path=" + $result) "Green"
  Read-Host "Enter para volver" | Out-Null
  return $result
}

function Show-EngremiatNormalizedScreen {
  param([hashtable]$Screen)
  Show-EngremiatScreenHeader -Screen $Screen
  Write-EngremiatUiLine ""
  if($Screen.options){ foreach($o in $Screen.options){ Write-EngremiatUiLine $o "White" } }
  Show-EngremiatScreenCommands -Screen $Screen
}

Export-ModuleMember -Function Write-EngremiatUiLine,Show-EngremiatScreenHeader,Show-EngremiatScreenCommands,Show-EngremiatScreenHelp,Read-EngremiatScreenCommand,New-EngremiatHumanMaintenanceCard,Invoke-EngremiatMaintenanceFlow,Show-EngremiatNormalizedScreen
