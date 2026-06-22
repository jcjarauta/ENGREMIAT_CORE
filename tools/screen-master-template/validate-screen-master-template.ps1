$ErrorActionPreference = "Stop"
$Root = "C:\ENGREMIAT_CORE"
$Contract = Join-Path $Root "documents\screen-master-template\contracts\screen-master-template-contract.v1.json"
$Snippet = Join-Path $Root "documents\screen-master-template\templates\screen-master-template-snippet.v1.ps1"
$Inicio = Join-Path $Root "tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1"

function ParseOk($p){
  $errs=$null;$tok=$null
  [System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$tok,[ref]$errs)|Out-Null
  return ($errs.Count -eq 0)
}

$checks = [ordered]@{}
$checks.contract_exists = Test-Path $Contract
$checks.snippet_exists = Test-Path $Snippet
$checks.snippet_parse = ParseOk $Snippet
$checks.inicio_exists = Test-Path $Inicio
$checks.inicio_parse = ParseOk $Inicio

$inicioText = if(Test-Path $Inicio){ Get-Content $Inicio -Raw -Encoding UTF8 } else { "" }
$checks.inicio_has_enter_refresh = ($inicioText -match 'IsNullOrWhiteSpace\(\$c\).*continue')
$checks.inicio_has_b_return = ($inicioText -match '"b"\s*\{\s*return\s*\}')
$checks.inicio_has_q_return = ($inicioText -match '"q"\s*\{\s*return\s*\}')
$checks.inicio_has_m_card = ($inicioText -match '"m"\s*\{\s*MaintenanceCardFromInicio\s*\}')
$checks.inicio_has_help = ($inicioText -match '"\?"\s*\{\s*Help\s*\}')
$checks.inicio_has_cancel = ($inicioText -match 'Cancelar: b / q / c / cancelar')

$ok = -not ($checks.Values -contains $false)
Write-Host ("SCREEN_MASTER_TEMPLATE_VALIDATION ok=" + $ok) -ForegroundColor Cyan
$checks.GetEnumerator() | ForEach-Object { Write-Host ($_.Key + "=" + $_.Value) }
if(!$ok){ exit 2 }
