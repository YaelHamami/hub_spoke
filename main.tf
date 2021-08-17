provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

resource "azurerm_resource_group" "project" {
  name     = "project"
  location = "West Europe"
}

resource "azurerm_virtual_network" "hub" {
  name                = "hub"
  location            = azurerm_resource_group.project.location
  resource_group_name = azurerm_resource_group.project.name
  address_space       = [
    "10.1.0.0/24"]
  dns_servers         = [
    "10.1.0.4",
    "10.1.0.5"]
}

resource "azurerm_virtual_network" "spoke" {
  name                = "spoke"
  location            = azurerm_resource_group.project.location
  resource_group_name = azurerm_resource_group.project.name
  address_space       = [
    "10.0.0.0/24"]
  dns_servers         = [
    "10.0.0.4",
    "10.0.0.5"]

  subnet {
    name           = "vnet"
    address_prefix = "10.0.0.0/24"
  }
}

module "vm" {
  source    = "./modules/ubuntu_vm"
  comp_name = "vm2"
  location  = azurerm_resource_group.project.location
  nic_name  = "nic2"
  rg_name   = azurerm_resource_group.project.name
  admin_username = "bob"
  admin_password = "Password1234!"
  subnet_id = tolist(azurerm_virtual_network.spoke.subnet)[0].id
}

module "vpn_connection" {
  source                  = "./modules/vpn_connection"
  location                = azurerm_resource_group.project.location
  rg_name                 = azurerm_resource_group.project.name
  vnet_name               = azurerm_virtual_network.hub.name
  public_ip_name          = "gateway_ip"
  subnet_address_prefixes = ["10.1.0.128/27"]
  virtual_gateway_name    = "hub_gateway"
  aad_tenant              = "https://login.microsoftonline.com/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
  aad_audience            = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  aad_issuer              = "https://sts.windows.net/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
  depends_on              = [
    azurerm_virtual_network.hub,
  ]
}

module "firewall" {
  source                     = "./modules/firewall"
  fw_name                    = "hub_firewall"
  location                   = azurerm_resource_group.project.location
  rg_name                    = azurerm_resource_group.project.name
  vnet_name                  = azurerm_virtual_network.hub.name
  address_prefixes           = ["10.1.0.0/26"]
  vm_private_ip              = "10.0.0.4"
  policy_name = "policy"
  rule_collection_name = "rule_collection"
  rule_collection_priority = 400
  network_rule_collection_name = "network_rule_collection"
  network_rule_collection_priority = 400
  network_rules              = var.network_rules
  log_analytics_workspace_id = azurerm_log_analytics_workspace.firewall_logs.id
  depends_on                 = [
    azurerm_virtual_network.hub,
  ]
}

resource "azurerm_log_analytics_workspace" "firewall_logs" {
  name                = "firewall-logs"
  location            = azurerm_resource_group.project.location
  resource_group_name = azurerm_resource_group.project.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "firewall_to_spoke" {
  source               = "./modules/firewall_route"
  rg_name              = azurerm_resource_group.project.name
  location             = azurerm_resource_group.project.location
  route_table_name     = "firewall_to_spoke"
  routes               = [{
    name                       = "firewall_to_spoke"
    destination_address_prefix = "10.0.0.0/24"
    firewall_private_ip        = "10.1.0.4"
  }
  ]
  associated_subnet_id = module.vpn_connection.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn_connection]
}

module "spoke_out" {
  source               = "./modules/firewall_route"
  rg_name              = azurerm_resource_group.project.name
  location             = azurerm_resource_group.project.location
  route_table_name     = "spoke_out"
  routes               = [{
    name                       = "spoke_out"
    destination_address_prefix = "192.168.0.0/24"
    firewall_private_ip        = "10.1.0.4"
  }
  ]
  associated_subnet_id = tolist(azurerm_virtual_network.spoke.subnet)[0].id
  depends_on           = [module.firewall, module.vpn_connection]
}


resource "azurerm_virtual_network_peering" "hub_spoke" {
  name                      = "peer_hub_spoke"
  resource_group_name       = azurerm_resource_group.project.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_gateway_transit     = true
  depends_on                = [module.vpn_connection, azurerm_virtual_network.hub, azurerm_virtual_network.spoke]
}

resource "azurerm_virtual_network_peering" "spoke_hub" {
  name                      = "peer_spoke_hub"
  resource_group_name       = azurerm_resource_group.project.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  use_remote_gateways       = true
  depends_on                = [
    azurerm_virtual_network_peering.hub_spoke,
    module.vpn_connection,
    azurerm_virtual_network.hub,
    azurerm_virtual_network.spoke]
}

