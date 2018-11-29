
<# Load Balancer #>


# Variables - Load Balancer

$lbShortName = "qweasdzxc"
$lbSuffix = "-lb"
$lbName = "${lbShortName}${lbSuffix}"

$feName = "qweasdzxcFrontEndPool"
$bepoolName = "qweasdzxcBackEndPool"
$healthProbeName = "qweasdzxcHealthProbe"
$lbRuleName = "qweasdzxcLoadBalancerRuleWeb"


<# Create Load Balancer, if it does not exist #>

Get-AzureRmResourceGroup -Name $lbName -ErrorVariable isLBExist -ErrorAction SilentlyContinue `


If ($isLBExist) 
{
    Write-Output "Load Balancer does not exist"
    

    # public IP address
    Write-Verbose "Fetching Public IP: {$publicIpName}"

    $publicIp = Get-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName



    # Create a front-end IP configuration for the website.
    Write-Verbose "Creating front-end IP configuration: {$feName}"
    $feIp = New-AzureRmLoadBalancerFrontendIpConfig -Name $feName -PublicIpAddress $publicIp


    # Create the back-end address pool.
    Write-Verbose "Creating back-end address pool: {$bepoolName}"
    $bepool = New-AzureRmLoadBalancerBackendAddressPoolConfig -Name $bepoolName


    # Creates a load balancer probe on port 80.
    Write-Verbose "Creating a load balancer probe on port 80: {$healthProbeName}"
    $probe = New-AzureRmLoadBalancerProbeConfig -Name $healthProbeName -Protocol Http -Port 80 `
                -RequestPath / -IntervalInSeconds 360 -ProbeCount 5



    # Creates a load balancer rule for port 80.
    Write-Verbose "Creating a load balancer rule for port 80: {$lbRuleName}"
    $rule = New-AzureRmLoadBalancerRuleConfig `
                -Name $lbRuleName ` 
                -Protocol Tcp `
                -Probe $probe -FrontendPort 80 -BackendPort 80 `
                -FrontendIpConfiguration $feip -BackendAddressPool $bePool



    # Create three NAT rules for port 3389.
    Write-Verbose "Creating three NAT rules for port 3389: {$lbRuleName}"
    $natrule1 = New-AzureRmLoadBalancerInboundNatRuleConfig -Name 'myLoadBalancerRDP1' -FrontendIpConfiguration $feip `
      -Protocol tcp -FrontendPort 4221 -BackendPort 3389

    $natrule2 = New-AzureRmLoadBalancerInboundNatRuleConfig -Name 'myLoadBalancerRDP2' -FrontendIpConfiguration $feip `
      -Protocol tcp -FrontendPort 4222 -BackendPort 3389

    $natrule3 = New-AzureRmLoadBalancerInboundNatRuleConfig -Name 'myLoadBalancerRDP3' -FrontendIpConfiguration $feip `
      -Protocol tcp -FrontendPort 4223 -BackendPort 3389



    # Create a load balancer.
    Write-Verbose "Creating Load Balancer: {$lbName}"

    $lb = New-AzureRmLoadBalancer `
            -Name $lbName `
            -ResourceGroupName $rgName `
            -Location $location `
            -FrontendIpConfiguration $feip `
            -BackendAddressPool $bepool `
            -Probe $probe `
            -LoadBalancingRule $rule `
            -InboundNatRule $natrule1,$natrule2,$natrule3
} 
Else 
{
    Write-Output "Load Balancer exist"

    Write-Verbose "Fetching Load Balancer: {$lbName}"


    $lb = Get-AzureRmLoadBalancer `
            -Name $lbName 
}



Write-Verbose "Get list of Load Balancers"
Write-Output "Load Balancers"


Get-AzureRmResourceGroup | Select-Object ResourceGroupName, Location `
                         | Format-Table -AutoSize -Wrap -GroupBy Location


<#


Write-Verbose "Delete Load Balancer: {$lbName}"

$jobLBDelete = Remove-AzureRmResourceGroup -Name $lbName -Force -AsJob

$jobLBDelete

#>





<#

https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-windows-powershell-sample-create-nlb-vm?toc=%2fpowershell%2fmodule%2ftoc.json

#>


