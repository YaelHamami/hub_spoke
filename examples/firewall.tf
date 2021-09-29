module "firewall" {
  source                             = "relative/path/to-file"
  name                               = "firewall"
  location                           = azurerm_resource_group.hub.location
  resource_group_name                = azurerm_resource_group.hub.name
  firewall_subnet_id                 = module.hub_vnet.subnets.AzureFirewallSubnet.id
  vnet_name                          = azurerm_virtual_network.hub_vnet.name
  firewall_policy_name               = "firewall-policy"
  network_rule_collection_groups     = local.network_rule_collection_group
  application_rule_collection_groups = local.application_rule_collection_group
  nat_rule_collection_group          = local.nat_rule_collection_group
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.logs.id
  depends_on                         = [module.hub_vnet, azurerm_log_analytics_workspace.logs]
}
