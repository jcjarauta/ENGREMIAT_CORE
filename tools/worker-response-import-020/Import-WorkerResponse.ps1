$ErrorActionPreference='Stop'
param([string]$Inbox='prompts/inbox',[string]$OutFile='data/worker-response-import-020/imported-worker-response.json')
New-Item -ItemType Directory -Force -Path (Split-Path $OutFile -Parent)|Out-Null
$files=Get-ChildItem $Inbox -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending
if(-not $files){throw 'NO_WORKER_RESPONSE_FOUND_IN_INBOX'}
$f=$files[0]
$raw=Get-Content $f.FullName -Raw -Encoding UTF8
$parsed=$null;try{$parsed=$raw|ConvertFrom-Json}catch{$parsed=[ordered]@{summary='RAW_MARKDOWN_RESPONSE';proposed_files=@();proposed_content=$raw;validation_commands=@();evidence_paths=@();risks=@('raw_response_not_json');decision='NO_GO'}}
$out=[ordered]@{imported_at=(Get-Date).ToString('o');source_file=$f.FullName;worker_response=$parsed;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;status='IMPORTED_NO_APPLY'}
$out|ConvertTo-Json -Depth 30|Set-Content $OutFile -Encoding UTF8
Write-Host ('OK importer=Import-WorkerResponse source='+$f.Name+' output='+$OutFile+' apply_executed=False')
