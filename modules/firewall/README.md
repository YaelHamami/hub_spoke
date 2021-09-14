## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_groups"></a> [application\_rule\_collection\_groups](#input\_application\_rule\_collection\_groups) | This object is a list of all the application rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name              = string<br>        protocols         = list(object({<br>          type = string<br>          port = number<br>        }))<br>        source_addresses  = list(string)<br>        destination_fqdns = list(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | Policy name. | `string` | n/a | yes |
| <a name="input_firewall_subnet_id"></a> [firewall\_subnet\_id](#input\_firewall\_subnet\_id) | The id of the AzureFirewallSubnet. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of all the resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log analytics workspace id. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Firewall name. | `string` | n/a | yes |
| <a name="input_nat_rule_collection_group"></a> [nat\_rule\_collection\_group](#input\_nat\_rule\_collection\_group) | This object is a list of all the nat rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name                = string<br>        protocols           = list(string)<br>        source_addresses    = list(string)<br>        destination_ports   = list(string)<br>        translated_address  = string<br>        translated_port     = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection_groups"></a> [network\_rule\_collection\_groups](#input\_network\_rule\_collection\_groups) | This object is a list of all the network rule collection groups associated with the firewall policy. | <pre>list(object({<br>    name             = string<br>    priority         = number<br>    rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br>      rules    = list(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of virtual network that contains the firewall. | `string` | n/a | yes |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy"></a> [policy](#module\_policy) | ../firewall_policy | n/a |
## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.firewall_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
## Usage
 ```hcl
module "firewall" {
  source                             = "relative/path/to-file"
  name                               = "firewall"
  location                           = azurerm_resource_group.hub.location
  resource_group_name                = azurerm_resource_group.hub.name
  firewall_subnet_id                 = module.hub_vnet.subnets.AzureFirewallSubnet.id
  vnet_name                          = azurerm_virtual_network.hub_vnet.name
  firewall_policy_name               = "firewall-policy"
  network_rule_collection_groups     = local.network_rule_collection_group
  application_rule_collection_groups = local.application_rule_collection_group
  nat_rule_collection_group          = local.nat_rule_collection_group
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.logs.id
  depends_on                         = [module.hub_vnet, azurerm_log_analytics_workspace.logs]
}

 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The firewall id. |
| <a name="output_name"></a> [name](#output\_name) | The firewall name. |
| <a name="output_object"></a> [object](#output\_object) | The full firewall object. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private ip address of the firewall. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public ip address of the firewall. |
