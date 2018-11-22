
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


$vnetName = "myvnet"
$vnetSuffix = "-vent"
$vnetFullName = "${vnetName}${vnetSuffix}"





# Create Network Security Group (NSG), if it doesn't exist - Rules below are example placeholders that allow selected traffic from all sources


### https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermnetworksecuritygroup?view=azurermps-6.13.0
### https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermnetworksecurityruleconfig?view=azurermps-6.13.0&viewFallbackFrom=azurermps-6.12.0



$nsgName = "aabbccdd44"
$nsgSuffix = "-nsg"
$nsgFullName = "${nsgName}${nsgSuffix}"


Get-AzureRmNetworkSecurityGroup -Name $nsgFullName -ResourceGroupName $rgFullName -ErrorVariable isNSGExist -ErrorAction SilentlyContinue `


If ($isNSGExist) {

    $nsgRule1 = New-AzureRmNetworkSecurityRuleConfig `
        -Name "allow-rdp-inbound" `
        -Description "Allow Inbound RDP" `
        -SourceAddressPrefix * `
        -DestinationAddressPrefix * `
        -Protocol Tcp `
        -SourcePortRange * `
        -DestinationPortRange 3389 `
        -Direction Inbound `
        -Access Allow `
        -Priority 100

    $nsgRule2 = New-AzureRmNetworkSecurityRuleConfig `
        -Name "allow-http-inbound" `
        -Description "Allow Inbound HTTP" `
        -SourceAddressPrefix * `
        -DestinationAddressPrefix * `
        -Protocol Tcp `
        -SourcePortRange * `
        -DestinationPortRange 80 `
        -Direction Inbound `
        -Access Allow `
        -Priority 110

    $nsg = New-AzureRmNetworkSecurityGroup `
        -Name $nsgFullName `
        -ResourceGroupName $rgFullName `
        -Location $location `
        -SecurityRules $nsgRule1, $nsgRule2 `
        -Tag $tags

} else {

    $nsg = Get-AzureRmNetworkSecurityGroup ` 
        -Name $nsgFullName `
        -ResourceGroupName $rgFullName
}




Get-AzureRmNetworkSecurityGroup | Select-Object Name,ResourceGroupName,Location

