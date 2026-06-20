$ErrorActionPreference='Stop'
param([int]$PidToWatch)
if(-not (Get-Process -Id $PidToWatch -ErrorAction SilentlyContinue)){ throw 'Process not found.' }
$spin=@('|','/','-','\')
$i=0
while($true){
  $p=Get-Process -Id $PidToWatch -ErrorAction SilentlyContinue
  if(-not $p){ Write-Host 'OK process finished'; break }
  Write-Host -NoNewline ("`rLOADING PID=" + $PidToWatch + " " + $spin[$i % 4]);
  [Console]::Out.Flush()
  Start-Sleep -Milliseconds 300
  $i++
}
