

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

$publicIpShortName = "qweasdzxc"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"
$dnsPrefix  = "qweasdzxc"
#$dnsPrefix  = "qweasdzxc$(Get-Random)"

# Variables - Network Security Group

$nsgShortName = "qweasdzxc"
$nsgSuffix = "-nsg"
$nsgName = "${nsgShortName}${nsgSuffix}"




<# Network Interface (NIC) #>

<#

Virtual Network (VNet)
Subnet
Public IP address
Network Security Group (NSG) 

#>


# Variables - Network Interface (NIC)

$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"

$subnetName = "WebSubnet"


<# Create Network Interface (NIC), if it does not exist #>

Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -ErrorVariable isNICExist -ErrorAction SilentlyContinue `


If ($isNICExist) 
{
    Write-Output "Network Interface (NIC) does not exist"

    
    # Virtual Network (VNet)
    Write-Verbose "Fetching Virtual Network (VNet): {$vnetName}"
    
    $vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName


    # Subnet
    Write-Verbose "Fetching Subnet: {$subnetName}"

    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet


    # Public IP address 
    Write-Verbose "Fetching Public IP: {$publicIpName}"

    $publicIp = Get-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName


    # Network Security Group (NSG) 
    Write-Verbose "Fetching Network Security Group (NSG): {$nsgName}"

    $nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName



    # Create a virtual network card and associate with public IP address and NSG
    Write-Verbose "Creating Network Interface (NIC): {$nicName}"

    $nic = New-AzureRmNetworkInterface `
                -Name $nicName `
                -ResourceGroupName $rgName `
                -Location $location `
                -Subnet $subnet `
                -PublicIpAddress $publicIp `
                -NetworkSecurityGroup $nsg `
                -Tag $tags 
} 
Else 
{
    Write-Output "Network Interface (NIC) exist"


    Write-Verbose "Fetching Network Interface (NIC): {$rgName}"

    $nic = Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName
}




Write-Verbose "Get list of Network Interface (NIC)s"
Write-Output "Network Interface (NIC)s"


Get-AzureRmNetworkInterface -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap


<#

Get-AzureRmNetworkInterface `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>




<#

## Remove Network Interface (NIC)

$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"


Write-Verbose "Delete Network Interface (NIC): {$nicName}"

Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Force

#>



<#
## References



#>




