
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





<# Disk (Managed) #>


# Variables - Disk (Managed)

$diskShortName = "qweasdzxc"
$diskSuffix = "-DataDisk"
$diskName = "${diskShortName}${diskSuffix}"
$diskSizeGB = 128



<# Create Disk (Managed), if it does not exist #>

Get-AzureRmResourceGroup -Name $rgName -ErrorVariable isRGExist -ErrorAction SilentlyContinue `


If ($isRGExist) 
{
    Write-Output "Disk (Managed) does not exist"
    


    Write-Verbose "Fetching Virtul Machine: {$vmName}"

    $vm = Get-AzureRmVM `
            -Name $vmName `
            -ResourceGroupName $rgName



    Write-Verbose "Creating Disk (Managed): {$diskName}"

    $diskConfig = New-AzureRmDiskConfig `
            -Location $location `
            -DiskSizeGB $diskSizeGB `
            -CreateOption Empty 

    $dataDisk = New-AzureRmDisk `
            -Name $rgName `
            -DiskName $diskName `
            -Disk $diskConfig



    Write-Verbose "Add the data disk {$diskName} to the virtual machine: {$vmName}"

    $vm = Add-AzureRmVMDataDisk `
            -VM $vm `
            -Name $diskName `
            -ManagedDiskId $dataDisk.Id `
            -CreateOption Attach `
            -Lun 1


    Update-AzureRmVM -ResourceGroupName $rgName -VM $vm
} 
Else 
{
    Write-Output "Disk (Managed) exist"

    Write-Verbose "Fetching Disk (Managed): {$rgName}"


    $rg = Get-AzureRmResourceGroup `
            -Name $rgName 
}



Write-Verbose "Get list of Resource Groups"
Write-Output "Resource Groups"


Get-AzureRmResourceGroup | Select-Object ResourceGroupName, Location `
                         | Format-Table -AutoSize -Wrap -GroupBy Location




<#
Prepare data disks
Create an RDP connection with the virtual machine. Open up PowerShell and run this script.

Get-Disk | Where partitionstyle -eq 'raw' | `
Initialize-Disk -PartitionStyle MBR -PassThru | `
New-Partition -AssignDriveLetter -UseMaximumSize | `
Format-Volume -FileSystem NTFS -NewFileSystemLabel "myDataDisk" -Confirm:$false

#>








<#


Write-Verbose "Delete Disk (Managed Data Disk): {$rgName}"

$jobRGDelete = Remove-AzureRmResourceGroup -Name $rgName -Force -AsJob

$jobRGDelete

#>



<#

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-manage-data-disk

#>




