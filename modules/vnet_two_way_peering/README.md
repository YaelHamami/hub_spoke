## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_remote_allow_forwarded_traffic"></a> [local\_remote\_allow\_forwarded\_traffic](#input\_local\_remote\_allow\_forwarded\_traffic) | Does the peering from the local vnet to the remote vnet allow\_forwarded\_traffic. | `bool` | `true` | no |
| <a name="input_local_remote_allow_gateway_transit"></a> [local\_remote\_allow\_gateway\_transit](#input\_local\_remote\_allow\_gateway\_transit) | Does the peering from the local to the remote vnet allow gateway transit. | `bool` | `false` | no |
| <a name="input_local_remote_allow_virtual_network_access"></a> [local\_remote\_allow\_virtual\_network\_access](#input\_local\_remote\_allow\_virtual\_network\_access) | Does the peering from the local to the remote vnet allow virtual network access. | `bool` | `true` | no |
| <a name="input_local_remote_use_remote_gateways"></a> [local\_remote\_use\_remote\_gateways](#input\_local\_remote\_use\_remote\_gateways) | Does the peering of the local vnet to the remote vnet remote use's remote gateways. | `bool` | `false` | no |
| <a name="input_local_to_remote_resource_group_name"></a> [local\_to\_remote\_resource\_group\_name](#input\_local\_to\_remote\_resource\_group\_name) | Resource group name of the peering from local to remote. | `string` | n/a | yes |
| <a name="input_local_vnet_id"></a> [local\_vnet\_id](#input\_local\_vnet\_id) | The id of the local vnet. | `string` | n/a | yes |
| <a name="input_local_vnet_name"></a> [local\_vnet\_name](#input\_local\_vnet\_name) | The name of the local vnet. | `string` | n/a | yes |
| <a name="input_remote_local_allow_forwarded_traffic"></a> [remote\_local\_allow\_forwarded\_traffic](#input\_remote\_local\_allow\_forwarded\_traffic) | Does the peering from remote to local allow forwarded traffic. | `bool` | `true` | no |
| <a name="input_remote_local_allow_gateway_transit"></a> [remote\_local\_allow\_gateway\_transit](#input\_remote\_local\_allow\_gateway\_transit) | Does the peering from remote to local allow gateway transit. | `bool` | `false` | no |
| <a name="input_remote_local_allow_virtual_network_access"></a> [remote\_local\_allow\_virtual\_network\_access](#input\_remote\_local\_allow\_virtual\_network\_access) | Does the peering from remote to local allow virtual network access. | `bool` | `true` | no |
| <a name="input_remote_local_resource_group_name"></a> [remote\_local\_resource\_group\_name](#input\_remote\_local\_resource\_group\_name) | Resource group name of the peering from remote to local. | `string` | n/a | yes |
| <a name="input_remote_local_use_remote_gateways"></a> [remote\_local\_use\_remote\_gateways](#input\_remote\_local\_use\_remote\_gateways) | Does the peering from remote to local use remote gateways. | `bool` | `false` | no |
| <a name="input_remote_vnet_id"></a> [remote\_vnet\_id](#input\_remote\_vnet\_id) | The id of the remote vnet. | `string` | n/a | yes |
| <a name="input_remote_vnet_name"></a> [remote\_vnet\_name](#input\_remote\_vnet\_name) | The name of the second vnet. | `string` | n/a | yes |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.hub_spoke_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.local_to_remote](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
## Usage
 ```hcl
module "local_remote_peering" {
  source                              = "./modules/two_way_peering"
  local_network_name                  = azurerm_virtual_network.hub_vnet.name
  local_vnet_id                       = azurerm_virtual_network.hub_vnet.id
  local_to_remote_name                = "${local.prefixes.hub_prefix}-local-to-remote-peering"
  local_to_remote_resource_group_name = azurerm_virtual_network.hub_vnet.resource_group_name
  local_remote_allow_gateway_transit  = true
  remote_vnet_name                    = azurerm_virtual_network.spoke_vnet.name
  remote_vnet_id                      = azurerm_virtual_network.spoke_vnet.id
  remote_to_local_name                = "${local.prefixes.hub_prefix}-remote-to-local-peering"
  remote_local_resource_group_name    = azurerm_virtual_network.spoke_vnet.resource_group_name
  remote_local_use_remote_gateways    = true
  depends_on                          = [
    azurerm_virtual_network.hub_vnet,
    azurerm_virtual_network.spoke_vnet,
    module.vpn_connection]
}

 ```
## Outputs

No outputs.
