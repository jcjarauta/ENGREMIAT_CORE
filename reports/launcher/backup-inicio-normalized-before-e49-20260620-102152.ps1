$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
function UX([string]$m,[string]$role="info"){$c=switch($role){"title"{"Cyan"}"route"{"DarkGray"}"role"{"Gray"}"principle"{"DarkGray"}"section"{"Yellow"}"ok"{"Green"}"warn"{"Yellow"}"err"{"Red"}"next"{"Cyan"}"muted"{"DarkGray"}default{"Gray"}};try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function UXOk([string]$m){UX ("[OK] "+$m) "ok"}
function UXWarn([string]$m){UX ("[WARN] "+$m) "warn"}
function P(){Write-Host "";Read-Host "[Enter] volver / refrescar"|Out-Null}
function Header([string]$section=""){Clear-Host;UX "==== ENGREMIAT / INICIO ====" "title";UX "Ruta: INICIO > pantalla normalizada pendiente de ubicar" "route";UX "Rol: pantalla normalizada generada desde inventario" "role";UX "Principio: reducir listado legacy a pantalla propia con numeros locales" "principle";if($section){UX $section "section"};Write-Host ""}
function ShowHelp(){Header "AYUDA";UX "Pantalla paralela normalizada. Legacy preservado." "info";UX "b vuelve, Enter refresca, ? ayuda." "muted";P}
function PlaceholderAction([string]$label,[string]$legacy){Header $label;UXWarn "Handler real pendiente de cablear en fase posterior.";UX ("Legacy option: "+$legacy) "muted";P}
function Menu(){while($true){Header
UX "[1] continuar último foco: vuelve a donde estabas trabajando. White" "info"
UX "[2] módulos del proyecto activo: revisar/abrir módulos del proyecto. White" "info"
UX "[3] biblioteca de módulos: reutilizables, activos, inactivos e históricos. White" "info"
UX "[4] workspace de módulo: seleccionar módulo y abrir su espacio operativo. White" "info"
UX "[5] tarjetas de módulo: seleccionar módulo y gestionar tarjetas. White" "info"
UX "[6] abrir carpeta proyecto activo: acceso directo al explorador. White" "info"
UX "[7] dashboard humano / operador visual: abre el HTML de inicio humano. White" "info"
UX "[8] árbol de navegación seguro: mapa de pantallas y rutas. White" "info"
UX "[9] rutas recomendadas: caminos prácticos de trabajo. White" "info"
UX "[10] ayuda: esta pantalla. White" "info"
UX "[11] estado técnico: diagnóstico interno del inicio. White" "info"
UX "[12] estado copiable: resumen para devolver a ChatGPT. White" "info"
UX "[13] status externo: status ejecutable independiente. White" "info"
UX "[14] ver último log: última salida registrada. White" "info"
UX "[15] generar/abrir memoria viva. White" "info"
UX "[16] generar/abrir prompt continuidad ChatGPT. White" "info"
UX "[17] generar/abrir prompt worker Ollama/Cline. White" "info"
UX "[18] abrir diario de desarrollo. White" "info"
UX "[19] añadir entrada al diario. White" "info"
UX "[20] refrescar grafo de módulos. White" "info"
UX "[21] abrir C:\ENGREMIAT_CORE. White" "info"
UX "[22]  White" "info"
UX "[23]  White" "info"
UX "[24]  White" "info"
UX "[25]  White" "info"
UX "[26]  White" "info"
UX "[27] y luego [11] White" "info"
UX "[28] módulos del proyecto -> número de módulo -> workspace/ficha del módulo White" "info"
UX "[29] workspace de módulo -> seleccionar módulo -> tarjetas/tareas/tipos/enlaces White" "info"
UX "[30] biblioteca de módulos -> [d] desactivados / [h] históricos / [e] gestionar biblioteca White" "info"
UX "[31] refrescar grafo de módulos -> [11] estado técnico White" "info"
UX "[32] continuar último foco White" "info"
UX "[33] selector workspace normalizado / [5] selector tarjetas normalizado DarkGray" "info"
UX "[34] {0} -f $rec.label) White" "info"
UX "[35] módulos del proyecto activo White" "info"
UX "[36] biblioteca de módulos White" "info"
UX "[37] workspace de módulo White" "info"
UX "[38] tarjetas de módulo White" "info"
UX "[39] abrir carpeta proyecto activo White" "info"
UX "[40] dashboard humano / operador visual White" "info"
UX "[41] árbol de navegación seguro White" "info"
UX "[42] rutas recomendadas White" "info"
UX "[43] ayuda White" "info"
UX "[44] estado técnico White" "info"
UX "[45] estado copiable White" "info"
UX "[46] status externo White" "info"
UX "[47] ver último log White" "info"
UX "[48] memoria y documentación White" "info"
UX "[49] generar/abrir prompt continuidad ChatGPT White" "info"
UX "[50] generar/abrir prompt worker Ollama/Cline White" "info"
UX "[51] abrir diario de desarrollo White" "info"
UX "[52] añadir entrada al diario White" "info"
UX "[53] refrescar grafo de módulos White" "info"
UX "[54] abrir C:\ENGREMIAT_CORE White" "info"
Write-Host "";UX "[b] volver | [Enter] refrescar | ? = ayuda" "muted";Write-Host ""; $op=Read-Host "ENGREMIAT_INICIO";switch($op){
"1"{PlaceholderAction "continuar último foco: vuelve a donde estabas trabajando. White" "1"}
"2"{PlaceholderAction "módulos del proyecto activo: revisar/abrir módulos del proyecto. White" "2"}
"3"{PlaceholderAction "biblioteca de módulos: reutilizables, activos, inactivos e históricos. White" "3"}
"4"{PlaceholderAction "workspace de módulo: seleccionar módulo y abrir su espacio operativo. White" "4"}
"5"{PlaceholderAction "tarjetas de módulo: seleccionar módulo y gestionar tarjetas. White" "5"}
"6"{PlaceholderAction "abrir carpeta proyecto activo: acceso directo al explorador. White" "6"}
"7"{PlaceholderAction "dashboard humano / operador visual: abre el HTML de inicio humano. White" "7"}
"8"{PlaceholderAction "árbol de navegación seguro: mapa de pantallas y rutas. White" "8"}
"9"{PlaceholderAction "rutas recomendadas: caminos prácticos de trabajo. White" "9"}
"10"{PlaceholderAction "ayuda: esta pantalla. White" "10"}
"11"{PlaceholderAction "estado técnico: diagnóstico interno del inicio. White" "11"}
"12"{PlaceholderAction "estado copiable: resumen para devolver a ChatGPT. White" "12"}
"13"{PlaceholderAction "status externo: status ejecutable independiente. White" "13"}
"14"{PlaceholderAction "ver último log: última salida registrada. White" "14"}
"15"{PlaceholderAction "generar/abrir memoria viva. White" "15"}
"16"{PlaceholderAction "generar/abrir prompt continuidad ChatGPT. White" "16"}
"17"{PlaceholderAction "generar/abrir prompt worker Ollama/Cline. White" "17"}
"18"{PlaceholderAction "abrir diario de desarrollo. White" "18"}
"19"{PlaceholderAction "añadir entrada al diario. White" "19"}
"20"{PlaceholderAction "refrescar grafo de módulos. White" "20"}
"21"{PlaceholderAction "abrir C:\ENGREMIAT_CORE. White" "21"}
"22"{PlaceholderAction " White" "2"}
"23"{PlaceholderAction " White" "3"}
"24"{PlaceholderAction " White" "4"}
"25"{PlaceholderAction " White" "5"}
"26"{PlaceholderAction " White" "8"}
"27"{PlaceholderAction "y luego [11] White" "20"}
"28"{PlaceholderAction "módulos del proyecto -> número de módulo -> workspace/ficha del módulo White" "2"}
"29"{PlaceholderAction "workspace de módulo -> seleccionar módulo -> tarjetas/tareas/tipos/enlaces White" "4"}
"30"{PlaceholderAction "biblioteca de módulos -> [d] desactivados / [h] históricos / [e] gestionar biblioteca White" "3"}
"31"{PlaceholderAction "refrescar grafo de módulos -> [11] estado técnico White" "20"}
"32"{PlaceholderAction "continuar último foco White" "1"}
"33"{PlaceholderAction "selector workspace normalizado / [5] selector tarjetas normalizado DarkGray" "4"}
"34"{PlaceholderAction "{0} -f $rec.label) White" "1"}
"35"{PlaceholderAction "módulos del proyecto activo White" "2"}
"36"{PlaceholderAction "biblioteca de módulos White" "3"}
"37"{PlaceholderAction "workspace de módulo White" "4"}
"38"{PlaceholderAction "tarjetas de módulo White" "5"}
"39"{PlaceholderAction "abrir carpeta proyecto activo White" "6"}
"40"{PlaceholderAction "dashboard humano / operador visual White" "7"}
"41"{PlaceholderAction "árbol de navegación seguro White" "8"}
"42"{PlaceholderAction "rutas recomendadas White" "9"}
"43"{PlaceholderAction "ayuda White" "10"}
"44"{PlaceholderAction "estado técnico White" "11"}
"45"{PlaceholderAction "estado copiable White" "12"}
"46"{PlaceholderAction "status externo White" "13"}
"47"{PlaceholderAction "ver último log White" "14"}
"48"{PlaceholderAction "memoria y documentación White" "15"}
"49"{PlaceholderAction "generar/abrir prompt continuidad ChatGPT White" "16"}
"50"{PlaceholderAction "generar/abrir prompt worker Ollama/Cline White" "17"}
"51"{PlaceholderAction "abrir diario de desarrollo White" "18"}
"52"{PlaceholderAction "añadir entrada al diario White" "19"}
"53"{PlaceholderAction "refrescar grafo de módulos White" "20"}
"54"{PlaceholderAction "abrir C:\ENGREMIAT_CORE White" "21"}
"b"{return};""{continue};"?"{ShowHelp};default{UXWarn "Opcion no reconocida";Start-Sleep -Milliseconds 700}}}}
Menu
