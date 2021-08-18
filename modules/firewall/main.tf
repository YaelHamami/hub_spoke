resource "azurerm_subnet" "azure_firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "firewall-public-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "policy" {
  source                               = "./../policy"
  location                             = var.location
  policy_name                          = var.policy_name
  rg_name                              = var.rg_name
  rule_collection_name                 = var.rule_collection_name
  rule_collection_priority             = var.rule_collection_priority
  network_rule_collection_name         = var.network_rule_collection_name
  network_rule_collection_priority     = var.network_rule_collection_priority
  network_rules                        = var.network_rules
  nat_rule_collection_name             = var.nat_rule_collection_name
  nat_rule_collection_priority         = var.nat_rule_collection_priority
  nat_rules                            = var.nat_rules
  application_rule_collection_name     = var.application_rule_collection_name
  application_rule_collection_priority = var.application_rule_collection_priority
  application_rules                    = var.application_rules
}

resource "azurerm_firewall" "firewall" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.rg_name
  firewall_policy_id  = module.policy.policy_id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azure_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = "firewall-diagnostic"
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AzureFirewallNetworkRule"
  }

  log{
    category = "AzureFirewallApplicationRule"
  }

  metric {
    category = "AllMetrics"
  }
}




