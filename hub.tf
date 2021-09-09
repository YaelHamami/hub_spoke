locals {
  hub_resource_group_name = "${local.prefixes.hub_prefix}-rg"

  firewall_prefix = "firewall"
  vpn_prefix      = "vpn"


  hub_vnet_name          = "${local.prefixes.hub_prefix}-vnet"
  hub_address_space      = ["10.1.0.0/24"]
  hub_vnet_address_space = ["10.1.0.0/24"]
  hub_vnet_dns_servers   = ["10.1.0.4", "10.1.0.5"]

  firewall_subnet_address_prefixes = ["10.1.0.0/26"]

  gateway_subnet_address_prefixes = ["10.1.0.128/27"]

  log_workspace_name = "${local.prefixes.hub_prefix}-logs-workspace"
  log_workspace_sku  = "PerGB2018"

  hub_firewall_name        = "${local.prefixes.hub_prefix}-firewall"
  hub_firewall_policy_name = "${local.prefixes.hub_prefix}-firewall-policy"
  network_rules            = jsondecode(templatefile("./templates/rules/network_rules.json", {
    vpn_client_address_space = module.vpn.client_address_space
  })).rules

  vpn_client_address_space = ["192.168.0.0/24"]
  aad_tenant               = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_issuer               = "https://sts.windows.net/${var.tenant_id}/"
  audience_id              = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"

  virtual_gateway_name = "${local.prefixes.hub_prefix}-virtual-gateway"
  hub_routes           = jsondecode(templatefile("./templates/routes/hub_gateway_routes.json", {
    "destination_address_prefix" = azurerm_subnet.spoke_subnet.address_prefixes[0]
    "firewall_private_ip"        = module.firewall.private_ip
  })).hub_gateway_routes

  gateway_route_table_name = "firewall-route-table"
}

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
  depends_on           = [azurerm_virtual_network.hub_vnet]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = local.gateway_subnet_address_prefixes
  depends_on           = [azurerm_virtual_network.hub_vnet]
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
  prefix                     = local.firewall_prefix
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
  prefix               = local.vpn_prefix
  location             = azurerm_resource_group.hub.location
  resource_group_name  = azurerm_resource_group.hub.name
  vnet_name            = azurerm_virtual_network.hub_vnet.name
  subnet_id            = azurerm_subnet.gateway_subnet.id
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
  associated_subnet_id = azurerm_subnet.gateway_subnet.id
  depends_on           = [module.firewall, module.vpn]
}


