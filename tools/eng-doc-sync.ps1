$ErrorActionPreference='Stop'
param([string]$Mode='sync')
$ts=(Get-Date).ToString('o')
New-Item -ItemType Directory -Force -Path 'docs'|Out-Null
if($Mode -eq 'sync'){
# minimal safe sync: refresh DEVELOPMENT_LOG from key reports
  $lines=@('# DEVELOPMENT LOG','','Updated: '+$ts,'','## Key reports')
  Get-ChildItem 'reports' -Recurse -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 30|ForEach-Object{$lines += '- `'+$_.FullName.Replace((Get-Location).Path+'\','')+'`'}
  $lines -join [Environment]::NewLine|Set-Content 'docs/DEVELOPMENT_LOG.md' -Encoding UTF8
  Write-Host 'OK tool=eng-doc-sync mode=sync doc=docs/DEVELOPMENT_LOG.md'
  return
}
Write-Host 'OK tool=eng-doc-sync modes=sync'
