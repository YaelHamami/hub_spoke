locals {
  spoke-prefix              = "daniel-spoke"
  spoke_resource_group_name = "${local.spoke-prefix}-rg"

  spoke_vnet_name          = "spoke_vnet"
  spoke_vnet_address_space = ["10.0.0.0/24"]
  spoke_vnet_dns_servers   = ["10.0.0.4", "10.0.0.5"]

  spoke_subnet_name             = "SpokeSubnet"
  spoke_subnet_address_prefixes = ["10.0.0.0/24"]

  spoke_network_security_group_name  = "${local.spoke-prefix}-nsg"
  spoke_network_security_group_rules = jsondecode(templatefile("./templates/network_security_group_rules/spoke_network_security_group.json", {
    "vpn_client_address_space"      = local.vpn_client_address_space[0]
    "spoke_subnet_address_space" = local.spoke_subnet_address_prefixes[0]
  })).rules

  spoke_route_table_name = "${local.spoke-prefix}-route-table"
  spoke_routes           = jsondecode(templatefile("./templates/routes/spoke_routes.json", {
    "vpn_client_address_prefix" = local.vpn_client_address_space[0]
    "firewall_private_ip"       = module.firewall.private_ip
  })).spoke_routes

  storage_data_disks = [
    {
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = 1023
    },
    {
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = 1023
    }
  ]
}

resource "azurerm_resource_group" "spoke" {
  name     = local.spoke_resource_group_name
  location = local.location
}

module "spoke_vnet" {
  source              = "./modules/vnet"
  location            = azurerm_resource_group.spoke.location
  name                = local.spoke_vnet_name
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = local.spoke_vnet_address_space
  subnets             = [{
    name             = local.spoke_subnet_name
    address_prefixes = local.spoke_vnet_address_space
  }]
  depends_on          = [azurerm_resource_group.spoke]
}

module "network_security_group" {
  source              = "./modules/network_security_group"
  location            = azurerm_resource_group.spoke.location
  name                = local.spoke_network_security_group_name
  resource_group_name = azurerm_resource_group.spoke.name
  security_rules      = local.spoke_network_security_group_rules
  subnets_id          = module.spoke_vnet.subnets_ids
  depends_on          = [module.spoke_vnet, azurerm_resource_group.spoke]
}

module "ubuntu_vm_spoke" {
  source              = "./modules/vm"
  vm_name             = var.spoke_vm_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  subnet_id           = module.spoke_vnet.subnets.SpokeSubnet.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  storage_data_disks  = local.storage_data_disks
  depends_on          = [azurerm_resource_group.spoke, module.spoke_vnet]
}


module "spoke_route_table" {
  source                 = "./modules/route_table"
  resource_group_name    = azurerm_resource_group.spoke.name
  location               = azurerm_resource_group.spoke.location
  route_table_name       = local.spoke_route_table_name
  routes                 = local.spoke_routes
  associated_subnets_ids = module.spoke_vnet.subnets_ids
  depends_on             = [
    module.spoke_vnet,
    module.hub_vnet]
}

module "hub_spoke_two_way_peering" {
  source                              = "./modules/vnet_two_way_peering"
  local_vnet_name                     = module.spoke_vnet.name
  local_vnet_id                       = module.spoke_vnet.id
  local_to_remote_resource_group_name = module.spoke_vnet.object.resource_group_name
  local_remote_use_remote_gateways    = true

  remote_vnet_name                   = module.hub_vnet.name
  remote_vnet_id                     = module.hub_vnet.id
  remote_local_resource_group_name   = module.hub_vnet.object.resource_group_name
  remote_local_allow_gateway_transit = true
  depends_on                         = [
    module.spoke_vnet,
    module.hub_vnet,
    module.vpn]
}
