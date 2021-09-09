resource "azurerm_virtual_network_peering" "local_to_remote" {
  name                         = "${var.local_vnet_name}-to-${var.remote_vnet_name}"
  resource_group_name          = var.local_to_remote_resource_group_name
  virtual_network_name         = var.local_vnet_name
  remote_virtual_network_id    = var.remote_vnet_id
  allow_gateway_transit        = var.local_remote_allow_gateway_transit
  use_remote_gateways          = var.local_remote_use_remote_gateways
  allow_forwarded_traffic      = var.local_remote_allow_forwarded_traffic
  allow_virtual_network_access = var.local_remote_allow_virtual_network_access
}

resource "azurerm_virtual_network_peering" "hub_spoke_peering" {
  name                         = "${var.remote_vnet_name}-to-${var.local_vnet_name}"
  resource_group_name          = var.remote_local_resource_group_name
  virtual_network_name         = var.remote_vnet_name
  remote_virtual_network_id    = var.local_vnet_id
  allow_gateway_transit        = var.remote_local_allow_gateway_transit
  use_remote_gateways          = var.remote_local_use_remote_gateways
  allow_forwarded_traffic      = var.remote_local_allow_forwarded_traffic
  allow_virtual_network_access = var.remote_local_allow_virtual_network_access
}