## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_groups"></a> [application\_rule\_collection\_groups](#input\_application\_rule\_collection\_groups) | This object is a list of all the application rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name              = string<br>        protocols         = list(object({<br>          type = string<br>          port = number<br>        }))<br>        source_addresses  = list(string)<br>        destination_fqdns = list(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Location name. | `string` | n/a | yes |
| <a name="input_nat_rule_collection_group"></a> [nat\_rule\_collection\_group](#input\_nat\_rule\_collection\_group) | This object is a list of all the nat rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name                = string<br>        protocols           = list(string)<br>        source_addresses    = list(string)<br>        destination_address = string<br>        destination_ports   = list(string)<br>        translated_address  = string<br>        translated_port     = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection_groups"></a> [network\_rule\_collection\_groups](#input\_network\_rule\_collection\_groups) | This object is a list of all the network rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | policy name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.application_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_firewall_policy_rule_collection_group.nat_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_firewall_policy_rule_collection_group.network_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |
## Usage
 ```hcl
module "policy" {
  source                             = "relative/path/to-file"
  location                           = "West Europe"
  policy_name                        = "my-firewall-policy"
  resource_group_name                = "hub"
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
              name                = "DNAT-HTTPS-traffic",
              description         = "D-NAT all outbound web traffic for inspection",
              source_addresses    = [
                "*"
              ],
              destination_address = "10.1.0.4",
              destination_ports   = [
                "443"
              ],
              protocols           = [
                "TCP"
              ],
              translated_address  = "1.2.3.5",
              translated_port     = "8443"
            }
          ]
        }
      ]
    }
  ]
}


 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the firewall policy. |
| <a name="output_object"></a> [object](#output\_object) | The full firewall policy object. |
