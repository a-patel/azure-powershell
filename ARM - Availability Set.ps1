
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


<# Azure Availability #>


# Variables - Availability Set

$asShortName = "qweasdzxc"
$avSetSuffix = "-as"
$asName = "${asShortName}${avSetSuffix}"



<# Create an Azure Availability Set for VM high availability, if it does not exist #>

Get-AzureRmAvailabilitySet -Name $asName -ResourceGroupName $rgName -ErrorVariable isASExist -ErrorAction SilentlyContinue `

If ($isASExist) 
{
    Write-Output "Availability Set does not exist"
    
    Write-Verbose "Creating new Availability Set: {$asName}"


    $as = New-AzureRmAvailabilitySet `
                -Name $asName `
                -ResourceGroupName $rgName `
                -Location $location `
                -Sku Aligned `
                -PlatformFaultDomainCount  2 `
                -PlatformUpdateDomainCount 5 `
                
# -Tags $tags `

# -Sku 'Aligned' ` # Aligned: For managed disks or Classic: For unmanaged disks
} 
Else 
{
    Write-Output "Availability Set exist"

    Write-Verbose "Fetching Availability Set: {$asName}"


    $as = Get-AzureRmAvailabilitySet `
                -Name $asName `
                -ResourceGroupName $rgName
}




Write-Verbose "Get list of Availability Set"

Write-Output "Availability Sets"


Get-AzureRmAvailabilitySet -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -GroupBy ResourceGroupName -Wrap 


<#

Get-AzureRmAvailabilitySet -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -GroupBy ResourceGroupName -Wrap 

#>






<#

https://docs.microsoft.com/en-us/powershell/module/azurerm.compute/new-azurermavailabilityset?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0

#>
