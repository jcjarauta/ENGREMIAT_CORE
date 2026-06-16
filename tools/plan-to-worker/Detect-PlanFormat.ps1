$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WriteJsonFile([string]$Path,$Object){$dir=Split-Path -Parent $Path;if($dir -and !(Test-Path -LiteralPath $dir)){New-Item -ItemType Directory -Path $dir -Force|Out-Null};$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
$InputPath=[string]$args[0]
if([string]::IsNullOrWhiteSpace($InputPath)){throw 'Uso: Detect-PlanFormat.ps1 <path>'}
if(!(Test-Path -LiteralPath $InputPath -PathType Leaf)){throw ('Archivo no encontrado: '+$InputPath)}
$extension=[System.IO.Path]::GetExtension($InputPath).ToLowerInvariant().TrimStart('.')
$format='UNKNOWN';$method='UNSUPPORTED';$importable=$false
$head=(Get-Content -LiteralPath $InputPath -TotalCount 1 -Encoding UTF8 -ErrorAction SilentlyContinue)
$tab=[char]9
if($extension -eq 'tsv'){$format='TSV';$method='ConvertFrom-Csv delimiter TAB';$importable=$true}elseif($extension -eq 'csv'){$format='CSV';$method='Import-Csv';$importable=$true}elseif($extension -eq 'json'){$format='JSON';$method='ConvertFrom-Json';$importable=$true}elseif($extension -eq 'xlsx'){$format='XLSX';$method='DETECTED_ONLY_EXPORT_TO_TSV_OR_CSV_RECOMMENDED';$importable=$false}elseif($head -and $head.Contains($tab)){$format='TSV';$method='ConvertFrom-Csv delimiter TAB';$importable=$true}elseif($head -and $head.Contains(',')){$format='CSV';$method='Import-Csv';$importable=$true}
$result=[ordered]@{path=$InputPath;extension=$extension;format=$format;method=$method;importable=$importable;external_network=$false;google_api=$false;created_at=(Get-Date).ToString('s')}
WriteJsonFile 'data/plan-to-worker/detected-plan-format.json' $result
Write-Host ('OK detector=True format='+$format+' importable='+$importable+' path='+$InputPath)
}catch{Write-Host ('ERR detector=False message='+$_.Exception.Message) -ForegroundColor Red;throw}
