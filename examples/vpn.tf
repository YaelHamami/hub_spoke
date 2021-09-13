module "vpn" {
  source               = "relative/path/to-file"
  location             = azurerm_resource_group.hub.location
  resource_group_name  = azurerm_resource_group.hub.name
  vnet_name            = azurerm_virtual_network.hub_vnet.name
  subnet_id            = module.hub_vnet.subnets.GatewaySubnet.id
  client_address_space = ["192.168.0.0/24"]
  virtual_gateway_name = "virtual-gateway"
  aad_tenant           = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_audience         = var.audience_id
  aad_issuer           = "https://sts.windows.net/${var.tenant_id}/"
  depends_on           = [
    azurerm_virtual_network.hub_vnet,
  ]
}