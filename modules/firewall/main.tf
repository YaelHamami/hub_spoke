resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "${var.name}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "policy" {
  source                             = "../firewall_policy"
  location                           = var.location
  policy_name                        = var.firewall_policy_name
  resource_group_name                = var.resource_group_name
  network_rule_collection_groups     = var.network_rule_collection_groups
  application_rule_collection_groups = var.application_rule_collection_groups
  nat_rule_collection_group          = var.nat_rule_collection_group
}

resource "azurerm_firewall" "firewall" {
  name                = var.name
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
  name                       = "${var.name}-diagnostic"
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AzureFirewallNetworkRule"
  }

  log {
    category = "AzureFirewallApplicationRule"
  }

  log {
    category = "AzureFirewallDnsProxy"
  }

  metric {
    category = "AllMetrics"
  }
}



