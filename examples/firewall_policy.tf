module "firewall_policy" {
  source                           = ".relative/path/to-file"
  location                         = "West US"
  policy_name                      = "policy"
  resource_group_name              = "rg_name"
  network_rule_collection_priority = 500
  network_rules                    = [
    {
      name                  = ["network_rule"]
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }]
  network_rule_action              = "Allow"
  nat_rule_collection_priority     = 100
  nat_rules                        = [{
    name                  = "nat_rule"
    protocols             = ["TCP, UDP"]
    source_addresses      = ["10.0.0.4"]
    destination_addresses = ["10.1.0.7"]
    destination_ports     = ["22"]
    translated_address    = "10.0.0.5"
    translated_port       = "22"
  }]
  application_rules                = {
    name              = "app_rule"
    protocols         = [{
      type = "Http"
      port = 80
    },
      {
        type = "Https"
        port = 443
      }]
    source_addresses  = ["10.0.0.1"]
    destination_fqdns = [".microsoft.com"]
  }
}
application_rule_action = "Deny"
}

