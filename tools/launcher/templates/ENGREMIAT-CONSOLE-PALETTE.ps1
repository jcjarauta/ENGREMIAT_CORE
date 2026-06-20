$ErrorActionPreference='Stop'
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
  try { Write-Host $m -ForegroundColor $c } catch { Write-Host $m }
}
function UXHeader([string]$title,[string]$route,[string]$role,[string]$principle,[string]$section=''){
  Clear-Host
  UX ('==== '+$title+' ====') 'title'
  UX ('Ruta: '+$route) 'route'
  UX ('Rol: '+$role) 'role'
  UX ('Principio: '+$principle) 'principle'
  if($section){UX $section 'section'}
  Write-Host ''
}
function UXOk([string]$m){UX ('[OK] '+$m) 'ok'}
function UXWarn([string]$m){UX ('[WARN] '+$m) 'warn'}
function UXErr([string]$m){UX ('[ERR] '+$m) 'err'}
function UXNext([string]$m){UX ('[NEXT] '+$m) 'next'}
function UXMuted([string]$m){UX $m 'muted'}
