$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$dir="
C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST
"
Write-Host "Abriendo carpeta de prueba Markdown Kanban:" -ForegroundColor Cyan
Write-Host $dir -ForegroundColor Yellow
if(Get-Command code -ErrorAction SilentlyContinue){code $dir; exit 0}
if(Get-Command cursor -ErrorAction SilentlyContinue){cursor $dir; exit 0}
Invoke-Item $dir
