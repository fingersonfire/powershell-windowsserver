#requires -version 4
<#
.SYNOPSIS
  Start WSUSPool if it is not running

.DESCRIPTION
  This script checks on WSUS Pool Status and try to start the pool again if it is not running. 
  It is intedned to be ran through Windows Task Scheduler
  It logs attempts to start the pool when it is down. 
  Source : https://sandyzeng.com/use-powershell-monitor-wsus-pool-status/

.PARAMETER None


.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         FingersOnFire
  Creation Date:  2020-10-15
  Purpose/Change: Initial script development

.EXAMPLE
  <Example explanation goes here>
  
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  #Script parameters go here
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$File = "C:\Scripts\CheckWsusPool\WsusPool.log"
$Date = Get-Date

#-----------------------------------------------------------[Functions]------------------------------------------------------------



#-----------------------------------------------------------[Execution]------------------------------------------------------------


#Add-Content -Value "$Date, Getting WsusPool Status -----------" -Path $File
$WsusPoolStatus = (Get-WebAppPoolState -Name WsusPool).Value

if ($WsusPoolStatus -ne "Started") {
    Add-Content -Value "$Date, WsusPool Status is $($WsusPoolStatus), trying start WsusPool" -Path $File
    try {
        Start-WebAppPool -Name WsusPool -Verbose
    }
    catch {
        $ErrorMessage = $_.Exception.Message
        Add-Content -Value "$ErrorMessage" -Path $File
    }
}