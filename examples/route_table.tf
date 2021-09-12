module "route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "firewall-to-spoke-route-table"
  routes               = [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = "10.0.0.0/24"
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = "module.firewall.private_ip"
  },]
  associated_subnets_ids = [module.hub_vnet.subnets.GatewaySubnet.id]
  depends_on           = [module.firewall, module.vpn_connection]
}