# Suppress 'unused-variable'-warning for this file
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')] param()

######################
###      SETUP     ###
######################
Clear-Host

$global:ROWI = $PSScriptRoot
. $global:ROWI\Setup\Setup.ps1

# Set start-path for PS-profile-reload. For a different start path, set the `$startPath variable in function 'rr'. 
# It is recommended to set $startPath to 'Get-Location'.
If ($startPath) { Push-Location $startPath }
Else { Push-Location $global:DEFAULT_START_PATH }


############################
###      AFTER SETUP     ###
############################

PRINT_LOGO
PRINT_FUNCTION_LIST_GENERATOR_INFO
PRINT_UPGRADER_INFO
dad


############################

function t {
  Write-Host -ForegroundColor Red "This is a function-name available for testing scripts in the profile. It is not currently in use."
}
