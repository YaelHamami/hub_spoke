## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the network security group is created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Network security group name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the network security group. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | This object represent a list of all the rules in the network security group. | <pre>list(object({<br>    name                         = string<br>    priority                     = number<br>    direction                    = string<br>    access                       = string<br>    protocol                     = string<br>    source_port_range            = optional(string)<br>    source_port_ranges           = optional(list(string))<br>    destination_port_range       = optional(string)<br>    destination_port_ranges      = optional(list(string))<br>    source_address_prefix        = optional(string)<br>    source_address_prefixes      = optional(list(string))<br>    destination_address_prefix   = optional(string)<br>    destination_address_prefixes = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_subnets_id"></a> [subnets\_id](#input\_subnets\_id) | All the subnets ids related to the network security group. | `list(string)` | n/a | yes |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
## Usage
 ```hcl
module "network_security_group" {
  source              = "./relative/path/to/file"
  location            = "West Europe"
  name                = "nsg"
  resource_group_name = "nsg-rg"
  security_rules      = [
    {
      name                       = "AllowInboundSSH"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_ranges         = ["5234","22"]
      destination_port_ranges    = ["22"]
      source_address_prefix      = "192.168.0.0/24"
      destination_address_prefix = "10.0.0.0/24"
    },
    {
      name                       = "DenyInbound"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
  subnets_id          = module.spoke_vnet.subnets_ids
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The network security group id. |
| <a name="output_name"></a> [name](#output\_name) | The network security group name. |
| <a name="output_object"></a> [object](#output\_object) | The full network security group object. |
