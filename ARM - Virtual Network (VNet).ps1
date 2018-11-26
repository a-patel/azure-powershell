
<# Create Virtual Network, if it does not exist #>


# Variables - Virtual Network

$vnetShortName = "myvnet"
$vnetSuffix = "-vent"
$vnetName = "${vnetShortName}${vnetSuffix}"



Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -ErrorVariable isVNetExist -ErrorAction SilentlyContinue `


If ($isVNetExist) 
{
    Write-Output "Virtual Network does not exist"
    


    $subnet1Name = "web"
    
    Write-Verbose "Creating new subnet: {$subnet1Name}"

    $subnet1 = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $subnet1Name `
        -AddressPrefix "10.0.1.0/24"


    $subnet2Name = "GatewaySubnet"

    Write-Verbose "Creating new subnet: {$subnet2Name}"

    $subnet2 = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $subnet2Name `
        -AddressPrefix "10.0.2.0/28"



    Write-Verbose "Creating new Virtual Network: {$vnetName}"

    $vnet = New-AzureRmVirtualNetwork `
              -Name $vnetName `
              -ResourceGroupName $rgName `
              -Location $location `
              -AddressPrefix 10.0.0.0/16 `
              -Subnet $subnet1, $subnet2 `
              -Tag $tags
}
Else 
{
    Write-Output "Virtual Network exist"

    Write-Verbose "Fetching Virtual Network: {$vnetName}"


    $vnet = Get-AzureRmVirtualNetwork `
            -Name $vnetName `
            -ResourceGroupName $rgName
}



Write-Verbose Get list of all VNets
Write-Output "Virtual Networks"


Get-AzureRmVirtualNetwork -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName



<#

Get-AzureRmVirtualNetwork `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>





<#

https://docs.microsoft.com/en-us/azure/virtual-network/quick-create-powershell
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermvirtualnetwork?view=azurermps-6.13.0
https://github.com/robotechredmond/Azure-PowerShell-Snippets/blob/master/Azure%20Resource%20Manager%20-%20Create%20V2%20environment%20w%20VNET%20GW%20demo.ps1

#>

