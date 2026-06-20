param([string]$ProjectPath="")
$ErrorActionPreference="Stop"
$stateJson="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\active-project.json"; $stateTxt="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\active-project.txt"
if(-not[string]::IsNullOrWhiteSpace($ProjectPath) -and (Test-Path $ProjectPath)){ $ProjectPath } elseif(Test-Path $stateJson){ $j=Get-Content $stateJson -Raw|ConvertFrom-Json; if($j.active_project -and (Test-Path ([string]$j.active_project))){ [string]$j.active_project } else { throw "active_project_invalid" } } elseif(Test-Path $stateTxt){ $p=(Get-Content $stateTxt -Raw).Trim(); if(Test-Path $p){$p}else{throw "active_project_txt_invalid"} } else { throw "active_project_missing" }
