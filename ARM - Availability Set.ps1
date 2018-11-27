

<# Azure Availability #>


# Variables - Availability Set

$asShortName = "aabbccdd12"
$avSetSuffix = "-as"
$asName = "${asShortName}${avSetSuffix}"



<# Create an Azure Availability Set for VM high availability, if it does not exist #>

Get-AzureRmAvailabilitySet -Name $asName -ResourceGroupName $rgName -ErrorVariable isASExist -ErrorAction SilentlyContinue `

If ($isASExist) 
{
    Write-Output "Availability Set does not exist"
    
    Write-Verbose "Creating new Availability Set: {$asName}"


    $avSet = New-AzureRmAvailabilitySet `
                -Name $asName `
                -ResourceGroupName $rgName `
                -Location $location
} 
Else 
{
    Write-Output "Availability Set exist"

    Write-Verbose "Fetching Availability Set: {$asName}"


    $avSet = Get-AzureRmAvailabilitySet `
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

https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0

#>
