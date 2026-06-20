param()
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function Eng-L { param([string]$Text="",[string]$Color="Gray") Write-Host $Text -ForegroundColor $Color }

function Eng-IsRefreshCommand { param([string]$Value) $x=([string]$Value).Trim().ToLowerInvariant(); return ([string]::IsNullOrWhiteSpace($x) -or $x -in @("refrescar","refresh","f5","menu","comandos")) }

function Eng-IsBackCommand { param([string]$Value) $x=([string]$Value).Trim().ToLowerInvariant(); return ($x -in @("b","a","atras","atrás","back","volver","0")) }

function Eng-IsHelpCommand { param([string]$Value) $x=([string]$Value).Trim().ToLowerInvariant(); return ($x -in @("?","ayuda","help")) }

function Eng-IsExitCommand { param([string]$Value) $x=([string]$Value).Trim().ToLowerInvariant(); return ($x -in @("q","salir","exit")) }

function Eng-WriteNavigationHint { param([switch]$AllowExit) Eng-L ""; if($AllowExit){Eng-L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | q = salir | ? = ayuda" "DarkGray"}else{Eng-L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | ? = ayuda" "DarkGray"}; Eng-L "" }

function Eng-ReadNavigationCommand { param([string]$Prompt="ENGREMIAT") return (Read-Host $Prompt).Trim().ToLowerInvariant() }

function Eng-ShowScreenHelp { param([string]$Title="AYUDA") Eng-L ""; Eng-L $Title "Cyan"; Eng-L " Enter vacio, refrescar, refresh, f5, menu o comandos redibujan la pantalla." "Gray"; Eng-L " b, a, atras, atrás, back, volver o 0 vuelven a la pantalla anterior." "Gray"; Eng-L " ? o ayuda muestran esta ayuda contextual." "Gray"; Eng-L "" }

function Eng-InvokeScreenLoop { param([Parameter(Mandatory=$true)][scriptblock]$Draw,[scriptblock]$HandleCommand,[string]$Prompt="ENGREMIAT",[switch]$AllowExit) while($true){Clear-Host;& $Draw;Eng-WriteNavigationHint -AllowExit:$AllowExit;$cmd=Eng-ReadNavigationCommand -Prompt $Prompt;if(Eng-IsRefreshCommand $cmd){continue};if(Eng-IsHelpCommand $cmd){Eng-ShowScreenHelp;Read-Host "Enter para volver"|Out-Null;continue};if(Eng-IsBackCommand $cmd){return "BACK"};if($AllowExit -and (Eng-IsExitCommand $cmd)){return "EXIT"};if($HandleCommand){$r=& $HandleCommand $cmd;if($r -in @("BACK","EXIT","DONE")){return $r}}} }

function Eng-TestNavigationHelpers { $checks=@(); $checks += [pscustomobject]@{name="refresh_empty";ok=(Eng-IsRefreshCommand "")}; $checks += [pscustomobject]@{name="refresh_f5";ok=(Eng-IsRefreshCommand "f5")}; $checks += [pscustomobject]@{name="back_b";ok=(Eng-IsBackCommand "b")}; $checks += [pscustomobject]@{name="help_question";ok=(Eng-IsHelpCommand "?")}; $checks += [pscustomobject]@{name="exit_q";ok=(Eng-IsExitCommand "q")}; return @($checks) }
