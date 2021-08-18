## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_firewall_to_spoke"></a> [firewall\_to\_spoke](#module\_firewall\_to\_spoke) | ./modules/route_table | n/a |
| <a name="module_local_remote_peering"></a> [local\_remote\_peering](#module\_local\_remote\_peering) | ./modules/two_way_peering | n/a |
| <a name="module_spoke_out"></a> [spoke\_out](#module\_spoke\_out) | ./modules/route_table | n/a |
| <a name="module_ubuntu_vm_spoke"></a> [ubuntu\_vm\_spoke](#module\_ubuntu\_vm\_spoke) | ./modules/ubuntu_vm | n/a |
| <a name="module_vpn_connection"></a> [vpn\_connection](#module\_vpn\_connection) | ./modules/vpn_connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.firewall_logs](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.hub_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | subscription ID | `string` | n/a | yes |

## Outputs

No outputs.
