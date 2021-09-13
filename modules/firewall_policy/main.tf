resource "azurerm_firewall_policy" "policy" {
  name                = var.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "network_rule_collection_group" {
  for_each           = {for group in var.network_rule_collection_groups: group.name => group}
  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = each.value.priority

  dynamic network_rule_collection {
    for_each = each.value.rule_collections
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action
      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          destination_addresses = rule.value.destination_addresses
          destination_ports     = rule.value.destination_ports
        }
      }
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "nat_rule_collection_group" {
  for_each           = {for group in var.nat_rule_collection_group: group.name => group}
  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = each.value.priority

  dynamic nat_rule_collection {
    for_each = each.value.rule_collections
    content {
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = nat_rule_collection.value.rules
        content {
          name                = rule.value.name
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
}


resource "azurerm_firewall_policy_rule_collection_group" "application_rule_collection_group" {
  for_each           = {for group in var.application_rule_collection_groups: group.name => group}
  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = each.value.priority

  dynamic application_rule_collection {
    for_each = each.value.rule_collections
    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action
      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name              = rule.value.name
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
