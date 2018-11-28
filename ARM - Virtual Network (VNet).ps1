
<# Virtual Network (VNet) #>


# Variables - Virtual Network

$vnetShortName = "qweasdzxc"
$vnetSuffix = "-vent"
$vnetName = "${vnetShortName}${vnetSuffix}"



<# Create Virtual Network (VNet), if it does not exist #>

Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -ErrorVariable isVNetExist -ErrorAction SilentlyContinue `


If ($isVNetExist) 
{
    Write-Output "Virtual Network does not exist"
    

    
    $webSubnetName = "WebSubnet"
    
    Write-Verbose "Creating new subnet: {$webSubnetName}"

    $webSubnet = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $webSubnetName `
        -AddressPrefix "10.0.0.0/24"


    $frontEndSubnetName = "FrontEndSubnet"
    
    Write-Verbose "Creating new subnet: {$frontEndSubnetName}"

    $frontEndSubnet = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $frontEndSubnetName `
        -AddressPrefix "10.0.1.0/24"

        
    $backEndSubnetName = "BackEndSubnet"
    
    Write-Verbose "Creating new subnet: {$backEndSubnetName}"

    $backEndSubnet = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $backEndSubnetName `
        -AddressPrefix "10.0.2.0/24"


    $gatewaySubnetName = "GatewaySubnet"

    Write-Verbose "Creating new subnet: {$gatewaySubnetName}"

    $gatewaySubnet = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $gatewaySubnetName `
        -AddressPrefix "10.0.3.0/24"



    Write-Verbose "Creating new Virtual Network: {$vnetName}"

    $vnet = New-AzureRmVirtualNetwork `
              -Name $vnetName `
              -ResourceGroupName $rgName `
              -Location $location `
              -AddressPrefix 10.0.0.0/16 `
              -Subnet $webSubnet, $frontEndSubnet, $backEndSubnet, $gatewaySubnet `
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



Write-Verbose "Get list of all VNets"
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
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/add-azurermvirtualnetworksubnetconfig?view=azurermps-6.13.0

#>

