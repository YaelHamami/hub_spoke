## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | The host name of the vm. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | All the resources location. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix of certain values in the vm module. | `string` | n/a | yes |
| <a name="input_private_ip_type"></a> [private\_ip\_type](#input\_private\_ip\_type) | Is the private ip address is Dynamic or Static. | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| <a name="input_storage_data_disks"></a> [storage\_data\_disks](#input\_storage\_data\_disks) | List of the vm's data disks. create\_option - (Required) Specifies how the data disk should be created. Possible values are Attach, FromImage and Empty. disk\_size\_gb - (Required) Specifies the size of the data disk in gigabytes.caching - (Optional) Specifies the caching requirements. | <pre>list(object({<br>    storage_account_type = string<br>    create_option        = string<br>    disk_size_gb         = string<br>  }))</pre> | `[]` | no |
| <a name="input_storage_image_reference"></a> [storage\_image\_reference](#input\_storage\_image\_reference) | This block provisions the Virtual Machine from one of two sources: an Azure Platform Image (e.g. Ubuntu/Windows Server) or a Custom Image. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "16.04-LTS",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Nic's subnet id. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The virtual machine name. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Specifies the size of the Virtual Machine. See also Azure VM Naming Conventions. | `string` | `"Standard_F2"` | no |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.vm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
## Usage
 ```hcl
module "ubuntu_vm_spoke" {
  source              = "./modules/vm"
  prefix              = local.vm_prefix
  vm_name             = "vm"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  subnet_id           = tolist(azurerm_virtual_network.spoke_vnet.subnet)[0].id
  os_profile          = {
    admin_username = "bob"
    admin_password = "Aa1234567890"
  }
  storage_data_disks  = [{
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    disk_size_gb      = "1023"
  },
    {
      managed_disk_type = "Standard_LRS"
      create_option     = "Empty"
      disk_size_gb      = "1023"
    }]
}
 ```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The vm id. |
| <a name="output_name"></a> [name](#output\_name) | The vm name |
| <a name="output_vm"></a> [vm](#output\_vm) | The full vm object. |
