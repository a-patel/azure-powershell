Get-AzureRmResourceGroup | Select-Object ResourceGroupName,Location


Get-AzureRmVirtualNetwork | Select-Object Name,ResourceGroupName,Location


Get-AzureRmNetworkSecurityGroup | Select-Object Name,ResourceGroupName,Location


# connect to azure
Add-AzureRmAccount

# other cmd
Login-AzureRmAccount
Get-AzureRmLocation
Connect-AzureRmAccount


$hasPublicIp = $true

if($hasPublicIp)
{
"y"
}
else
{
"N"
}




$natRuleName = "dsd"

$fd = "$($natRuleName)3"
$fd

$cred = Get-Credential -Message "Enter a username and password for the virtual machine."



$username = "aashish"
$password = ConvertTo-SecureString -String "Password@1234" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password




$StorageAccount = ($RgPrefix + "Storage").ToLower()



for ($i=1; $i -le 3; $i++)
{
   New-AzureRmNetworkInterface `
     -ResourceGroupName "myResourceGroupLoadBalancer" `
     -Name myVM$i `
     -Location "EastUS" `
     -Subnet $vnet.Subnets[0] `
     -LoadBalancerBackendAddressPool $lb.BackendAddressPools[0]
}



function Get-Something
 {
     [CmdletBinding()]
     param
     (
         [Parameter(Mandatory)]
         [string]$Thing1,
         
         [Parameter(Mandatory)]
         [string]$Thing2,
         [Parameter()]
         [string]$Thing3 = 'adefaultvalue'
     )
     Set-Something @PSBoundParameters
     
 }


 	
Get-Something –Thing1 'hello' –Thing2 'world'


function GetResourceName ($name, $suffix = "", $joinChar = "-") 
{
    if($suffix)
    {
        return $name;
    }

    return "${name}${joinChar}${suffix}"
}

GetResourceName Name "Ashish" Suffix "-rg"







$GetWmiObjectParams = @{
    Class = "Win32_LogicalDisk"
    Filter = "DriveType=3"
    ComputerName = "SERVER2"
}

Get-WmiObject @GetWmiObjectParams.






$publicIp = Get-AzureRmPublicIpAddress -Name "fffffff" -ResourceGroupName "aabbccdd12-rg" -ErrorVariable isIPExist -ErrorAction SilentlyContinue `

if($isIPExist )
{
"yes"
}
else
{
"no"
}

Write-Verbose 
 Write-Verbose "Verbose output"

 "Regular output"




