resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = [
    "10.1.0.0/24"]
  dns_servers         = [
    "10.1.0.4",
    "10.1.0.5"]
}


module "vpn_connection" {
  source                  = "./modules/vpn_connection"
  location                = azurerm_resource_group.hub.location
  resource_group_name     = azurerm_resource_group.hub.name
  vnet_name               = azurerm_virtual_network.hub_vnet.name
  public_ip_name          = "gateway-ip"
  subnet_address_prefixes = ["10.1.0.128/27"]
  client_address_space    = ["192.168.0.0/24"]
  virtual_gateway_name    = "hub-gateway"
  aad_tenant              = "https://login.microsoftonline.com/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
  aad_audience            = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  aad_issuer              = "https://sts.windows.net/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
  depends_on              = [
    azurerm_virtual_network.hub_vnet,
  ]
}

module "firewall" {
  source                           = "./modules/firewall"
  firewall_name                    = "hub-firewall"
  location                         = azurerm_resource_group.hub.location
  resource_group_name              = azurerm_resource_group.hub.name
  vnet_name                        = azurerm_virtual_network.hub_vnet.name
  address_prefixes                 = ["10.1.0.0/26"]
  policy_name                      = "policy"
  rule_collection_name             = "rule-collection"
  rule_collection_priority         = 400
  network_rule_collection_name     = "network-rule-collection"
  network_rule_collection_priority = 400
  network_rules                    = [
    {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }]
  log_analytics_workspace_id       = azurerm_log_analytics_workspace.firewall_logs.id
  depends_on                       = [azurerm_virtual_network.hub_vnet]
}

resource "azurerm_log_analytics_workspace" "firewall_logs" {
  name                = "firewall-logs"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "firewall_to_spoke" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "firewall-to-spoke"
  routes               = [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = azurerm_virtual_network.spoke_vnet.address_space[0]
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = module.firewall.firewall_private_ip
  },]
  associated_subnet_id = module.vpn_connection.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn_connection]
}

module "local_remote_peering" {
  source                              = "./modules/two_way_peering"
  local_network_name                  = azurerm_virtual_network.hub_vnet.name
  local_vnet_id                       = azurerm_virtual_network.hub_vnet.id
  local_to_remote_name                = "local-to-remote"
  local_to_remote_resource_group_name = azurerm_virtual_network.hub_vnet.resource_group_name
  local_remote_allow_gateway_transit  = true
  remote_vnet_name                    = azurerm_virtual_network.spoke_vnet.name
  remote_vnet_id                      = azurerm_virtual_network.spoke_vnet.id
  remote_to_local_name                = "remote-to-local"
  remote_local_resource_group_name    = azurerm_virtual_network.spoke_vnet.resource_group_name
  remote_local_use_remote_gateways    = true
  depends_on                          = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
    module.vpn_connection]
}


