module "vpn" {
  source                     = "./modules/vpn"
  prefix                     = local.vpn_prefix
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  public_ip_name             = "gateway-public-ip"
  subnet_address_prefixes    = ["10.1.0.128/27"]
  client_address_space       = ["192.168.0.0/24"]
  virtual_gateway_name       = "virtual-gateway"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  aad_tenant                 = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_audience               = var.audience_id
  aad_issuer                 = "https://sts.windows.net/${var.tenant_id}/"
  depends_on                 = [
    azurerm_virtual_network.hub_vnet,
  ]
}