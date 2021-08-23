## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_subnet_id"></a> [associated\_subnet\_id](#input\_associated\_subnet\_id) | The subnet id of the associated subnet. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of all the resources | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Route table name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | All the routes that go from the associated subnet out. | <pre>list(object({<br>    name                       = string<br>    destination_address_prefix = string<br>    next_hop_type              = string<br>    next_hop_ip_address        = optional(string)<br>  }))</pre> | n/a | yes |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.spoke_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
## Usage
 ```hcl
module "route_table" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location
  route_table_name     = "firewall-to-spoke-route-table"
  routes               = [{
    name                       = "firewall-to-spoke"
    destination_address_prefix = azurerm_virtual_network.spoke_vnet.address_space[0]
    next_hop_type              = "VirtualAppliance"
    next_hop_ip_address        = "module.firewall.private_ip"
  },]
  associated_subnet_id = module.vpn_connection.gateway_subnet_id
  depends_on           = [module.firewall, module.vpn_connection]
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The route table id. |
| <a name="output_name"></a> [name](#output\_name) | The route table name |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | The full route table object. |
