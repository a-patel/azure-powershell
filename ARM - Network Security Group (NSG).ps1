
<# Network Security Group (NSG) #>


# Variables - Network Security Group

$nsgShortName = "aabbccdd44"
$nsgSuffix = "-nsg"
$nsgName = "${nsgShortName}${nsgSuffix}"


<# Create Network Security Group (NSG), if it does not exist - Rules below are example placeholders that allow selected traffic from all sources #>

Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName -ErrorVariable isNSGExist -ErrorAction SilentlyContinue `


If ($isNSGExist) 
{
    Write-Output "Network Security Group does not exist"
    


    Write-Verbose "Creating new Network Security Rule: {allow-rdp-inbound}"

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

    Write-Verbose "Creating new Network Security Rule: {allow-http-inbound}"

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



    Write-Verbose "Creating new Network Security Group: {$nsgName}"

    $nsg = New-AzureRmNetworkSecurityGroup `
        -Name $nsgName `
        -ResourceGroupName $rgName `
        -Location $location `
        -SecurityRules $nsgRule1, $nsgRule2 `
        -Tag $tags
} 
Else 
{

    Write-Output "Network Security Group exist"

    Write-Verbose "Fetching Network Security Group: {$nsgName}"


    $nsg = Get-AzureRmNetworkSecurityGroup `
        -Name $nsgName `
        -ResourceGroupName $rgName
}




Write-Verbose "Get list of Network Security Group (NSG)"
Write-Output "Network Security Groups"


Get-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName



<#

Get-AzureRmNetworkSecurityGroup `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>




<#

https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermnetworksecuritygroup?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermnetworksecurityruleconfig?view=azurermps-6.13.0&viewFallbackFrom=azurermps-6.12.0

#>
