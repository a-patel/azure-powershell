
<# Subnet #>

<#
Virtual Network (VNet)

#>


# Variables - Subnet

$subnetShortName = "Test"
$subnetSuffix = "subnet"
$subnetName = "${subnetShortName}${subnetSuffix}"
$addressPrefix = "10.0.6.0/24"



<# Create Subnet (in VNet), if it does not exist #>

$vnet = Get-AzureRmVirtualNetwork `
        -Name $vnetName `
        -ResourceGroupName $rgName

Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -ErrorVariable isSubnetExist -ErrorAction SilentlyContinue `


If ($isSubnetExist) 
{
    Write-Output "Subnet does not exist"


    Write-Verbose "Fetching Virtual Network: {$vnetName}"

    $vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


    # add a subnet to the in-memory representation of the virtual network. 
    Write-Verbose "Creating Subnet: {$subnetName}"

    Add-AzureRmVirtualNetworkSubnetConfig ` 
        -Name $subnetName `
        -VirtualNetwork $vnet `
        -AddressPrefix $addressPrefix


    # updates the existing virtual network with the new subnet.
    $vnet | Set-AzureRmVirtualNetwork
}
Else 
{
    Write-Output "Subnet exist"


    Write-Verbose "Fetching Virtual Network: {$vnetName}"

    $vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


    Write-Verbose "Fetching Subnet: {$subnetName}"

    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
}



Write-Verbose "Get list of all subnets"
Write-Output "Subnets"


Write-Verbose "Fetching Virtual Network: {$vnetName}"

$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet `
    | Select-Object Name, AddressPrefix `
    | Format-Table -AutoSize -Wrap



<#

## Remove Subnet from Virtual Network (VNet)

$subnetShortName = "Test"
$subnetSuffix = "subnet"
$subnetName = "${subnetShortName}${subnetSuffix}"


Write-Verbose "Fetching Virtual Network: {$vnetName}"

$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


Write-Verbose "Removing Subnet: {$subnetName}"

Remove-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet


# updates the existing virtual network with the new subnet.
$vnet | Set-AzureRmVirtualNetwork

#>


<#
## References

https://docs.microsoft.com/en-us/powershell/module/azurerm.network/add-azurermvirtualnetworksubnetconfig?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermvirtualnetworksubnetconfig?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/remove-azurermvirtualnetworksubnetconfig?view=azurermps-6.13.0

#>

