## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurem"></a> [azurem](#requirement\_azurem) | 2.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.spoke_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_subnet_id"></a> [associated\_subnet\_id](#input\_associated\_subnet\_id) | associated subnet id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | route table name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | n/a | <pre>list(object({<br>    name                       = string<br>    destination_address_prefix = string<br>    next_hop_type              = string<br>    next_hop_ip_address        = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
