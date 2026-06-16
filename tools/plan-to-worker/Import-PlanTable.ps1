$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
function ReadAllLinesStrong([string]$Path){$text=[System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $Path).Path,[System.Text.Encoding]::UTF8);$text=$text -replace "`r`n","`n";$text=$text -replace "`r","`n";return @($text -split "`n" | Where-Object { $_ -ne $null -and $_ -ne "" })}
function ParseDelimited([string]$Path,[string]$Delimiter){$lines=ReadAllLinesStrong $Path;if($lines.Count -lt 2){throw ('El archivo tabular necesita cabecera y al menos una fila lines_detected='+$lines.Count)};$headers=@($lines[0].Split($Delimiter));$items=@();for($lineIndex=1;$lineIndex -lt $lines.Count;$lineIndex++){if([string]::IsNullOrWhiteSpace($lines[$lineIndex])){continue};$values=@($lines[$lineIndex].Split($Delimiter));$obj=[ordered]@{};for($colIndex=0;$colIndex -lt $headers.Count;$colIndex++){$value='';if($colIndex -lt $values.Count){$value=$values[$colIndex]};$obj[[string]$headers[$colIndex]]=$value};$items+=[pscustomobject]$obj};return [ordered]@{headers=$headers;rows=$items}}
try{
$InputPath=[string]$args[0]
$OutPath=[string]$args[1]
if([string]::IsNullOrWhiteSpace($InputPath)){throw 'Uso: Import-PlanTable.ps1 <path> [outPath]'}
if([string]::IsNullOrWhiteSpace($OutPath)){$OutPath='data/plan-to-worker/imported-plan-raw.json'}
if(!(Test-Path -LiteralPath $InputPath -PathType Leaf)){throw ('Archivo no encontrado: '+$InputPath)}
$extension=[System.IO.Path]::GetExtension($InputPath).ToLowerInvariant().TrimStart('.')
$format='UNKNOWN';$columns=@();$rows=@()
$firstLine=(ReadAllLinesStrong $InputPath|Select-Object -First 1)
$tab=[char]9
if($extension -eq 'json'){$format='JSON';$json=Get-Content -LiteralPath $InputPath -Raw -Encoding UTF8|ConvertFrom-Json;if($json.rows){$rows=@($json.rows)}elseif($json -is [array]){$rows=@($json)}else{$rows=@($json)};$first=$rows|Select-Object -First 1;if($first){$columns=@($first.PSObject.Properties.Name)}}elseif($extension -eq 'xlsx'){throw 'XLSX detectado, pero E02 no importa XLSX sin dependencia externa. Exporta desde Sheets como TSV o CSV.'}else{if($extension -eq 'tsv' -or ($firstLine -and $firstLine.Contains($tab))){$format='TSV';$parsed=ParseDelimited $InputPath $tab}elseif($extension -eq 'csv' -or ($firstLine -and $firstLine.Contains(','))){$format='CSV';$parsed=ParseDelimited $InputPath ','}else{throw ('Formato tabular no soportado o delimitador no detectado: '+$extension)};$columns=@($parsed.headers);$rows=@($parsed.rows)}
if($rows.Count -eq 0){throw 'Importacion sin filas'}
$required=@('objective_id','stage_id','block_id','step_id','status');$missing=@();foreach($col in $required){if(-not($columns -contains $col)){$missing+=$col}}
if($missing.Count -gt 0){throw ('Faltan columnas minimas: '+($missing -join ',')+' headers_detected='+($columns -join '|'))}
$structured=@();foreach($row in $rows){$structured+=[ordered]@{objective_id=[string]$row.objective_id;stage_id=[string]$row.stage_id;stage_name=[string]$row.stage_name;block_id=[string]$row.block_id;block_name=[string]$row.block_name;step_id=[string]$row.step_id;step_title=[string]$row.step_title;artifact=[string]$row.artifact;depends_on=[string]$row.depends_on;format=[string]$row.format;risk=[string]$row.risk;requires_human=[string]$row.requires_human;priority=[string]$row.priority;status=[string]$row.status;notes=[string]$row.notes}}
$raw=[ordered]@{objective_id='ENGREMIAT_PLAN_TO_WORKER_APP_001';stage='E02';source_path=$InputPath;format=$format;columns=$columns;row_count=$structured.Count;rows=$structured;external_network=$false;google_api=$false;created_at=(Get-Date).ToString('s')}
WriteJsonFile $OutPath $raw
Write-Host ('OK import=True format='+$format+' rows='+$structured.Count+' out='+$OutPath)
}catch{Write-Host ('ERR import=False message='+$_.Exception.Message) -ForegroundColor Red;throw}