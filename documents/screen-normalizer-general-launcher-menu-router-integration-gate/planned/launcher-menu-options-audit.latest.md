# E03D menu option audit no apply

## Decision
GO_FREE_OPTION_FOUND_NO_APPLY

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Occupied options
0, 1, 2, 3, 4, 5, 6, 7, 8, 9

## Recommended free option
10

## Option hits
- option=0 line=58 text=if($mods.Count -eq 0){L " sin modulos" Yellow;return}
- option=0 line=121 text=if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
- option=1 line=74 text=L " [1] Abrir proyecto     p" Green
- option=1 line=83 text=L " [1] Entrar en modulo   m" Green
- option=1 line=90 text=L " [1] Contrato           c" Green
- option=1 line=123 text=if($x -in @("1","p")){return "abrir-proyecto"}
- option=1 line=128 text=if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
- option=1 line=133 text=if($x -in @("1","c")){return "contrato"}
- option=2 line=75 text=L " [2] Nuevo proyecto     n" Green
- option=2 line=84 text=L " [2] Crear modulo       n" Green
- option=2 line=91 text=L " [2] Tareas             t" Green
- option=2 line=124 text=if($x -in @("2","n")){return "nuevo-proyecto"}
- option=2 line=129 text=if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
- option=2 line=134 text=if($x -in @("2","t")){return "tareas"}
- option=3 line=76 text=L " [3] Ver proyectos" Green
- option=3 line=85 text=L " [3] Biblioteca modulos b" Green
- option=3 line=92 text=L " [3] Evidencias         ev" Green
- option=3 line=125 text=if($x -eq "3"){return "proyectos"}
- option=3 line=130 text=if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
- option=3 line=135 text=if($x -in @("3","ev","e")){return "evidencias"}
- option=4 line=77 text=L " [4] Estado compacto    e" Green
- option=4 line=86 text=L " [4] Revisar proyecto   r" Green
- option=4 line=93 text=L " [4] Gates              g" Green
- option=4 line=126 text=if($x -in @("4","e")){return "estado"}
- option=4 line=131 text=if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
- option=4 line=136 text=if($x -in @("4","g")){return "gates"}
- option=5 line=94 text=L " [5] Smoke              s" Green
- option=5 line=137 text=if($x -in @("5","s")){return "preparar-smoke"}
- option=6 line=95 text=L " [6] Editar artefacto   ed" Green
- option=6 line=138 text=if($x -in @("6","ed","editar")){return "editar"}
- option=7 line=96 text=L " [7] Definir objetivo   o" Green
- option=7 line=139 text=if($x -in @("7","o","objetivo")){return "objetivo"}
- option=8 line=97 text=L " [8] Cerrar modulo      cm" Green
- option=8 line=140 text=if($x -in @("8","cm","cerrar","cerrar-modulo")){return "cerrar-modulo"}
- option=9 line=98 text=L " [9] Promover biblioteca pb" Green
- option=9 line=141 text=if($x -in @("9","pb","promover","promover-biblioteca")){return "promover"}

## Rule
NO_APPLY. Este paso solo audita opciones ocupadas y recomienda una libre.

## Next
E04_PREPARE_EXACT_PATCH_ON_PLANNED_COPY_WITH_FREE_OPTION_NO_APPLY
