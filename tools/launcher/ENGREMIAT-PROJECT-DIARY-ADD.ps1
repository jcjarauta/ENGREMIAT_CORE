$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$MemoryDir=Join-Path $Core "memory\project-memory"
$DiaryJsonl=Join-Path $MemoryDir "development-diary.jsonl"
New-Item -ItemType Directory -Force -Path $MemoryDir | Out-Null
$title=Read-Host "Titulo entrada diario"
$summary=Read-Host "Resumen construido/cambiado"
$learned=Read-Host "Aprendido"
$next=Read-Host "Siguiente recomendado"
$entry=[pscustomobject]@{ time=(Get-Date).ToString("s"); title=$title; summary=$summary; learned=$learned; next=$next; source="manual_operator" }
$line=$entry | ConvertTo-Json -Compress -Depth 20
Add-Content -Path $DiaryJsonl -Value $line -Encoding UTF8
Write-Host "OK diary_entry_added" -ForegroundColor Green
Write-Host "diary=$DiaryJsonl" -ForegroundColor Green
