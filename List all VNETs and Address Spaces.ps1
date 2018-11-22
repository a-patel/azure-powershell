$subs = Get-AzureRmSubscription 
foreach ($Sub in $Subs) { 
    #$SelectSub = Select-AzureRmSubscription -SubscriptionName $Sub.Name 
    $VNETs = Get-AzureRmVirtualNetwork 
    foreach ($VNET in $VNETs) { 
        $Sub.Name 
        $VNET.Name 
        ($VNET).AddressSpace.AddressPrefixes 
        Write-Host " " 
    } 
}