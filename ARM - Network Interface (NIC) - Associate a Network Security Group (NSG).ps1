

## To Set Verbose output
$PSDefaultParameterValues['*:Verbose'] = $true



# Variables - Common

$location = "eastus2"


$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("environment", "Production")         # Production, Staging, QA
$tags.Add("projectName", "Demo Project")
$tags.Add("projectVersion", "1.0.0")
$tags.Add("managedBy", "developer.aashishpatel@gmail.com")
$tags.Add("billTo", "Ashish Patel")
$tags.Add("tier", "Front End")                 # Front End, Back End, Data
$tags.Add("dataProfile", "Public")             # Public, Confidential, Restricted, Internal





<# Resource Group #>


# Variables - Resource Group

$rgShortName = "qweasdzxc"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"


<# Virtual Network (VNet) #>

<#


#>


# Variables - Virtual Network

$vnetShortName = "qweasdzxc"
$vnetSuffix = "-vnet"
$vnetName = "${vnetShortName}${vnetSuffix}"

# subnets
$webSubnetName = "WebSubnet"
$frontendSubnetName = "FrontEndSubnet"
$backendSubnetName = "BackEndSubnet"
$gatewaySubnetName = "GatewaySubnet"

# Variables - Public IP

$publicIpShortName = "qweasdzxc3"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"
$dnsPrefix  = "qweasdzxc"
#$dnsPrefix  = "qweasdzxc$(Get-Random)"

# Variables - Network Security Group

$nsgShortName = "qweasdzxc"
$nsgSuffix = "-nsg"
$nsgName = "${nsgShortName}${nsgSuffix}"



$subnetName = "BackEndSubnet"


<# Network Interface (NIC) #>

<#

Virtual Network (VNet)
Subnet
Network Security Group (NSG) (optional)
Public IP address (optional)

#>


# Variables - Network Interface (NIC)

$nicShortName = "qweasdzxc2"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"

# NIC has public IP or not
$hasPublicIp = $true

# Static: Private Ip Address (within the subnet ip range)
#$privateIpAddress = "10.0.2.77"

# Dynamic: Private Ip Address
$privateIpAddress = $null 


<# Create Network Interface (NIC), if it does not exist #>

Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -ErrorVariable isNICExist -ErrorAction SilentlyContinue `


if (!$isNICExist) 
{
    Write-Output "Network Interface (NIC) exist"

    
    # Virtual Network (VNet)
    Write-Verbose "Fetching Virtual Network (VNet): {$vnetName}"
    $vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


    # Subnet
    Write-Verbose "Fetching Subnet: {$subnetName}"
    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet


    # Network Security Group (NSG) 
    Write-Verbose "Fetching Network Security Group (NSG): {$nsgName}"
    $nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName

    

    
    Write-Verbose "Fetching Network Interface (NIC): {$rgName}"
    $nic = Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName
} 
else 
{
    Write-Output "Network Interface (NIC) does not exist"
}



<#
## References

https://docs.microsoft.com/en-us/powershell/module/azurerm.network/set-azurermnetworkinterface?view=azurermps-6.13.0

#>




