## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_action"></a> [application\_rule\_action](#input\_application\_rule\_action) | Application rule action. | `string` | `"Deny"` | no |
| <a name="input_application_rule_collection_priority"></a> [application\_rule\_collection\_priority](#input\_application\_rule\_collection\_priority) | Nat rule collection name. | `number` | `300` | no |
| <a name="input_application_rules"></a> [application\_rules](#input\_application\_rules) | List of application rules. | <pre>list(object({<br>    protocols         = list(object({<br>      type = string<br>      port = number<br>    }))<br>    source_addresses  = list(string)<br>    destination_fqdns = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Location name. | `string` | n/a | yes |
| <a name="input_nat_rule_collection_priority"></a> [nat\_rule\_collection\_priority](#input\_nat\_rule\_collection\_priority) | Nat rule collection name. | `number` | `100` | no |
| <a name="input_nat_rules"></a> [nat\_rules](#input\_nat\_rules) | List of nat rules. | <pre>list(object({<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>    translated_address    = string<br>    translated_port       = string<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_action"></a> [network\_rule\_action](#input\_network\_rule\_action) | Network rule action. | `string` | `"Allow"` | no |
| <a name="input_network_rule_collection_priority"></a> [network\_rule\_collection\_priority](#input\_network\_rule\_collection\_priority) | Network rule collection name. | `number` | `200` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | List of network rules. | <pre>list(object({<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>  }))</pre> | `[]` | no |
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
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the firewall policy. |
| <a name="output_policy"></a> [policy](#output\_policy) | The full firewall policy object. |
