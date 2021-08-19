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
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/public_ip) | resource |
| [azurerm_subnet.GatewaySubnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network_gateway.vnet_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience"></a> [aad\_audience](#input\_aad\_audience) | Application ID of the Azure\_VPN Azure AD Enterprise App | `string` | n/a | yes |
| <a name="input_aad_issuer"></a> [aad\_issuer](#input\_aad\_issuer) | https://sts.windows.net/{AzureAD TenantID}/ | `string` | n/a | yes |
| <a name="input_aad_tenant"></a> [aad\_tenant](#input\_aad\_tenant) | https://login.microsoftonline.com/{AzureAD TenantID} | `string` | n/a | yes |
| <a name="input_client_address_space"></a> [client\_address\_space](#input\_client\_address\_space) | the address space the client side use while using the vpn connection | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location name | `string` | n/a | yes |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | gateway public ip name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | gateway sku | `string` | `"Standard"` | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | the address prefixes of the gateway subnet | `list(string)` | n/a | yes |
| <a name="input_virtual_gateway_name"></a> [virtual\_gateway\_name](#input\_virtual\_gateway\_name) | virtual gateway name | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | name of virtual network that contains the firewall | `string` | n/a | yes |
| <a name="input_vpn_client_protocols"></a> [vpn\_client\_protocols](#input\_vpn\_client\_protocols) | the protocol used for the vpn connection | `list(string)` | <pre>[<br>  "OpenVPN"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_address_space"></a> [client\_address\_space](#output\_client\_address\_space) | the address space the client uses to communicate with the other networks |
| <a name="output_gateway_subnet_id"></a> [gateway\_subnet\_id](#output\_gateway\_subnet\_id) | the id of the subnet that contains the gateway |
