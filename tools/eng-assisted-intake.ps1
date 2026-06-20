$ErrorActionPreference='Stop'
param([string]$InFile='prompts/inbox/assisted-result.json',[string]$OutFile='data/dev-assisted-worker/assisted-result-proposal.json')
New-Item -ItemType Directory -Force -Path (Split-Path $OutFile -Parent)|Out-Null
if(Test-Path $InFile){$raw=Get-Content $InFile -Raw -Encoding UTF8}else{$raw='{}'}
$parsed=$null;try{$parsed=$raw|ConvertFrom-Json}catch{$parsed=[ordered]@{summary='RAW_OR_INVALID';apply_recommendation='NO_GO'}}
$out=[ordered]@{imported_at=(Get-Date).ToString('o');source=$InFile;proposal=$parsed;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false}
 $out|ConvertTo-Json -Depth 30|Set-Content $OutFile -Encoding UTF8
Write-Host ('OK tool=eng-assisted-intake output='+$OutFile+' apply_executed=False')
