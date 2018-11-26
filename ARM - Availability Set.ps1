

# Variables for common values

$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("author", "Ashish")
$tags.Add("project", "demo")


$location = "eastus2"

$rgShortName = "aabbccdd12"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"




# Create an Azure Availability Set for VM high availability, if it doesn't exist


### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0


$asShortName = "aabbccdd12"
$avSetSuffix = "-as"
$asName = "${asShortName}${avSetSuffix}"



Get-AzureRmAvailabilitySet -Name $asName -ResourceGroupName $rgName -ErrorVariable isRGExist -ErrorAction SilentlyContinue `

If ($isRGExist) {
    # Availability Set doesn't exist
    "Availability Set doesn't exist"

    $avSet = New-AzureRmAvailabilitySet `
                -Name $asName `
                -ResourceGroupName $rgName `
                -Location $location


} Else {
    # Availability Set exist
    "Availability Set exist"

    $avSet = Get-AzureRmAvailabilitySet `
                -Name $asName `
                -ResourceGroupName $rgName
}




Get-AzureRmAvailabilitySet -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -GroupBy ResourceGroupName -Wrap 


<#

Get-AzureRmAvailabilitySet -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -GroupBy ResourceGroupName -Wrap 

#>





<#



#>
