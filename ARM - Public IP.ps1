
<# Create Public IP Address, if it does not exist #>


# Variables - Public IP

$publicIpShortName = "aabbccdd12"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"
$dnsPrefix  = "this"


Get-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName -ErrorVariable isIPExist -ErrorAction SilentlyContinue `


If ($isIPExist) 
{
    Write-Output "Public IP does not exist"
    
    Write-Verbose "Creating new Public IP: {$publicIpName}"


    $publicIP = New-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName `
                -Location $location `
                -AllocationMethod 'Static' `  ## 'Static' 'Dynamic'
                -DomainNameLabel $dnsPrefix  `  ## optional
                -Tag $tags
} 
Else 
{
    Write-Output "Public IP exist"

    Write-Verbose "Fetching Public IP: {$publicIpName}"


    $publicIP = Get-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName
}




Write-Verbose "Get list of Public IPs"

Write-Output "Public IP"


Get-AzureRmPublicIpAddress -ResourceGroupName $rgName `
| Select-Object Name, ResourceGroupName, Location `
| Format-Table -AutoSize -Wrap




<#

Get-AzureRmPublicIpAddress `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>





<#

https://docs.microsoft.com/en-us/powershell/module/azurerm.network/new-azurermpublicipaddress?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermpublicipaddress?view=azurermps-6.13.0

#>


