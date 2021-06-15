#requires -version 4
<#
.SYNOPSIS
  Check COnnectivity for all domain controllers

.DESCRIPTION
  This script lists and check connectivity for all found domain controllers.
  It must be ran on a domain computer with the AD module loaded.
  Source : http://woshub.com/get-addomaincontroller-dc-info-powershell/

.PARAMETER None


.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         FingersOnFire
  Creation Date:  2021-06-15
  Purpose/Change: Initial script development

.EXAMPLE

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



#-----------------------------------------------------------[Functions]------------------------------------------------------------



#-----------------------------------------------------------[Execution]------------------------------------------------------------


$DCs = Get-ADDomainController -Filter * | Select-Object Hostname,Ipv4address,isGlobalCatalog,Site,Forest,OperatingSystem

ForEach($DC in $DCs)
{
    $PortResult=Test-NetConnection -ComputerName $DC.Hostname -Port 636 -InformationLevel Quiet
    if ($PortResult -ne "$True"){
        write-host $DC.Hostname " not available" -BackgroundColor Red -ForegroundColor White
    }
    else {
        write-host $DC.Hostname " available" -BackgroundColor Green -ForegroundColor White
    }
}