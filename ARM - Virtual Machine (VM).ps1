

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


<# Public IP Address #>


# Variables - Public IP

$publicIpShortName = "qweasdzxc"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"
$dnsPrefix  = "qweasdzxc"

<# Virtual Network (VNet) #>


# Variables - Virtual Network

$vnetShortName = "qweasdzxc"
$vnetSuffix = "-vent"
$vnetName = "${vnetShortName}${vnetSuffix}"




<# Virtul Machine #>


# Variables - Virtul Machine

$vmShortName = "TestVM"
$vmSuffix = ""
$vmName = "${vmShortName}${vmSuffix}"

$username = "aashish"
$password = "Password@1234"


$nicName = "mynic"

$vmSize = "Standard_D1"
$vmSKU = "2016-Datacenter"

# linux virtual machine
# $vmSKU = "14.04.2-LTS"

$vmImageName = "Win2016Datacenter"
$openPorts = "80,443,3389,22"



<# Create Virtul Machine, if it does not exist #>

Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName -ErrorVariable isVMExist -ErrorAction SilentlyContinue `


If ($isVMExist) 
{
    Write-Output "Virtul Machine does not exist"


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

    #$nic = Get-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName
    $nic = New-AzureRmNetworkInterface `
                -Name $nicName `
                -ResourceGroupName $rgName `
                -Location $location `
                -SubnetId $vnet.Subnets[0].Id `
                -PublicIpAddressId $pip.Id `
                -NetworkSecurityGroupId $nsg.Id


    Write-Verbose "Fetching Availability Set: {$asName}"

    $as = Get-AzureRmAvailabilitySet -Name $asName -ResourceGroupName $rgName



    # Create user object (credential)
    $passwordSecure = ConvertTo-SecureString -String $password -AsPlainText -Force
    $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $passwordSecure

    <#
    # ask for username and password prompt
    Write-Output "Enter a username and password for the virtual machine"
    $cred = Get-Credential -Message "Enter a username and password for the virtual machine."
    #>



    # Create a virtual machine configuration

    Write-Verbose "Creating a Virtul Machine: {$vmName}"

    $vmConfig = New-AzureRmVMConfig `
                    -AvailabilitySetId $as.Id `
                    -VMName $vmName `
                    -VMSize $vmSize | `
    Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred | `
    Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus $vmSKU -Version latest | `
    Add-AzureRmVMNetworkInterface -Id $nic.Id
    
    # linux virtual machine
    #Set-AzureRmVMOperatingSystem -Linux -ComputerName $vmName -Credential $cred -DisablePasswordAuthentication |
    #Set-AzureRmVMSourceImage -PublisherName Canonical -Offer UbuntuServer -Skus $vmSKU -Version latest |
    
    # linux virtual machine
    # Configure SSH Keys
    #$sshPublicKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
    #Add-AzureRmVMSshPublicKey -VM $vmconfig -KeyData $sshPublicKey -Path "/home/azureuser/.ssh/authorized_keys"


    $vm = New-AzureRmVM `
            -VM $vmConfig `
            -ResourceGroupName $rgName `
            -Location $location 


<#
    # way 2 - shortcut way and use default configuration

    $vmParams = @{
          Name = $vmName
          ResourceGroupName = $rgName
          Location = $location
          ImageName = $vmImageName
          Credential = $cred
          PublicIpAddressName = $publicIpName
          VirtualNetworkName = $vnetName
          SubnetName = $vnetName
          OpenPorts = $openPorts
          Tag = $tags
        }

    $vm = New-AzureRmVM @vmParams
#>



<#
    # verify the Name of the VM and the admin account we created
    $vm.OSProfile | Select-Object ComputerName,AdminUserName


    #get specific information about the network configuration
    $vm | Get-AzureRmNetworkInterface | `
          Select-Object -ExpandProperty IpConfigurations | `
          Select-Object Name,PrivateIpAddress 

    # Get Public IP address
    $publicIp = Get-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName

    $publicIp | Select-Object Name, IpAddress, @{label='FQDN';expression={$_.DnsSettings.Fqdn}}
#>
} 
Else 
{
    Write-Output "Virtul Machine exist"


    Write-Verbose "Fetching Virtul Machine: {$vmName}"

    $vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName
}



Write-Verbose "Get list of Virtul Machines"
Write-Output "Virtul Machines"


Get-AzureRmVM -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap


<#

Get-AzureRmVM -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>


<#

$vmShortName = "TestVM"
$vmSuffix = ""
$vmName = "${vmShortName}${vmSuffix}"


Write-Verbose "Delete Virtul Machine: {$vmName}"

$jobVMDelete = Remove-AzureRmVM -Name $vmName -ResourceGroupName $rgName -Force -AsJob

$jobVMDelete


#>


<#
## References

# all resource in azure
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-manage-vm

https://docs.microsoft.com/en-us/powershell/azure/azureps-vm-tutorial?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/powershell-samples?toc=%2fpowershell%2fmodule%2ftoc.json

# credentials
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-credential?view=powershell-6

# Load balance traffic between highly available virtual machines
https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-windows-powershell-sample-create-nlb-vm?toc=%2fpowershell%2fmodule%2ftoc.json

Linux
https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-linux-powershell-sample-create-vm?toc=%2fpowershell%2fmodule%2ftoc.json

#>

