
<# Network Interface (NIC) #>


# Variables - Network Interface (NIC)

$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"



<# Create Network Interface (NIC), if it does not exist #>

Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -ErrorVariable isNICExist -ErrorAction SilentlyContinue `


If ($isNICExist) 
{
    Write-Output "Network Interface (NIC) does not exist"

    

    # virtual network
    Write-Verbose "Fetching Virtual Network: {$vnetName}"

    $vnet = Get-AzureRmVirtualNetwork `
            -Name $vnetName `
            -ResourceGroupName $rgName



    # public IP address 
    Write-Verbose "Fetching Public IP: {$publicIpName}"

    $publicIp = Get-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName


    # network security group 
    Write-Verbose "Fetching Network Security Group: {$nsgName}"

    $nsg = Get-AzureRmNetworkSecurityGroup `
        -Name $nsgName `
        -ResourceGroupName $rgName



    # Create a virtual network card and associate with public IP address and NSG
    Write-Verbose "Creating Network Interface (NIC): {$nicName}"

    $nic = New-AzureRmNetworkInterface `
                -Name $nicName `
                -ResourceGroupName $rgName `
                -Location $location `
                -SubnetId $vnet.Subnets[0].Id `
                -PublicIpAddressId $pip.Id `
                -NetworkSecurityGroupId $nsg.Id
} 
Else 
{
    Write-Output "Network Interface (NIC) exist"

    Write-Verbose "Fetching Network Interface (NIC): {$rgName}"


    $nic = Get-AzureRmNetworkInterface `
                -Name $nicName `
                -ResourceGroupName $rgName
}



Write-Verbose "Get list of Network Interface (NIC)s"
Write-Output "Network Interface (NIC)s"


Get-AzureRmNetworkInterface | Select-Object Name, ResourceGroupName, Location `
                         | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName


<#

$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"


Write-Verbose "Delete Network Interface (NIC): {$rgName}"

Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Force

#>



<#



#>




