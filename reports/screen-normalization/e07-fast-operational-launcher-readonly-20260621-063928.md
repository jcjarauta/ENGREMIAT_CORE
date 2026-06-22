# E07 Fast Operational Launcher Readonly

status: PASS_READONLY_NO_PARSE
target: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
size_bytes: 
6187
sample_lines: 
183
has_common_legend_in_sample: 
False
legend_count_in_sample: 
2
prompt_count_in_sample: 
3
title_count_in_sample: 
1

## Titles
- W "==== ENGREMIAT LAUNCHER ACTUAL ====" Cyan

## Legends
- Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
- W "b/q = salir | Enter = refrescar" Cyan | ? = ayuda

## Prompts
- Read-Host "Enter para volver" | Out-Null
- function P(){ [void](Read-Host "Enter") }
- $cmd=Read-Host "ENGREMIAT"
