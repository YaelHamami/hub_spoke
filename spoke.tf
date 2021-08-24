resource "azurerm_resource_group" "spoke" {
  name     = local.prefixes.spoke_prefix
  location = local.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = local.spoke_resource_group_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = local.spoke_vnet_address_space
  dns_servers         = local.spoke_vnet_dns_servers

}

resource "azurerm_subnet" "spoke_subnet" {
  name                 = local.spoke_subnet_name
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = local.spoke_subnet_address_prefixes
}

module "ubuntu_vm_spoke" {
  source              = "./modules/vm"
  vm_name             = local.spoke_vm_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  subnet_id           = azurerm_subnet.spoke_subnet.id
  admin_username      = var.admin_details.admin_username
  admin_password      = var.admin_details.admin_password
  storage_data_disks  = local.storage_data_disks
}


module "spoke_route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.spoke.name
  location             = azurerm_resource_group.spoke.location
  route_table_name     = local.spoke_route_table_name
  routes               = local.spoke_routes
  associated_subnet_id = azurerm_subnet.spoke_subnet.id
  depends_on           = [module.firewall, module.vpn]
}

module "local_remote" {
  source                              = "./modules/two_way_peering"
  local_vnet_name                  = azurerm_virtual_network.spoke_vnet.name
  local_vnet_id                       = azurerm_virtual_network.spoke_vnet.id
  local_to_remote_resource_group_name = azurerm_virtual_network.spoke_vnet.resource_group_name
  local_remote_use_remote_gateways    = true

  remote_vnet_name                   = azurerm_virtual_network.hub_vnet.name
  remote_vnet_id                     = azurerm_virtual_network.hub_vnet.id
  remote_local_resource_group_name   = azurerm_virtual_network.hub_vnet.resource_group_name
  remote_local_allow_gateway_transit = true
  depends_on                         = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
    module.vpn]
}
