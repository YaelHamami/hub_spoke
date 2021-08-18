## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_firewall_to_spoke"></a> [firewall\_to\_spoke](#module\_firewall\_to\_spoke) | ./modules/route_table | n/a |
| <a name="module_spoke_out"></a> [spoke\_out](#module\_spoke\_out) | ./modules/route_table | n/a |
| <a name="module_ubuntu_vm_spoke"></a> [ubuntu\_vm\_spoke](#module\_ubuntu\_vm\_spoke) | ./modules/ubuntu_vm | n/a |
| <a name="module_v1_v2_two_way_peering"></a> [v1\_v2\_two\_way\_peering](#module\_v1\_v2\_two\_way\_peering) | ./modules/two_way_peering | n/a |
| <a name="module_vpn_connection"></a> [vpn\_connection](#module\_vpn\_connection) | ./modules/vpn_connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.firewall_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.hub_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_name"></a> [application\_rule\_collection\_name](#input\_application\_rule\_collection\_name) | nat rule collection name | `string` | `""` | no |
| <a name="input_application_rule_collection_priority"></a> [application\_rule\_collection\_priority](#input\_application\_rule\_collection\_priority) | nat rule collection name | `number` | `700` | no |
| <a name="input_application_rules"></a> [application\_rules](#input\_application\_rules) | list of network rules | <pre>list(object({<br>    name = string<br>    protocols = list(object({<br>      type = string<br>      port = number<br>    }))<br>    source_addresses  = list(string)<br>    destination_fqdns = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_nat_rule_collection_name"></a> [nat\_rule\_collection\_name](#input\_nat\_rule\_collection\_name) | nat rule collection name | `string` | `""` | no |
| <a name="input_nat_rule_collection_priority"></a> [nat\_rule\_collection\_priority](#input\_nat\_rule\_collection\_priority) | nat rule collection name | `number` | `700` | no |
| <a name="input_nat_rules"></a> [nat\_rules](#input\_nat\_rules) | list of network rules | <pre>list(object({<br>    name                  = string<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>    translated_address    = string<br>    translated_port       = string<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection_name"></a> [network\_rule\_collection\_name](#input\_network\_rule\_collection\_name) | network rule collection name | `string` | n/a | yes |
| <a name="input_network_rule_collection_priority"></a> [network\_rule\_collection\_priority](#input\_network\_rule\_collection\_priority) | network rule collection name | `number` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | list of network rules | <pre>list(object({<br>    name                  = string<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | subscription ID | `string` | n/a | yes |

## Outputs

No outputs.
