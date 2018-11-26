

# Variables for common values

$tags = New-Object 'System.Collections.Generic.Dictionary[String,object]'
$tags.Add("author", "Ashish")
$tags.Add("project", "demo")


$location = "eastus2"

$rgShortName = "aabbccdd12"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"



# Create Public IP Address, if not created


### https://docs.microsoft.com/en-us/powershell/module/azurerm.network/new-azurermpublicipaddress?view=azurermps-6.13.0
### https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermpublicipaddress?view=azurermps-6.13.0


$publicIpName = "aabbccdd12"
$publicIpSuffix = "-ip"
$publicIpFullName = "${publicIpName}${publicIpSuffix}"
$dnsPrefix  = "this"


Get-AzureRmPublicIpAddress -Name $publicIpFullName -ResourceGroupName $rgName -ErrorVariable isIPExist -ErrorAction SilentlyContinue `


If ($isIPExist) {
    "Public IP does not exist"

    $publicIP = New-AzureRmPublicIpAddress `
                -Name $publicIpFullName `
                -ResourceGroupName $rgName `
                -Location $location `
                -AllocationMethod 'Static' `  ## 'Static' 'Dynamic'
                -DomainNameLabel $dnsPrefix  `  ## optional
                -Tag $tags

} Else {
    "Public IP exist"

    $publicIP = Get-AzureRmPublicIpAddress `
                -Name $publicIpFullName `
                -ResourceGroupName $rgName
}



# Get list of Public IPs

Get-AzureRmPublicIpAddress -ResourceGroupName $rgName `
| Select-Object Name, ResourceGroupName, Location `
| Format-Table -AutoSize -Wrap




<#

Get-AzureRmPublicIpAddress `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>

