param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$nextRoot=Join-Path $Root 'data\_OFFICIAL_MODULES\_NEXT_MODULES'
$reportDir=Join-Path $Root 'reports\next-modules-global-validator-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$dirs=Get-ChildItem -LiteralPath $nextRoot -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like 'ENGREMIAT_*'}
$items=@()
$ids=@{}
foreach($d in $dirs){
  $moduleJson=Join-Path $d.FullName 'module.json'
  $contracts=Join-Path $d.FullName 'contracts'
  $schemas=Join-Path $d.FullName 'schemas'
  $gates=Join-Path $d.FullName 'gates'
  $reports=Join-Path $d.FullName 'reports'
  $errors=@()
  $warnings=@()
  $moduleId=$null
  $active=$null
  if(!(Test-Path $moduleJson)){ $errors+='missing_module_json' } else {
    try{
      $m=Get-Content -LiteralPath $moduleJson -Raw -Encoding UTF8|ConvertFrom-Json
      $moduleId=[string]$m.module_id
      $active=$m.active
      if($moduleId -ne $d.Name){ $errors+='module_id_folder_mismatch' }
      if($active -eq $true){ $errors+='candidate_active_true' }
      if($ids.ContainsKey($moduleId)){ $errors+='duplicate_module_id'; $ids[$moduleId]+=1 } else { $ids[$moduleId]=1 }
    }catch{ $errors+='invalid_module_json' }
  }
  if(!(Test-Path $contracts)){ $warnings+='missing_contracts_dir' }
  if(!(Test-Path $schemas)){ $warnings+='missing_schemas_dir' }
  if(!(Test-Path $gates)){ $warnings+='missing_gates_dir' }
  if(!(Test-Path $reports)){ $warnings+='missing_reports_dir' }
  $items += [ordered]@{folder=$d.Name;path=$d.FullName;module_id=$moduleId;active=$active;errors=$errors;warnings=$warnings;status=$(if($errors.Count -eq 0){'PASS'}else{'ERR'})}
}
$errCount=($items|Where-Object{$_.status -eq 'ERR'}).Count
$warnCount=($items|Where-Object{$_.warnings.Count -gt 0}).Count
$report=[ordered]@{package_id='ENGREMIAT_NEXT_MODULES_GLOBAL_VALIDATOR_001';status=$(if($errCount -eq 0){'PASS'}else{'ERR'});readiness=$(if($errCount -eq 0){100}else{0});next_modules_root=$nextRoot;modules_scanned=$items.Count;errors=$errCount;warnings=$warnCount;items=$items;policy=[ordered]@{local_only=$true;core_changes=$false;real_module_activation=$false;git_write=$false;network=$false;real_sheets_write=$false};next=$(if($errCount -eq 0){'ENGREMIAT_SHEETS_REAL_GATE_INTEGRATION_001'}else{'REPAIR_NEXT_MODULES_CANDIDATES'})}
$reportPath=Join-Path $reportDir 'next-modules-global-validation-report.json'
WJson $reportPath $report
Write-Host ("OK next_modules_global_validator status="+$report.status+" readiness="+$report.readiness+" modules_scanned="+$items.Count+" errors="+$errCount+" warnings="+$warnCount+" report="+$reportPath+" next="+$report.next)
if($errCount -gt 0){ exit 1 }
