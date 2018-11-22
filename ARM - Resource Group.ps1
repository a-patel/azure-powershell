

# Variables for common values

$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("author", "Ashish")
$tags.Add("project", "demo")


$location = "eastus2"


# Create Resource Group, if it doesn't already exist


### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
### https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0


$rgName = "aabbccdd12"
$rgSuffix = "-rg"
$rgFullName = "${rgName}${rgSuffix}"



Get-AzureRmResourceGroup -Name $rgFullName -ErrorVariable isRGExist -ErrorAction SilentlyContinue `

If ($isRGExist) {
    # ResourceGroup doesn't exist
    "ResourceGroup doesn't exist"

    $rg = New-AzureRmResourceGroup `
            -Name $rgFullName `
            -Location $location `

} Else {
    # ResourceGroup exist
    "ResourceGroup exist"

    $rg = Get-AzureRmResourceGroup `
            -Name $rgFullName 
}


# Get-AzureRmResourceGroup | Select-Object ResourceGroupName,Location



