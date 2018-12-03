
<# Data Disk (Managed) #>

<#

Virtual Machine (VM)
Data Disk

#>

# Variables - Disk (Managed)

# logical unit number
$lun = 1



<# Create Disk (Managed), if it does not exist #>

Get-AzureRmDisk -Name $diskName -ResourceGroupName $rgName -ErrorVariable isDiskExist -ErrorAction SilentlyContinue `


If ($isDiskExist) 
{
    Write-Output "Disk (Managed) does not exist"
    


    Write-Verbose "Fetching Virtul Machine: {$vmName}"

    $vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName



    Write-Verbose "Fetching Data Disk: {$diskName}"

    $dataDisk = Get-AzureRmDisk -Name $diskName -ResourceGroupName $rgName 



    # attach data disk to virtual machine
    Write-Verbose "Add the data disk {$diskName} to the virtual machine: {$vmName}"

    $vm = Add-AzureRmVMDataDisk `
            -VM $vm `
            -Name $diskName `
            -ManagedDiskId $dataDisk.Id `
            -CreateOption Attach `
            -Lun $lun


    Update-AzureRmVM -ResourceGroupName $rgName -VM $vm
} 
Else 
{
    Write-Output "Data Disk is attached to Virtul Machine"


    Write-Verbose "Fetching Disk (Managed): {$diskName}"

    $dataDisk = Get-AzureRmDisk -Name $diskName -ResourceGroupName $rgName 
}



Write-Verbose "Get list of Disks (Managed)"
Write-Output "Disks (Managed)"


Get-AzureRmDisk -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap


<#
Get-AzureRmDisk `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName
#>






<#
# References

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-manage-data-disk


# detach
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/detach-disk

#>




