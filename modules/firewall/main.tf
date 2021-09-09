resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "policy" {
  source                               = "../firewall_policy"
  location                             = var.location
  policy_name                          = var.firewall_policy_name
  resource_group_name                  = var.resource_group_name
  network_rule_collection_priority     = var.network_rule_collection_priority
  network_rules                        = var.network_rules
  network_rule_action                  = var.network_rule_action
  nat_rule_collection_priority         = var.nat_rule_collection_priority
  nat_rules                            = var.nat_rules
  application_rule_collection_priority = var.application_rule_collection_priority
  application_rules                    = var.application_rules
  application_rule_action              = var.application_rule_action
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = module.policy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = "${var.prefix}-diagnostic"
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AzureFirewallNetworkRule"
  }

  log {
    category = "AzureFirewallApplicationRule"
  }

  metric {
    category = "AllMetrics"
  }
}



