## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of IP addresses of DNS servers | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Vnet name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | All subnets related to the vnet. | <pre>list(object({<br>    name             = string<br>    address_prefixes = list(string)<br>  }))</pre> | n/a | yes |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
## Usage
 ```hcl
module "hub_vnet" {
  source              = "relative/path/to-file"
  resource_group_name = local.hub_resource_group_name
  name                = local.hub_vnet_name
  location            = local.location
  address_space       = ["10.1.0.0/24"]
  subnets = [
    {
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.1.0.0/26"]
    },
    {
      name             = "GatewaySubnet"
      address_prefixes = ["10.1.0.128/27"]
    }
  ]
  depends_on = [azurerm_resource_group.hub]
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The vnet id. |
| <a name="output_name"></a> [name](#output\_name) | The vnet name. |
| <a name="output_object"></a> [object](#output\_object) | The full vnet object. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | All the subnets associated with the vnet. |
| <a name="output_subnets_ids"></a> [subnets\_ids](#output\_subnets\_ids) | The ids of all the subnets associated with the vnet. |
