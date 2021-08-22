resource "azurerm_resource_group" "hub" {
  name     = "${local.prefixes.hub_prefix}-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${local.prefixes.hub_prefix}-vnet"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = [
    "10.1.0.0/24"]
  dns_servers         = [
    "10.1.0.4",
    "10.1.0.5"]
}


module "vpn" {
  source                  = "./modules/vpn"
  location                = azurerm_resource_group.hub.location
  resource_group_name     = azurerm_resource_group.hub.name
  vnet_name               = azurerm_virtual_network.hub_vnet.name
  public_ip_name          = "${local.prefixes.hub_prefix}-gateway-public-ip"
  subnet_address_prefixes = ["10.1.0.128/27"]
  client_address_space    = ["192.168.0.0/24"]
  virtual_gateway_name    = "${local.prefixes.hub_prefix}-virtual-gateway"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  aad_tenant              = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_audience            = var.audience_id
  aad_issuer              = "https://sts.windows.net/${var.tenant_id}/"
  depends_on              = [
    azurerm_virtual_network.hub_vnet,
  ]
}

module "firewall" {
  source                           = "./modules/firewall"
  firewall_name                    = "${local.prefixes.hub_prefix}-firewall"
  location                         = azurerm_resource_group.hub.location
  resource_group_name              = azurerm_resource_group.hub.name
  vnet_name                        = azurerm_virtual_network.hub_vnet.name
  address_prefixes                 = ["10.1.0.0/26"]
  policy_name                      = "${local.prefixes.hub_prefix}-firewall-policy"
  rule_collection_name             = "${local.prefixes.hub_prefix}-rule-collection"
  rule_collection_priority         = 400
  network_rules                    = local.network_rules
  log_analytics_workspace_id       = azurerm_log_analytics_workspace.logs.id
  depends_on                       = [azurerm_virtual_network.hub_vnet]
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${local.prefixes.hub_prefix}-firewall-logs-workspace"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "firewall_to_spoke" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "${local.prefixes.hub_prefix}-firewall-to-spoke-route-table"
  routes               = local.hub_routes
  associated_subnet_id = module.vpn.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn]
}

module "local_remote_peering" {
  source                              = "./modules/two_way_peering"
  local_network_name                  = azurerm_virtual_network.hub_vnet.name
  local_vnet_id                       = azurerm_virtual_network.hub_vnet.id
  local_to_remote_name                = "${local.prefixes.hub_prefix}-local-to-remote-peering"
  local_to_remote_resource_group_name = azurerm_virtual_network.hub_vnet.resource_group_name
  local_remote_allow_gateway_transit  = true
  remote_vnet_name                    = azurerm_virtual_network.spoke_vnet.name
  remote_vnet_id                      = azurerm_virtual_network.spoke_vnet.id
  remote_to_local_name                = "${local.prefixes.hub_prefix}-remote-to-local-peering"
  remote_local_resource_group_name    = azurerm_virtual_network.spoke_vnet.resource_group_name
  remote_local_use_remote_gateways    = true
  depends_on                          = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
    module.vpn]
}


