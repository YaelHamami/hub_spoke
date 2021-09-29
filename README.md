## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The login password of the admin user in the vm. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The login username of the admin user in the vm. | `string` | n/a | yes |
| <a name="input_audience"></a> [audience](#input\_audience) | The client id of the Azure VPN application. See Create an Active Directory (AD) tenant for P2S OpenVPN protocol connections for values This setting is incompatible with the use of root\_certificate and revoked\_certificate, radius\_server\_address, and radius\_server\_secret. | `string` | n/a | yes |
| <a name="input_spoke_vm_name"></a> [spoke\_vm\_name](#input\_spoke\_vm\_name) | The vm name. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The value of the Azure Subscription ID. | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The value of the Azure Tenant ID. | `string` | n/a | yes |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_gateway_route_table"></a> [gateway\_route\_table](#module\_gateway\_route\_table) | ./modules/route_table | n/a |
| <a name="module_hub_spoke_two_way_peering"></a> [hub\_spoke\_two\_way\_peering](#module\_hub\_spoke\_two\_way\_peering) | ./modules/vnet_two_way_peering | n/a |
| <a name="module_hub_vnet"></a> [hub\_vnet](#module\_hub\_vnet) | ./modules/vnet | n/a |
| <a name="module_network_security_group"></a> [network\_security\_group](#module\_network\_security\_group) | ./modules/network_security_group | n/a |
| <a name="module_spoke_route_table"></a> [spoke\_route\_table](#module\_spoke\_route\_table) | ./modules/route_table | n/a |
| <a name="module_spoke_vnet"></a> [spoke\_vnet](#module\_spoke\_vnet) | ./modules/vnet | n/a |
| <a name="module_ubuntu_vm_spoke"></a> [ubuntu\_vm\_spoke](#module\_ubuntu\_vm\_spoke) | ./modules/vm | n/a |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | ./modules/vpn | n/a |
## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
## Outputs

No outputs.
