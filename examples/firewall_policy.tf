module "firewall_policy" {
  source                           = ".relative/path/to-file"
  location                         = "West US"
  policy_name                      = "policy"
  resource_group_name              = "rg_name"
  rule_collection_name             = "rule_collection"
  rule_collection_priority         = 400
  network_rule_collection_priority = 500
  network_rules                    = [
    {
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }]
  network_rule_action              = "Allow"
}