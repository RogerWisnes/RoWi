
# Timer-function for logging the time used for measuring execution-times
$sw = [Diagnostics.Stopwatch]::new()
$log = new-object -TypeName System.Text.StringBuilder
function logTime {
  param( 
    [Parameter(Mandatory)][String]$timed,
    [bool]$restart = $true 
  )
  $sw.Stop()
  $log.AppendFormat("{0}: {1}s`n", $timed, $($sw.ElapsedMilliseconds / 1000)) > $null
  $sw.Reset()
  If ($restart) { $sw.Start() }
}


##################################################
###      Import relevant files and modules     ###
##################################################

$sw.Start()
. $global:ROWI\Constants\Constants.ps1
logTime "Constants"

. $global:ROWI\Functions\Functions.ps1
logTime "Functions"

. $global:ROWI\Installer\Installer.ps1
logTime "Installer"

. $global:ROWI\Logo\Logo.ps1
logTime "Logo"

. $global:ROWI\Upgrader.ps1
logTime "Upgrader"

# Import modules
Import-Module -Name posh-git -ArgumentList @($false, $false, $true) # Arguments: [bool]$ForcePoshGitPrompt, [bool]$UseLegacyTabExpansion, [bool]$EnableProxyFunctionExpansion
logTime "Posh" -restart $false


# To show time-log: Uncomment the following line
# Write-Host -ForegroundColor Cyan $log.ToString()



#######################################
###      SETTINGS AND SHORTCUTS     ###
#######################################

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineKeyHandler -Chord Ctrl+1 -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('. rr')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord Ctrl+2 -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('PRINT_IMAGE')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
