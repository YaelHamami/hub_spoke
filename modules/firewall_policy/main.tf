resource "azurerm_firewall_policy" "policy" {
  name                = var.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "rule_collection" {
  name               = var.rule_collection_name
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = var.rule_collection_priority

  dynamic network_rule_collection {
    for_each = length(var.network_rules) > 0 ? [1] : []
    content {
      name     = "network-rule-collection"
      priority = var.network_rule_collection_priority
      action   = var.network_rule_action
      dynamic "rule" {
        for_each = var.network_rules
        content {
          name                  = "network-rule-${rule.key + 1}"
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          destination_addresses = rule.value.destination_addresses
          destination_ports     = rule.value.destination_ports
        }
      }
    }
  }

  dynamic nat_rule_collection {
    for_each = length(var.nat_rules) > 0 ? [1] : []
    content {
      name     = "nat-rule-collection"
      priority = var.nat_rule_collection_priority
      action   = var.nat_rule_action

      dynamic "rule" {
        for_each = var.nat_rules
        content {
          name                = "nat-rule-${rule.key + 1}"
          protocols           = rule.value.protocols
          source_addresses    = rule.value.source_addresses
          destination_address = rule.value.destination_address
          destination_ports   = rule.value.destination_ports
          translated_address  = rule.value.translated_address
          translated_port     = rule.value.translated_port
        }
      }
    }
  }

  dynamic application_rule_collection {
    for_each = length(var.application_rules) > 0 ? [1] : []
    content {
      name     = "application-rule-collection"
      priority = var.application_rule_collection_priority
      action   = var.application_rule_action

      dynamic "rule" {
        for_each = var.application_rules
        content {
          name              = "application-rule-${rule.key + 1}"
          source_addresses  = rule.value.source_addresses
          destination_fqdns = rule.value.destination_fqdns

          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
        }
      }
    }
  }
}
