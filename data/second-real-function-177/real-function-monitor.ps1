$ErrorActionPreference='Stop'
param([int]$PidToWatch)
$spin=@('|','/','-','\')
$start=Get-Date
$timeout=180
while($true){
  $p=Get-Process -Id $PidToWatch -ErrorAction SilentlyContinue
  if(-not $p){ Write-Host 'OK process finished'; break }
  $elapsed=[int]((Get-Date)-$start).TotalSeconds
  if($elapsed -ge $timeout){ Write-Host 'NO_GO timeout reached'; break }
  Write-Host -NoNewline ('`rLOADING PID=' + $PidToWatch + ' elapsed=' + $elapsed + 's ' + $spin[$elapsed % 4])
  [Console]::Out.Flush()
  Start-Sleep -Milliseconds 300
}
