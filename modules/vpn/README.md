## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_audience"></a> [aad\_audience](#input\_aad\_audience) | The client id of the Azure VPN application. See Create an Active Directory (AD) tenant for P2S OpenVPN protocol connections for values. | `string` | n/a | yes |
| <a name="input_aad_issuer"></a> [aad\_issuer](#input\_aad\_issuer) | https://sts.windows.net/{AzureAD TenantID}/ | `string` | n/a | yes |
| <a name="input_aad_tenant"></a> [aad\_tenant](#input\_aad\_tenant) | https://login.microsoftonline.com/{AzureAD TenantID} | `string` | n/a | yes |
| <a name="input_client_address_space"></a> [client\_address\_space](#input\_client\_address\_space) | The address space the client side uses while using the vpn connection. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location name. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix of certain values in the vpn module | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn\_type and generation arguments. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The id of the GatewaySubnet | `string` | n/a | yes |
| <a name="input_virtual_gateway_name"></a> [virtual\_gateway\_name](#input\_virtual\_gateway\_name) | The name of the Virtual Network Gateway. Changing the name forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of virtual network that contains the firewall. | `string` | n/a | yes |
| <a name="input_vpn_client_protocols"></a> [vpn\_client\_protocols](#input\_vpn\_client\_protocols) | List of the protocols supported by the vpn client. The supported values are SSTP, IkeV2 and OpenVPN. Values SSTP and IkeV2 are incompatible with the use of aad\_tenant, aad\_audience and aad\_issuer. | `list(string)` | <pre>[<br>  "OpenVPN"<br>]</pre> | no |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.vnet_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
## Usage
 ```hcl
module "vpn" {
  source                     = "./modules/vpn"
  prefix                     = local.vpn_prefix
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  vnet_name                  = azurerm_virtual_network.hub_vnet.name
  public_ip_name             = "gateway-public-ip"
  subnet_address_prefixes    = ["10.1.0.128/27"]
  client_address_space       = ["192.168.0.0/24"]
  virtual_gateway_name       = "virtual-gateway"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  aad_tenant                 = "https://login.microsoftonline.com/${var.tenant_id}"
  aad_audience               = var.audience_id
  aad_issuer                 = "https://sts.windows.net/${var.tenant_id}/"
  depends_on                 = [
    azurerm_virtual_network.hub_vnet,
  ]
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_address_space"></a> [client\_address\_space](#output\_client\_address\_space) | The address space the client uses to communicate with the other networks. |
| <a name="output_id"></a> [id](#output\_id) | The vpn gateway id. |
| <a name="output_name"></a> [name](#output\_name) | The vpn gateway name |
| <a name="output_vpn_gateway"></a> [vpn\_gateway](#output\_vpn\_gateway) | The full vpn gateway. |
