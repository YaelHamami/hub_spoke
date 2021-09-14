module "policy" {
  source                             = "../modules/firewall_policy"
  location                           = "West Europe"
  policy_name                        = "my-firewall-policy"
  resource_group_name                = "hub"
  firewall_public_ip                 = "20.67.24.111"
  network_rule_collection_groups     = [
    {
      name             = "network_rule_collection_group"
      priority         = 200,
      rule_collections = [
        {
          name     = "first_rule_collection",
          priority = 200,
          action   = "Allow",
          rules    = [
            {
              name                  = "AllowAll",
              protocols             = [
                "ICMP",
                "TCP"
              ],
              source_addresses      = [
                "*"
              ],
              destination_addresses = [
                "*"
              ],
              destination_ports     = [
                "22"
              ]
            }
          ]
        }
      ]
    }
  ]
  application_rule_collection_groups = [
    {
      name             = "app_rule_collection_group",
      priority         = 300,
      rule_collections = [
        {
          name     = "apprulecoll",
          priority = 110,
          action   = "Deny",
          rules    = [
            {
              name              = "rule1",
              description       = "Deny inbound rule",
              protocols         = [
                {
                  type = "Https",
                  port = 443
                }
              ],
              destination_fqdns = [
                "www.test.com"
              ],
              source_addresses  = [
                "216.58.216.164",
                "10.0.0.0/24"
              ]
            }
          ]
        }
      ]
    }
  ]
  nat_rule_collection_group          = [
    {
      name             = "nat_rule_collection_group",
      priority         = 100,
      rule_collections = [
        {
          name     = "natrulecoll",
          priority = 112,
          action   = "Dnat",
          rules    = [
            {
              name               = "DNAT-HTTPS-traffic",
              description        = "D-NAT all outbound web traffic for inspection",
              source_addresses   = [
                "*"
              ],
              destination_ports  = [
                "443"
              ],
              protocols          = [
                "TCP"
              ],
              translated_address = "1.2.3.5",
              translated_port    = "8443"
            }
          ]
        }
      ]
    }
  ]
}

