# E01 OPERATOR ROUTE POINTS INVENTORY

- package: ENGREMIAT_SCREEN_MAINTENANCE_ROUTE_BINDING_001
- stage: E01_INVENTORY_OPERATOR_ROUTE_POINTS_READONLY
- status: PASS
- mode: READONLY_ROUTE_POINT_INVENTORY_NO_WRITE
- target: C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- target_parse_ok: true
- helper_present: True
- marker_present: True
- capture_ref_present: True
- route_already_bound: True
- route_points_count: 11

## Route points sample
- line 102 [HELP_OR_COMMAND_HINT] L "refrescar/f5/Enter = redibujar pantalla | ? = ayuda | comandos = menu actual" DarkGray
- line 118 [HELP_OR_COMMAND_HINT] if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
- line 119 [HELP_OR_COMMAND_HINT] if($x -in @("?","ayuda")){return "ayuda"}
- line 166 [HELP_OR_COMMAND_HINT] L "AYUDA" Cyan
- line 167 [HELP_OR_COMMAND_HINT] L "Enter/refrescar/f5 redibuja pantalla." Gray
- line 174 [READ_HOST] $cmd=Normalize-Command (Read-Host "ENGREMIAT")
- line 175 [COMMAND_VAR] if($cmd -eq "__refresh__"){continue}
- line 176 [READ_HOST] if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
- line 177 [COMMAND_VAR] if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
- line 178 [COMMAND_VAR] if($cmd -eq "atras"){Go-Back;continue}
- line 179 [COMMAND_VAR] & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd

- inventory: C:\ENGREMIAT_CORE\documents\screen-maintenance-route-binding\inventory\operator-route-points-inventory-20260620-155001.json
- report: C:\ENGREMIAT_CORE\reports\screen-maintenance-route-binding\e01-inventory-operator-route-points-readonly-20260620-155001.json
- real_execution: false
- system_mutation: false
- screen_mutation: false
- worker: false
- browser: false
- network: false
- git: false
- next: E02_PREPARE_ROUTE_BINDING_PATCH_PROPOSAL_NO_WRITE
