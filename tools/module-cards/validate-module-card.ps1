param([string]$CardPath="C:\ENGREMIAT_CORE\documents\module-cards\module-linked-card.example.json")
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core='C:\ENGREMIAT_CORE'
$SchemaPath=Join-Path $Core 'documents\module-cards\module-linked-card.schema.json'
function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
if(!(Test-Path $SchemaPath)){throw "Missing schema $SchemaPath"}
if(!(Test-Path $CardPath)){throw "Missing card $CardPath"}
$schema=Get-Content $SchemaPath -Raw|ConvertFrom-Json
$card=Get-Content $CardPath -Raw|ConvertFrom-Json
$missing=@()
foreach($f in @($schema.required_fields)){if(-not ($card.PSObject.Properties.Name -contains $f)){$missing+=$f}}
if($missing.Count -gt 0){throw ("Missing required fields: "+($missing -join ', '))}
if(@($schema.types) -notcontains $card.type){throw "Invalid type: $($card.type)"}
if(@($schema.statuses) -notcontains $card.status){throw "Invalid status: $($card.status)"}
if(@($schema.priorities) -notcontains $card.priority){throw "Invalid priority: $($card.priority)"}
if(@($schema.risks) -notcontains $card.risk){throw "Invalid risk: $($card.risk)"}
if([string]::IsNullOrWhiteSpace([string]$card.card_id)){throw "card_id empty"}
if([string]::IsNullOrWhiteSpace([string]$card.module_id)){throw "module_id empty"}
if([string]::IsNullOrWhiteSpace([string]$card.title)){throw "title empty"}
if([string]$card.human_gate -ne 'SI'){W "WARN human_gate should normally be SI" Yellow}
W ("OK module_card_valid card_id="+$card.card_id+" module_id="+$card.module_id+" type="+$card.type+" status="+$card.status) Green