resource "azurerm_virtual_network_peering" "vnet1_vnet2" {
  name                         = var.vnet1_vnet2_name
  resource_group_name          = var.vnet1_vnet2_resource_group_name
  virtual_network_name         = var.vnet1_name
  remote_virtual_network_id    = var.vnet2_id
  allow_gateway_transit        = var.vnet1_vnet2_allow_gateway_transit
  use_remote_gateways          = var.vnet1_vnet2_use_remote_gateways
  allow_forwarded_traffic      = var.vnet1_vnet2_allow_forwarded_traffic
  allow_virtual_network_access = var.vnet1_vnet2_allow_virtual_network_access
}

resource "azurerm_virtual_network_peering" "spoke_hub" {
  name                         = var.vnet2_vnet1_name
  resource_group_name          = var.vnet2_vnet1_resource_group_name
  virtual_network_name         = var.vnet2_name
  remote_virtual_network_id    = var.vnet1_id
  allow_gateway_transit        = var.vnet2_vnet1_allow_gateway_transit
  use_remote_gateways          = var.vnet2_vnet1_use_remote_gateways
  allow_forwarded_traffic      = var.vnet2_vnet1_allow_forwarded_traffic
  allow_virtual_network_access = var.vnet2_vnet1_allow_virtual_network_access
}