module "firewall" {
  source                     = "relative/path/to-file"
  prefix                     = local.firewall
  firewall_name              = "firewall"
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  address_prefixes           = ["10.1.0.0/26"]
  policy_name                = "firewall-policy"
  rule_collection_name       = "rule-collection"
  rule_collection_priority   = 400
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  depends_on                 = [azurerm_virtual_network.hub_vnet]
}