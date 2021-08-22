## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | firewall address prefixes | `list(string)` | n/a | yes |
| <a name="input_application_rule_action"></a> [application\_rule\_action](#input\_application\_rule\_action) | Application rule action. | `string` | `"Deny"` | no |
| <a name="input_application_rule_collection_priority"></a> [application\_rule\_collection\_priority](#input\_application\_rule\_collection\_priority) | nat rule collection name | `number` | `300` | no |
| <a name="input_application_rules"></a> [application\_rules](#input\_application\_rules) | list of network rules | <pre>list(object({<br>    name              = string<br>    protocols         = list(object({<br>      type = string<br>      port = number<br>    }))<br>    source_addresses  = list(string)<br>    destination_fqdns = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | firewall name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location name | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log analytics workspace id. | `string` | n/a | yes |
| <a name="input_nat_rule_action"></a> [nat\_rule\_action](#input\_nat\_rule\_action) | Nat rule action. | `string` | `"Allow"` | no |
| <a name="input_nat_rule_collection_priority"></a> [nat\_rule\_collection\_priority](#input\_nat\_rule\_collection\_priority) | nat rule collection name | `number` | `100` | no |
| <a name="input_nat_rules"></a> [nat\_rules](#input\_nat\_rules) | list of network rules | <pre>list(object({<br>    name                  = string<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>    translated_address    = string<br>    translated_port       = string<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_action"></a> [network\_rule\_action](#input\_network\_rule\_action) | Network rule action. | `string` | `"Allow"` | no |
| <a name="input_network_rule_collection_priority"></a> [network\_rule\_collection\_priority](#input\_network\_rule\_collection\_priority) | network rule collection name | `number` | `200` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | list of network rules | <pre>list(object({<br>    protocols             = list(string)<br>    source_addresses      = list(string)<br>    destination_addresses = list(string)<br>    destination_ports     = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | policy name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_rule_collection_name"></a> [rule\_collection\_name](#input\_rule\_collection\_name) | rule collection name | `string` | n/a | yes |
| <a name="input_rule_collection_priority"></a> [rule\_collection\_priority](#input\_rule\_collection\_priority) | rule collection priority | `number` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | name of virtual network that contains the firewall | `string` | n/a | yes |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy"></a> [policy](#module\_policy) | ../firewall_policy | n/a |
## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/firewall) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.firewall_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/public_ip) | resource |
| [azurerm_subnet.azure_firewall_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/subnet) | resource |
## Usage
 ```hcl
module "firewall" {
  source                     = "relative/path/to-file"
  firewall_name              = "firewall"
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  address_prefixes           = ["10.1.0.0/26"]
  policy_name                = "firewall-policy"
  rule_collection_name       = "rule-collection"
  rule_collection_priority   = 400
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  depends_on                 = [azurerm_virtual_network.hub_vnet]
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall"></a> [firewall](#output\_firewall) | The full firewall object. |
| <a name="output_id"></a> [id](#output\_id) | The firewall id. |
| <a name="output_name"></a> [name](#output\_name) | The firewall name. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private ip address of the firewall. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public ip address of the firewall. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The id of the subnet that contains the firewall. |
