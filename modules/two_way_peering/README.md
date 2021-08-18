## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.spoke_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet1_vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vnet1_id"></a> [vnet1\_id](#input\_vnet1\_id) | the id of the first vnet | `string` | n/a | yes |
| <a name="input_vnet1_name"></a> [vnet1\_name](#input\_vnet1\_name) | the name of the first vnet | `string` | n/a | yes |
| <a name="input_vnet1_vnet2_allow_forwarded_traffic"></a> [vnet1\_vnet2\_allow\_forwarded\_traffic](#input\_vnet1\_vnet2\_allow\_forwarded\_traffic) | does the peering from vnet 1 to vnet 2 allow\_forwarded\_traffic | `bool` | `true` | no |
| <a name="input_vnet1_vnet2_allow_gateway_transit"></a> [vnet1\_vnet2\_allow\_gateway\_transit](#input\_vnet1\_vnet2\_allow\_gateway\_transit) | does the peering from vnet 1 to vnet 2 allow gateway transit | `bool` | `false` | no |
| <a name="input_vnet1_vnet2_allow_virtual_network_access"></a> [vnet1\_vnet2\_allow\_virtual\_network\_access](#input\_vnet1\_vnet2\_allow\_virtual\_network\_access) | does the peering from vnet 1 to vnet 2 allow virtual network access | `bool` | `true` | no |
| <a name="input_vnet1_vnet2_name"></a> [vnet1\_vnet2\_name](#input\_vnet1\_vnet2\_name) | the name of the peering from vnet1 to vnet2 | `string` | n/a | yes |
| <a name="input_vnet1_vnet2_resource_group_name"></a> [vnet1\_vnet2\_resource\_group\_name](#input\_vnet1\_vnet2\_resource\_group\_name) | resource group name of the peering from vnet1 to vnet2 | `string` | n/a | yes |
| <a name="input_vnet1_vnet2_use_remote_gateways"></a> [vnet1\_vnet2\_use\_remote\_gateways](#input\_vnet1\_vnet2\_use\_remote\_gateways) | does the peering from vnet 1 to vnet 2 use remote gateways | `bool` | `false` | no |
| <a name="input_vnet2_id"></a> [vnet2\_id](#input\_vnet2\_id) | the id of the second vnet | `string` | n/a | yes |
| <a name="input_vnet2_name"></a> [vnet2\_name](#input\_vnet2\_name) | the name of the second vnet | `string` | n/a | yes |
| <a name="input_vnet2_vnet1_allow_forwarded_traffic"></a> [vnet2\_vnet1\_allow\_forwarded\_traffic](#input\_vnet2\_vnet1\_allow\_forwarded\_traffic) | does the peering from vnet2 to vnet1 allow\_forwarded\_traffic | `bool` | `true` | no |
| <a name="input_vnet2_vnet1_allow_gateway_transit"></a> [vnet2\_vnet1\_allow\_gateway\_transit](#input\_vnet2\_vnet1\_allow\_gateway\_transit) | does the peering from vnet2 to vnet1 allow gateway transit | `bool` | `false` | no |
| <a name="input_vnet2_vnet1_allow_virtual_network_access"></a> [vnet2\_vnet1\_allow\_virtual\_network\_access](#input\_vnet2\_vnet1\_allow\_virtual\_network\_access) | does the peering from vnet2 to vnet1 allow virtual network access | `bool` | `true` | no |
| <a name="input_vnet2_vnet1_name"></a> [vnet2\_vnet1\_name](#input\_vnet2\_vnet1\_name) | the name of the peering from vnet2 to vnet1 | `string` | n/a | yes |
| <a name="input_vnet2_vnet1_resource_group_name"></a> [vnet2\_vnet1\_resource\_group\_name](#input\_vnet2\_vnet1\_resource\_group\_name) | resource group name of the peering from vnet2 to vnet1 | `string` | n/a | yes |
| <a name="input_vnet2_vnet1_use_remote_gateways"></a> [vnet2\_vnet1\_use\_remote\_gateways](#input\_vnet2\_vnet1\_use\_remote\_gateways) | does the peering from vnet2 to vnet1 use remote gateways | `bool` | `false` | no |

## Outputs

No outputs.
