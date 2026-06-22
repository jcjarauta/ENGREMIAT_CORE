# E09 classify selected candidate screen or action NO_APPLY

## Decision
NO_GO_EXCLUDE_ACTION_SCRIPT_FROM_SCREEN_TEMPLATE

## Classification
ACTION_SCRIPT_WITH_PROMPTS

## Target
- path: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-add-module-safe.ps1
- parse: 
True
- screen_score: 
2
- action_score: 
4
- readhost_count: 
1
- write_count: 
7

## Checks
- has_loop: 
False
- has_menu: 
False
- has_header: 
True
- has_readhost: 
True
- has_action_name: 
True
- has_writes: 
True

## Conclusion
Este archivo no debe migrarse como pantalla master. Debe tratarse como accion segura con prompts, y la pantalla que lo invoca debe ofrecer m/b/q/Enter/?

## Context
### around line 1
    1: param([string]$ProjectPath="",[string]$ModuleName="")
    2: $ErrorActionPreference="Stop"
    3: function W($m,$c="White"){Write-Host $m -ForegroundColor $c}
    4: if([string]::IsNullOrWhiteSpace($ProjectPath) -or -not(Test-Path $ProjectPath)){ $ap=Join-Path $PSScriptRoot "eng-active-project.ps1"; if(Test-Path $ap){ $ProjectPath=(& powershell -NoProfile -ExecutionPolicy Bypass -File $ap -ProjectPath $ProjectPath).Trim() } else { throw "active_project_helper_missing" } }
    5: if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName=Read-Host "nombre_modulo"; if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName="MODULE_"+(Get-Date -Format "yyyyMMdd-HHmmss") } }
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")

### around line 3
    1: param([string]$ProjectPath="",[string]$ModuleName="")
    2: $ErrorActionPreference="Stop"
    3: function W($m,$c="White"){Write-Host $m -ForegroundColor $c}
    4: if([string]::IsNullOrWhiteSpace($ProjectPath) -or -not(Test-Path $ProjectPath)){ $ap=Join-Path $PSScriptRoot "eng-active-project.ps1"; if(Test-Path $ap){ $ProjectPath=(& powershell -NoProfile -ExecutionPolicy Bypass -File $ap -ProjectPath $ProjectPath).Trim() } else { throw "active_project_helper_missing" } }
    5: if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName=Read-Host "nombre_modulo"; if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName="MODULE_"+(Get-Date -Format "yyyyMMdd-HHmmss") } }
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8

### around line 5
    2: $ErrorActionPreference="Stop"
    3: function W($m,$c="White"){Write-Host $m -ForegroundColor $c}
    4: if([string]::IsNullOrWhiteSpace($ProjectPath) -or -not(Test-Path $ProjectPath)){ $ap=Join-Path $PSScriptRoot "eng-active-project.ps1"; if(Test-Path $ap){ $ProjectPath=(& powershell -NoProfile -ExecutionPolicy Bypass -File $ap -ProjectPath $ProjectPath).Trim() } else { throw "active_project_helper_missing" } }
    5: if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName=Read-Host "nombre_modulo"; if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName="MODULE_"+(Get-Date -Format "yyyyMMdd-HHmmss") } }
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8
   10: W "==== OK ====" Green; W "status=PASS" Green; W "module=$safe" Green; W "module_path=$modPath" Green; W "graph=$(Join-Path $ProjectPath 'GRAFO\GRAFO_GLOBAL.md')" Green; W "template_master_modified=False" Green; W "report=$report" Green; W "next=abrir_modulos_y_validar_grafo" Magenta
   11: 

### around line 6
    3: function W($m,$c="White"){Write-Host $m -ForegroundColor $c}
    4: if([string]::IsNullOrWhiteSpace($ProjectPath) -or -not(Test-Path $ProjectPath)){ $ap=Join-Path $PSScriptRoot "eng-active-project.ps1"; if(Test-Path $ap){ $ProjectPath=(& powershell -NoProfile -ExecutionPolicy Bypass -File $ap -ProjectPath $ProjectPath).Trim() } else { throw "active_project_helper_missing" } }
    5: if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName=Read-Host "nombre_modulo"; if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName="MODULE_"+(Get-Date -Format "yyyyMMdd-HHmmss") } }
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8
   10: W "==== OK ====" Green; W "status=PASS" Green; W "module=$safe" Green; W "module_path=$modPath" Green; W "graph=$(Join-Path $ProjectPath 'GRAFO\GRAFO_GLOBAL.md')" Green; W "template_master_modified=False" Green; W "report=$report" Green; W "next=abrir_modulos_y_validar_grafo" Magenta
   11: 

### around line 7
    4: if([string]::IsNullOrWhiteSpace($ProjectPath) -or -not(Test-Path $ProjectPath)){ $ap=Join-Path $PSScriptRoot "eng-active-project.ps1"; if(Test-Path $ap){ $ProjectPath=(& powershell -NoProfile -ExecutionPolicy Bypass -File $ap -ProjectPath $ProjectPath).Trim() } else { throw "active_project_helper_missing" } }
    5: if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName=Read-Host "nombre_modulo"; if([string]::IsNullOrWhiteSpace($ModuleName)){ $ModuleName="MODULE_"+(Get-Date -Format "yyyyMMdd-HHmmss") } }
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8
   10: W "==== OK ====" Green; W "status=PASS" Green; W "module=$safe" Green; W "module_path=$modPath" Green; W "graph=$(Join-Path $ProjectPath 'GRAFO\GRAFO_GLOBAL.md')" Green; W "template_master_modified=False" Green; W "report=$report" Green; W "next=abrir_modulos_y_validar_grafo" Magenta
   11: 

### around line 9
    6: $safe=($ModuleName.Trim() -replace "[^\w\.-]","_"); $modsDir=Join-Path $ProjectPath "MODULOS"; New-Item -ItemType Directory -Force -Path $modsDir|Out-Null; $modPath=Join-Path $modsDir $safe; if(Test-Path $modPath){W "NO_GO modulo ya existe: $modPath" Red; exit 1}; New-Item -ItemType Directory -Force -Path $modPath|Out-Null
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8
   10: W "==== OK ====" Green; W "status=PASS" Green; W "module=$safe" Green; W "module_path=$modPath" Green; W "graph=$(Join-Path $ProjectPath 'GRAFO\GRAFO_GLOBAL.md')" Green; W "template_master_modified=False" Green; W "report=$report" Green; W "next=abrir_modulos_y_validar_grafo" Magenta
   11: 

### around line 10
    7: $module=[pscustomobject]@{id=$safe;name=$ModuleName;type="operational_module";status="ACTIVE";created_at=(Get-Date).ToString("s");project=$ProjectPath;relations=@(@{from="PROJECT";to=$safe;relation="contains_module"})}; $module|ConvertTo-Json -Depth 20|Set-Content (Join-Path $modPath "module.json") -Encoding UTF8; Set-Content (Join-Path $modPath "README.md") -Encoding UTF8 -Value @("# $ModuleName","","Modulo operativo creado de forma limpia.","","## Relaciones","- PROJECT -> $safe : contains_module"); Set-Content (Join-Path $modPath "MODULO.md") -Encoding UTF8 -Value @("# $ModuleName","","Estado: ACTIVE","","Este modulo pertenece al proyecto y debe reflejarse en GRAFO/GRAFO_GLOBAL.md y GRAFO/MODULOS/$safe.md.")
    8: $refresh=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"; if(Test-Path $refresh){ & powershell -NoProfile -ExecutionPolicy Bypass -File $refresh -ProjectPath $ProjectPath } else { W "WARN refresh graph no encontrado" Yellow }
    9: $reportDir="C:\ENGREMIAT_CORE\reports\operator-module-blueprint"; New-Item -ItemType Directory -Force -Path $reportDir|Out-Null; $report=Join-Path $reportDir ("e21d-add-clean-module-and-refresh-graph-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json"); [pscustomobject]@{package="ENGREMIAT_MODULE_ADD_FLOW";stage="E21D_STABLE_ADD_MODULE_AND_EXPAND_GRAPH";status="PASS";project=$ProjectPath;module=$safe;module_path=$modPath;graph=(Join-Path $ProjectPath "GRAFO\GRAFO_GLOBAL.md");dedicated_graph=(Join-Path $ProjectPath ("GRAFO\MODULOS\"+$safe+".md"));template_master_modified=$false;next="abrir_modulos_y_validar_nuevo_modulo_en_grafo"}|ConvertTo-Json -Depth 20|Set-Content $report -Encoding UTF8
   10: W "==== OK ====" Green; W "status=PASS" Green; W "module=$safe" Green; W "module_path=$modPath" Green; W "graph=$(Join-Path $ProjectPath 'GRAFO\GRAFO_GLOBAL.md')" Green; W "template_master_modified=False" Green; W "report=$report" Green; W "next=abrir_modulos_y_validar_grafo" Magenta
   11: 


## Next
E10_SELECT_NEXT_REAL_SCREEN_CANDIDATE_OR_ACTION_PROMPT_CONTRACT
