resource "azurerm_resource_group" "spoke" {
  name     = local.prefixes.spoke_prefix
  location = var.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "${local.prefixes.spoke_prefix}-spoke"
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
  vm_name             = "vm"
  source              = "./modules/vm"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  subnet_id           = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
  admin_username = "bob"
  admin_password = "Aa1234567890"

  storage_data_disks = local.storage_data_disks
}


module "spoke_route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.spoke.name
  location             = azurerm_resource_group.spoke.location
  route_table_name     = "${local.prefixes.spoke_prefix}-spoke-out"
  routes               = local.spoke_routes
  associated_subnet_id = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
  depends_on           = [module.firewall, module.vpn]
}

module "local_remote" {
  source                              = "./modules/two_way_peering"
  local_network_name                  = azurerm_virtual_network.spoke_vnet.name
  local_vnet_id                       = azurerm_virtual_network.spoke_vnet.id
  local_to_remote_name                = "${local.prefixes.spoke_prefix}-local-to-remote"
  local_to_remote_resource_group_name = azurerm_virtual_network.spoke_vnet.resource_group_name
  local_remote_use_remote_gateways    = true

  remote_vnet_name                   = azurerm_virtual_network.hub_vnet.name
  remote_vnet_id                     = azurerm_virtual_network.hub_vnet.id
  remote_to_local_name               = "${local.prefixes.hub_prefix}-remote-to-local"
  remote_local_resource_group_name   = azurerm_virtual_network.hub_vnet.resource_group_name
  remote_local_allow_gateway_transit = true
  depends_on                         = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
    module.vpn]
}
