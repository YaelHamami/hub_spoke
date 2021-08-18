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
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.GatewaySubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network_gateway.vnet_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience"></a> [aad\_audience](#input\_aad\_audience) | Application ID of the Azure\_VPN Azure AD Enterprise App | `string` | n/a | yes |
| <a name="input_aad_issuer"></a> [aad\_issuer](#input\_aad\_issuer) | https://sts.windows.net/{AzureAD TenantID}/ | `string` | n/a | yes |
| <a name="input_aad_tenant"></a> [aad\_tenant](#input\_aad\_tenant) | https://login.microsoftonline.com/{AzureAD TenantID} | `string` | n/a | yes |
| <a name="input_client_address_space"></a> [client\_address\_space](#input\_client\_address\_space) | n/a | `list(string)` | <pre>[<br>  "192.168.0.0/24"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | location name | `string` | n/a | yes |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | gateway public ip name | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | gateway sku | `string` | `"Standard"` | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | the address prefixes of the gateway subnet | `list(string)` | n/a | yes |
| <a name="input_virtual_gateway_name"></a> [virtual\_gateway\_name](#input\_virtual\_gateway\_name) | virtual gateway name | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | name of virtual network that contains the firewall | `string` | n/a | yes |
| <a name="input_vpn_client_protocols"></a> [vpn\_client\_protocols](#input\_vpn\_client\_protocols) | n/a | `list(string)` | <pre>[<br>  "OpenVPN"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_subnet_id"></a> [gateway\_subnet\_id](#output\_gateway\_subnet\_id) | n/a |
