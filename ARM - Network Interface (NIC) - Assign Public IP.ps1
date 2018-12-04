


## To Set Verbose output
$PSDefaultParameterValues['*:Verbose'] = $true



# Variables - Resource Group

$rgShortName = "qweasdzxc"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"




# Variables - Network Interface (NIC)

$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"


# Variables - Public IP

$publicIpShortName = "qweasdzxc3"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"



# NOTE: NOT WORKING

<# Network Interface (NIC) - Remove Public IP #>
# NOTE: It only assign Public IP Address to NIC's IP Config

<#

Network Interface (NIC)
Public IP address

#>



Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -ErrorVariable isNICExist -ErrorAction SilentlyContinue `


If (!$isNICExist) 
{
    Write-Output "Network Interface (NIC) exist"


    Write-Verbose "Fetching Network Interface (NIC): {$nicName}"
    $nic = Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName

    
    Write-Verbose "Fetching Public IP: {$publicIpName}"
    $publicIp = Get-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName



    Write-Verbose "Adding Public IP: {$publicIpName}  to Network Interface (NIC): {$nicName}"


    $nic.IpConfigurations[0].PublicIpAddress = $publicIp 
    Set-AzureRmNetworkInterface -NetworkInterface $nic


<#
$asg = New-AzureRmApplicationSecurityGroup `
    -Name MyASG `
    -ResourceGroupName $rgName `
    -Location $location `

$nic | Set-AzureRmNetworkInterfaceIpConfig -Name $nic.IpConfigurations[0].Name -Subnet $vnet.Subnets[0] -ApplicationSecurityGroup $asg | Set-AzureRmNetworkInterface

$nic | Add-AzureRmNetworkInterfaceIpConfig -Name MyNewIpConfig -Subnet $vnet.Subnets[0] -ApplicationSecurityGroup $asg  | Set-AzureRmNetworkInterface
#>
} 
Else 
{
    Write-Output "Network Interface (NIC) does not exist"
}





<#
## References

https://stackoverflow.com/questions/34164282/assigning-a-public-ip-address-to-an-existing-nic-in-azure-using-powershell
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/add-azurermnetworkinterfaceipconfig?view=azurermps-6.13.0

#>

