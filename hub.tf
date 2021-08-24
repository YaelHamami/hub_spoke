resource "azurerm_resource_group" "hub" {
  name     = local.hub_resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = local.hub_vnet_address_space
  dns_servers         = local.hub_vnet_dns_servers
}

resource "azurerm_subnet" "azure_firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = local.firewall_subnet_address_prefixes
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = local.gateway_subnet_address_prefixes
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = local.log_workspace_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = local.log_workspace_sku
  retention_in_days   = 30
}

module "firewall" {
  source                     = "./modules/firewall"
  firewall_name              = local.hub_firewall_name
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  firewall_subnet_id         = azurerm_subnet.azure_firewall_subnet.id
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  firewall_policy_name       = local.hub_firewall_policy_name
  network_rules              = local.network_rules
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  depends_on                 = [azurerm_virtual_network.hub_vnet]
}


module "vpn" {
  source               = "./modules/vpn"
  location             = azurerm_resource_group.hub.location
  resource_group_name  = azurerm_resource_group.hub.name
  vnet_name            = azurerm_virtual_network.hub_vnet.name
  subnet_id            = azurerm_subnet.GatewaySubnet.id
  client_address_space = local.vpn_client_address_space
  virtual_gateway_name = local.virtual_gateway_name
  aad_tenant           = local.aad_tenant
  aad_audience         = local.audience_id
  aad_issuer           = local.aad_issuer
  depends_on           = [
    azurerm_virtual_network.hub_vnet,
  ]
}

module "gateway_route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = local.gateway_route_table_name
  routes               = local.hub_routes
  associated_subnet_id = azurerm_subnet.GatewaySubnet.id
  depends_on           = [module.firewall, module.vpn]
}


