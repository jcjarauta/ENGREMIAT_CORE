$ErrorActionPreference='Stop'
param([string]$Mode='known',[string]$Query='')
$mem='data/errors/error-memory.jsonl'
$last='data/errors/last-error.json'
if($Mode -eq 'last'){if(Test-Path $last){Get-Content $last -Raw -Encoding UTF8}else{Write-Host 'WARN no last error'};return}
if(-not (Test-Path $mem)){throw 'ERROR_MEMORY_NOT_FOUND'}
$items=Get-Content $mem -Encoding UTF8|Where-Object{$_}|ForEach-Object{$_|ConvertFrom-Json}
if($Mode -eq 'hints'){$items|Select-Object error_id,error_signature,prevention_rule|Format-Table -AutoSize;return}
if($Query){$items|Where-Object{$_.error_signature -match $Query -or $_.error_id -match $Query}|Format-Table error_id,status,prevention_rule -AutoSize;return}
$items|Format-Table error_id,status,error_signature -AutoSize
