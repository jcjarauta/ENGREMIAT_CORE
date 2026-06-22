# E08C visible menu repair no apply

## Decision
GO_VISIBLE_MENU_REPAIRED_PLANNED_READY_NO_APPLY

## Launcher real
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Selected planned
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.option-10-visible-menu-selected.latest.ps1

## Visible block
- start: 
74
- end: 
78
- insert_after_0based: 
76
- insert_before_0based: 
77

## Checks
- launcher_parse: 
True
- selected_parse: 
True
- visible_had_10_before: 
False
- inserted_now: 
True
- option_visible: 
True
- route_present: 
True
- option_hits_total: 
3

## Context after repair
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     W " [10] Screen normalizer adapter" Cyan
   79:     L " [q] Salir" Yellow
   80:   } elseif($level -eq "PROJECT"){
   81:     L "PROYECTO" Cyan
   82:     Show-ProjectModulesInline
   83:     L "ACCIONES" Cyan

## Rule
NO_APPLY. No se modifica el launcher real. No git.

## Next
E08D_APPLY_VISIBLE_MENU_REPAIR_WITH_BACKUP_AND_SMOKE_GATE
