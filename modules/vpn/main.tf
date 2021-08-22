resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnet_gateway" {
  name                = var.virtual_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = var.sku

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
  }

  vpn_client_configuration {
    address_space        = var.client_address_space
    aad_audience         = var.aad_audience
    aad_issuer           = var.aad_issuer
    aad_tenant           = var.aad_tenant
    vpn_client_protocols = var.vpn_client_protocols
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = "vpn-diagnostic"
  target_resource_id         = azurerm_virtual_network_gateway.vnet_gateway.id
  log_analytics_workspace_id = var.log_analytics_workspace_id



  metric {
    category = "AllMetrics"
  }
}