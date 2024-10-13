#Setting static IP-adress for VM's

#Add/Change static IP. This process will change MAC address
$vnet = Get-AzVirtualNetwork -Name $VNET -ResourceGroupName $ResourceGroup

$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnet -VirtualNetwork $vnet

$nic = Get-AzNetworkInterface -Name $NetInter -ResourceGroupName $ResourceGroup

#Remove the PublicIpAddress parameter if the VM does not have a public IP.
$nic | Set-AzNetworkInterfaceIpConfig -Name ipconfig1 -PrivateIpAddress $PrivateIP -Subnet $subnet -PublicIpAddress $publicIP -Primary

$nic | Set-AzNetworkInterface