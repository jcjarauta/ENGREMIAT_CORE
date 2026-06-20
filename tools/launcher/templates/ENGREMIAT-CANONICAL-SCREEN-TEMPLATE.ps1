$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function UX([string]$m,[string]$role='info'){
  $c = switch($role){
    'title' {'Cyan'}
    'route' {'DarkGray'}
    'role' {'Gray'}
    'principle' {'DarkGray'}
    'section' {'Yellow'}
    'ok' {'Green'}
    'warn' {'Yellow'}
    'err' {'Red'}
    'next' {'Cyan'}
    'muted' {'DarkGray'}
    default {'Gray'}
  }
  try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}
}
function UXOk([string]$m){UX ('[OK] '+$m) 'ok'}
function UXWarn([string]$m){UX ('[WARN] '+$m) 'warn'}
function UXErr([string]$m){UX ('[ERR] '+$m) 'err'}
function UXNext([string]$m){UX ('[NEXT] '+$m) 'next'}
function Pause-Screen(){Write-Host '';Read-Host '[Enter] volver / refrescar'|Out-Null}
function Show-Header([string]$Section=''){
  Clear-Host
  W '==== NOMBRE CANONICO DE PANTALLA ====' Cyan
  W 'Ruta: INICIO > [X] Centro > [Y] Pantalla' DarkGray
  W 'Rol: rol humano claro de esta pantalla' Gray
  W 'Principio: que produce / consume / valida esta pantalla' DarkGray
  if($Section){W $Section Yellow}
  W ''
}
function Show-Help(){Show-Header 'AYUDA';W 'Enter refresca. b vuelve. ? ayuda. Las acciones externas requieren gate.';Pause-Screen}
function Main-Menu(){while($true){Show-Header;W '[1] Accion principal';W '[2] Submenu conceptual';W '';W '[b] volver | [Enter] refrescar | ? = ayuda' DarkGray;W '';$op=Read-Host 'PROMPT_CANONICO';switch($op){'1'{W 'accion_pendiente' Yellow;Pause-Screen};'2'{W 'submenu_pendiente' Yellow;Pause-Screen};'b'{return};''{continue};'?'{Show-Help};default{W 'Opcion no reconocida' Yellow;Start-Sleep -Milliseconds 700}}}}
Main-Menu
