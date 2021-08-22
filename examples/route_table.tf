module "route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "firewall-to-spoke-route-table"
  routes               = [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = azurerm_virtual_network.spoke_vnet.address_space[0]
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = "module.firewall.private_ip"
  },]
  associated_subnet_id = module.vpn_connection.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn_connection]
}