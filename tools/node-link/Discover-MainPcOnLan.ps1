$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$names=@("pc","MAIN-PC","ENGREMIAT-MAIN","DESKTOP-PC")
$candidates=@()
foreach($n in $names){try{$ips=@([System.Net.Dns]::GetHostAddresses($n)|Where-Object{$_.AddressFamily -eq "InterNetwork"}|ForEach-Object{$_.IPAddressToString});foreach($ip in $ips){$candidates+=[ordered]@{source="dns";name=$n;ip=$ip}}}catch{}}
$candidates|ConvertTo-Json -Depth 20
Write-Host "OK discovery_readonly=True aggressive_scan=False firewall_changed=False"
