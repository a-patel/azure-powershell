


# Variables for common values

$location = "eastus2"


$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("environment", "Production")         # Production, Staging, QA
$tags.Add("projectName", "Demo Project")
$tags.Add("projectVersion", "1.0.0")
$tags.Add("managedBy", "developer.aashishpatel@gmail.com")
$tags.Add("billTo", "Ashish Patel")
$tags.Add("tier", "Front End")                 # Front End, Back End, Data
$tags.Add("dataProfile", "Public")             # Public, Confidential, Restricted, Internal





# Create Resource Group, if it doesn't exist


# Variables for Resource Group

$rgShortName = "aabbccdd12"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"



Get-AzureRmResourceGroup -Name $rgName -ErrorVariable isRGExist -ErrorAction SilentlyContinue `

If ($isRGExist) {

    "ResourceGroup does not exist"

    $rg = New-AzureRmResourceGroup `
            -Name $rgName `
            -Location $location `

} Else {

    "ResourceGroup exist"

    $rg = Get-AzureRmResourceGroup `
            -Name $rgName 
}



# Get list of Resource Groups

Get-AzureRmResourceGroup | Select-Object ResourceGroupName, Location `
                         | Format-Table -AutoSize -Wrap -GroupBy Location






<#

https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroup?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0

# Naming Conventions
https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions

# Format table
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-6

#>
