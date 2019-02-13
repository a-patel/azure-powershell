

<# Install web server #>


Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -ComputerName Server1 -WhatIf

Install-WindowsFeature -name Web-Server -IncludeManagementTools



<#



#>





<#

https://docs.microsoft.com/en-us/powershell/module/servermanager/install-windowsfeature?view=winserver2012r2-ps&viewFallbackFrom=win10-ps
https://www.solvps.com/blog/installing-iis-powershell-windows-vps/

#>

