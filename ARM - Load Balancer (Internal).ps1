

## To Set Verbose output
$PSDefaultParameterValues['*:Verbose'] = $true



<# Remove NIC to LB #>

<#

Network Interface (NIC)
Load Balancer (LB)

#>

# Variables - common

$rgShortName = "qweasdzxc"
$rgSuffix = "-rg"
$rgName = "${rgShortName}${rgSuffix}"


$nicShortName = "qweasdzxc"
$nicSuffix = "-nic"
$nicName = "${nicShortName}${nicSuffix}"


$lbShortName = "qweasdzxc"
$lbSuffix = "-lb"
$lbName = "${lbShortName}${lbSuffix}"






$rgName="qweasdzxc-rg"
$lbName="qweasdzxc-lb"
$frontendName = "qweasdzxcFrontEndPool"




<# NAT Rule #>

<#

Load Balancer (LB)


#>

# Variables - NAT Rule

$lbRuleName = "TestNatRule"
$natRuleFrontEndPort = 3350
$natRuleBackEndPort = 3350







    Write-Verbose "Fetching Load Balancer (LB): {$lbName}"
    $lb = Get-AzureRmLoadBalancer -Name $lbName -ResourceGroupName $rgName 


    #Write-Verbose "Fetching Backend Pool: {$backendPoolName}"
    #$backend = Get-AzureRmLoadBalancerBackendAddressPoolConfig -Name $backendPoolName -LoadBalancer $lb
    
    Write-Verbose "Fetching Frontend IP config: {$frontendName}"
    $frontendIP = Get-AzureRmLoadBalancerFrontendIpConfig -Name $frontendName -LoadBalancer $lb
    #$frontendIP = $lb.FrontendIpConfigurations[0]


    Write-Verbose "Creating NAT rules: {$lbRuleName}"

    Add-AzureRmLoadBalancerInboundNatRuleConfig `
        -LoadBalancer $lb `
        -Name $lbRuleName `
        -FrontendIPConfiguration $frontendIP `
        -FrontendPort $natRuleFrontEndPort `
        -BackendPort $natRuleBackEndPort `
        -Protocol "Tcp" `
        -EnableFloatingIP

    Set-AzureRmLoadBalancer -LoadBalancer $lb



<#

   

<#
# References

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-load-balancer

#>


