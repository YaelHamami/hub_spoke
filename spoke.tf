resource "azurerm_resource_group" "spoke" {
  name     = "spoke"
  location = "West Europe"
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "spoke"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = [
    "10.0.0.0/24"]
  dns_servers         = [
    "10.0.0.4",
    "10.0.0.5"]

  subnet {
    name           = "vm-subnet"
    address_prefix = "10.0.0.0/24"
  }
}

module "ubuntu_vm_spoke" {
  source              = "./modules/ubuntu_vm"
  comp_name           = "vm2"
  location            = azurerm_resource_group.spoke.location
  nic_name            = "nic2"
  resource_group_name = azurerm_resource_group.spoke.name
  admin_username      = "bob"
  admin_password      = "Password1234!"
  subnet_id           = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
}


module "spoke_out" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.spoke.name
  location             = azurerm_resource_group.spoke.location
  route_table_name     = "spoke-out"
  routes               = [{
    name                       = "spoke-out"
    destination_address_prefix = module.vpn_connection.client_address_space
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.firewall_private_ip
  }
  ]
  associated_subnet_id = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
  depends_on           = [module.firewall, module.vpn_connection]
}