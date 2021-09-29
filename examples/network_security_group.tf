module "network_security_group" {
  source              = "./relative/path/to/file"
  location            = "West Europe"
  name                = "nsg"
  resource_group_name = "nsg-rg"
  security_rules      = [
    {
      name                       = "AllowInboundSSH"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_ranges         = ["5234","22"]
      destination_port_ranges    = ["22"]
      source_address_prefix      = "192.168.0.0/24"
      destination_address_prefix = "10.0.0.0/24"
    },
    {
      name                       = "DenyInbound"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
  subnets_id          = module.spoke_vnet.subnets_ids
}