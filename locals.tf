locals {

  prefixes = {
    hub_prefix   = "daniel-hub"
    spoke_prefix = "daniel-spoke"
  }

  network_rules = [
    {
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }]

  hub_routes =  [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = azurerm_virtual_network.spoke_vnet.address_space[0]
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.private_ip
  },]

  spoke_routes = [{
    name                       = "spoke-out"
    destination_address_prefix = module.vpn.client_address_space
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.private_ip
  }
  ]

  storage_data_disks = [{
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    disk_size_gb      = "1023"
  },
    {
      managed_disk_type = "Standard_LRS"
      create_option     = "Empty"
      disk_size_gb      = "1023"
    }]
}