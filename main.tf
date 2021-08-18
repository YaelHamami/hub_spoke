provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

resource "azurerm_resource_group" "hub" {
  name     = "hub"
  location = "West Europe"
}

resource "azurerm_resource_group" "spoke" {
  name     = "spoke"
  location = "West Europe"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space = [
  "10.1.0.0/24"]
  dns_servers = [
    "10.1.0.4",
  "10.1.0.5"]
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "spoke"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space = [
  "10.0.0.0/24"]
  dns_servers = [
    "10.0.0.4",
  "10.0.0.5"]

  subnet {
    name           = "vm-subnet"
    address_prefix = "10.0.0.0/24"
  }
}

module "ubuntu_vm_spoke" {
  source         = "./modules/ubuntu_vm"
  comp_name      = "vm2"
  location       = azurerm_resource_group.spoke.location
  nic_name       = "nic2"
  rg_name        = azurerm_resource_group.spoke.name
  admin_username = "bob"
  admin_password = "Password1234!"
  subnet_id      = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
}

module "vpn_connection" {
  source                  = "./modules/vpn_connection"
  location                = azurerm_resource_group.hub.location
  rg_name                 = azurerm_resource_group.hub.name
  vnet_name               = azurerm_virtual_network.hub_vnet.name
  public_ip_name          = "gateway-ip"
  subnet_address_prefixes = ["10.1.0.128/27"]
  virtual_gateway_name    = "hub-gateway"
  aad_tenant              = "https://login.microsoftonline.com/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
  aad_audience            = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  aad_issuer              = "https://sts.windows.net/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
  depends_on = [
    azurerm_virtual_network.hub_vnet,
  ]
}

module "firewall" {
  source                           = "./modules/firewall"
  fw_name                          = "hub-firewall"
  location                         = azurerm_resource_group.hub.location
  rg_name                          = azurerm_resource_group.hub.name
  vnet_name                        = azurerm_virtual_network.hub_vnet.name
  address_prefixes                 = ["10.1.0.0/26"]
  policy_name                      = "policy"
  rule_collection_name             = "rule-collection"
  rule_collection_priority         = 400
  network_rule_collection_name     = "network-rule-collection"
  network_rule_collection_priority = 400
  network_rules = [
    {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
  }]
  log_analytics_workspace_id = azurerm_log_analytics_workspace.firewall_logs.id
  depends_on                 = [azurerm_virtual_network.hub_vnet]
}

resource "azurerm_log_analytics_workspace" "firewall_logs" {
  name                = "firewall-logs"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "firewall_to_spoke" {
  source           = "./modules/route_table"
  rg_name          = azurerm_resource_group.hub.name
  location         = azurerm_resource_group.hub.location
  route_table_name = "firewall-to-spoke"
  routes = [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = "10.0.0.0/24"
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = "10.1.0.4"
    },
    {
      name                       = "firewall-to-spoke"
      destination_address_prefix = "10.0.0.0/24"
      next_hop_type              = "VirtualAppliance"
    }
  ]
  associated_subnet_id = module.vpn_connection.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn_connection]
}

module "spoke_out" {
  source           = "./modules/route_table"
  rg_name          = azurerm_resource_group.spoke.name
  location         = azurerm_resource_group.spoke.location
  route_table_name = "spoke-out"
  routes = [{
    name                       = "spoke-out"
    destination_address_prefix = "192.168.0.0/24"
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = "10.1.0.4"
    }
  ]
  associated_subnet_id = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
  depends_on           = [module.firewall, module.vpn_connection]
}

module "v1_v2_two_way_peering" {
  source                            = "./modules/two_way_peering"
  vnet1_name                        = azurerm_virtual_network.hub_vnet.name
  vnet1_id                          = azurerm_virtual_network.hub_vnet.id
  vnet1_vnet2_name                  = "peering-v1-v2"
  vnet1_vnet2_resource_group_name   = azurerm_virtual_network.hub_vnet.resource_group_name
  vnet1_vnet2_allow_gateway_transit = true
  vnet2_name                        = azurerm_virtual_network.spoke_vnet.name
  vnet2_id                          = azurerm_virtual_network.spoke_vnet.id
  vnet2_vnet1_name                  = "peering-v2-v1"
  vnet2_vnet1_resource_group_name   = azurerm_virtual_network.spoke_vnet.resource_group_name
  vnet2_vnet1_use_remote_gateways   = true
  depends_on = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
  module.vpn_connection]
}


