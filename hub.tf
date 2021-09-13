locals {
  hub_prefix = "daniel-hub"

  hub_resource_group_name = "${local.hub_prefix}-rg"

  hub_vnet_name          = "${local.hub_prefix}-vnet"
  hub_address_space      = ["10.1.0.0/24"]
  hub_vnet_address_space = ["10.1.0.0/24"]

  firewall_subnet_address_prefixes = ["10.1.0.0/26"]

  gateway_subnet_address_prefixes = ["10.1.0.128/27"]

  log_workspace_name = "${local.hub_prefix}-logs-workspace"
  log_workspace_sku  = "PerGB2018"

  hub_firewall_name        = "${local.hub_prefix}-firewall"
  hub_firewall_policy_name = "${local.hub_prefix}-firewall-policy"
  network_rules = jsondecode(templatefile("./templates/rules/network_rules.json", {
    vpn_client_address_space = module.vpn.client_address_space
  })).rules

  vpn_client_address_space = ["192.168.0.0/24"]
  aad_tenant               = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_issuer               = "https://sts.windows.net/${var.tenant_id}/"
  audience_id              = var.audience

  virtual_gateway_name = "${local.hub_prefix}-virtual-gateway"
  hub_routes = jsondecode(templatefile("./templates/routes/hub_gateway.json", {
    "destination_address_prefix" = module.spoke_vnet.subnets.SpokeSubnet.address_prefix
    "firewall_private_ip"        = module.firewall.private_ip
  })).hub_gateway_routes

  hub_route_table_name = "${local.hub_prefix}-route-table"
  log_retention_in_days   = 30
}

resource "azurerm_resource_group" "hub" {
  name     = local.hub_resource_group_name
  location = local.location
}

module "hub_vnet" {
  source              = "./modules/vnet"
  resource_group_name = local.hub_resource_group_name
  name                = local.hub_vnet_name
  location            = local.location
  address_space       = local.hub_address_space
  subnets = [
    {
      name             = "AzureFirewallSubnet"
      address_prefixes = local.firewall_subnet_address_prefixes
    },
    {
      name             = "GatewaySubnet"
      address_prefixes = local.gateway_subnet_address_prefixes
    }
  ]
  depends_on = [azurerm_resource_group.hub]
}


resource "azurerm_log_analytics_workspace" "logs" {
  name                = local.log_workspace_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = local.log_workspace_sku
  retention_in_days   = local.log_retention_in_days
}

module "firewall" {
  source                     = "./modules/firewall"
  name                       = local.hub_firewall_name
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  firewall_subnet_id         = module.hub_vnet.subnets.AzureFirewallSubnet.id
  vnet_name                  = module.hub_vnet.name
  firewall_policy_name       = local.hub_firewall_policy_name
  network_rules              = local.network_rules
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  depends_on                 = [module.hub_vnet, azurerm_log_analytics_workspace.logs]
}


module "vpn" {
  source               = "./modules/vpn"
  location             = azurerm_resource_group.hub.location
  resource_group_name  = azurerm_resource_group.hub.name
  vnet_name            = module.hub_vnet.name
  subnet_id            = module.hub_vnet.subnets.GatewaySubnet.id
  client_address_space = local.vpn_client_address_space
  virtual_gateway_name = local.virtual_gateway_name
  aad_tenant           = local.aad_tenant
  aad_audience         = local.audience_id
  aad_issuer           = local.aad_issuer
  depends_on = [
    module.hub_vnet,
  ]
}

module "gateway_route_table" {
  source                 = "./modules/route_table"
  resource_group_name    = azurerm_resource_group.hub.name
  location               = azurerm_resource_group.hub.location
  route_table_name       = local.hub_route_table_name
  routes                 = local.hub_routes
  associated_subnets_ids = [module.hub_vnet.subnets.GatewaySubnet.id]
  depends_on             = [module.firewall, module.vpn]
}




