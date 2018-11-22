

# Variables for common values

$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("author", "Ashish")
$tags.Add("project", "demo")


$location = "eastus2"


# Create Resource Group, if it doesn't already exist


### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0


$rgName = "aabbccdd12"
$rgSuffix = "-rg"
$rgFullName = "${rgName}${rgSuffix}"



Get-AzureRmResourceGroup -Name $rgFullName -ErrorVariable isRGExist -ErrorAction SilentlyContinue `

If ($isRGExist) {
    # ResourceGroup doesn't exist
    "ResourceGroup doesn't exist"

    $rg = New-AzureRmResourceGroup `
            -Name $rgFullName `
            -Location $location `

} Else {
    # ResourceGroup exist
    "ResourceGroup exist"

    $rg = Get-AzureRmResourceGroup `
            -Name $rgFullName 
}


# Get-AzureRmResourceGroup | Select-Object ResourceGroupName,Location



######################################################################


# Create Virtual Network, if it doesn't already exist


### https://docs.microsoft.com/en-us/azure/virtual-network/quick-create-powershell
### https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermvirtualnetwork?view=azurermps-6.13.0
### https://github.com/robotechredmond/Azure-PowerShell-Snippets/blob/master/Azure%20Resource%20Manager%20-%20Create%20V2%20environment%20w%20VNET%20GW%20demo.ps1


$vnetName = "myvnet"
$vnetSuffix = "-vent"
$vnetFullName = "${vnetName}${vnetSuffix}"



Get-AzureRmVirtualNetwork -Name $vnetFullName -ResourceGroupName $rgFullName -ErrorVariable isVNetExist -ErrorAction SilentlyContinue `



If ($isVNetExist) {

    # VNet doesn't exist
    "VNet doesn't exist"


    $subnet1Name = "subnet01"
    $subnet2Name = "GatewaySubnet"
    
    $subnet1 = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $subnet1Name `
        -AddressPrefix "10.0.1.0/24"

    $subnet2 = New-AzureRmVirtualNetworkSubnetConfig `
        -Name $subnet2Name `
        -AddressPrefix "10.0.2.0/28"


    $vnet = New-AzureRmVirtualNetwork `
              -Name $vnetFullName `
              -ResourceGroupName $rgFullName `
              -Location $location `
              -AddressPrefix 10.0.0.0/16 `
              -Subnet $subnet1, $subnet2 `
              -Tag $tags

} Else {

    # VNet exist
    "VNet exist"

    $vnet = Get-AzureRmVirtualNetwork `
            -Name $vnetFullName `
            -ResourceGroupName $rgFullName
}



# Get-AzureRmVirtualNetwork | Select-Object Name,ResourceGroupName,Location



