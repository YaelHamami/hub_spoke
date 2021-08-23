locals {

  prefixes = {
    hub_prefix   = "daniel-hub"
    spoke_prefix = "daniel-spoke"
  }

   hub_address_space = ["10.1.0.0/24"]

  aad_tenant = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_issuer = "https://sts.windows.net/${var.tenant_id}/"

  network_rules = [
    {
      protocols             = ["ICMP", "TCP"]
      source_addresses      = ["192.168.0.0/24"]
      destination_addresses = ["*"]
      destination_ports     = ["22"]
    }]

  hub_routes = [{
    name                       = "ToSpokeByHubFW"
    destination_address_prefix = azurerm_virtual_network.spoke_vnet.address_space[0]
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.private_ip
  },]

  spoke_routes = [{
    name                       = "ToOnPremiseBySpokeVM"
    destination_address_prefix = module.vpn.client_address_space
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.private_ip
  }
  ]

  storage_data_disks = [{
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1023"
  },
    {
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = "1023"
    }]
}