## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.rule_collection](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_name"></a> [application\_rule\_collection\_name](#input\_application\_rule\_collection\_name) | nat rule collection name | `string` | `null` | no |
| <a name="input_application_rule_collection_priority"></a> [application\_rule\_collection\_priority](#input\_application\_rule\_collection\_priority) | nat rule collection name | `number` | `null` | no |
| <a name="input_application_rules"></a> [application\_rules](#input\_application\_rules) | list of network rules | <pre>list(object({<br>    name              = string<br>    protocols         = list(object({<br>      type = string<br>      port = number<br>    }))<br>    source_addresses  = list(string)<br>    destination_fqdns = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | location name | `string` | n/a | yes |
| <a name="input_nat_rule_collection_name"></a> [nat\_rule\_collection\_name](#input\_nat\_rule\_collection\_name) | nat rule collection name | `string` | `null` | no |
| <a name="input_nat_rule_collection_priority"></a> [nat\_rule\_collection\_priority](#input\_nat\_rule\_collection\_priority) | nat rule collection name | `number` | `null` | no |
| <a name="input_nat_rules"></a> [nat\_rules](#input\_nat\_rules) | list of network rules | <pre>list(object({<br>    name                  = string<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>    translated_address    = string<br>    translated_port       = string<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection_name"></a> [network\_rule\_collection\_name](#input\_network\_rule\_collection\_name) | network rule collection name | `string` | `null` | no |
| <a name="input_network_rule_collection_priority"></a> [network\_rule\_collection\_priority](#input\_network\_rule\_collection\_priority) | network rule collection name | `number` | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | list of network rules | <pre>list(object({<br>    name                  = string<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_rule_collection_name"></a> [rule\_collection\_name](#input\_rule\_collection\_name) | rule collection name | `string` | n/a | yes |
| <a name="input_rule_collection_priority"></a> [rule\_collection\_priority](#input\_rule\_collection\_priority) | rule collection priority | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | n/a |
