resource "azurerm_resource_group" "hub" {
  name     = "${local.prefixes.hub_prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${local.prefixes.hub_prefix}-vnet"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space = [
  "10.1.0.0/24"]
  dns_servers = [
    "10.1.0.4",
  "10.1.0.5"]
}

resource "azurerm_subnet" "azure_firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.1.0.0/26"]
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.1.0.128/27"]
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${local.prefixes.hub_prefix}-firewall-logs-workspace"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "firewall" {
  source                     = "./modules/firewall"
  firewall_name              = "${local.prefixes.hub_prefix}-firewall"
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  firewall_subnet_id         = azurerm_subnet.azure_firewall_subnet.id
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  policy_name                = "${local.prefixes.hub_prefix}-firewall-policy"
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
  public_ip_name       = "${local.prefixes.hub_prefix}-gateway-public-ip"
  client_address_space = ["192.168.0.0/24"]
  virtual_gateway_name = "${local.prefixes.hub_prefix}-virtual-gateway"
  aad_tenant           = local.aad_tenant
  aad_audience         = var.audience_id
  aad_issuer           = local.aad_issuer
  depends_on = [
    azurerm_virtual_network.hub_vnet,
  ]
}

module "gateway_route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "${local.prefixes.hub_prefix}-firewall-to-spoke-route-table"
  routes               = local.hub_routes
  associated_subnet_id = azurerm_subnet.GatewaySubnet.id
  depends_on           = [module.firewall, module.vpn]
}



