## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.72.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | The host name of the vm. | `string` | `null` | no |
| <a name="input_is_linux"></a> [is\_linux](#input\_is\_linux) | Is the type of the vm is linux. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Nic's location. | `string` | n/a | yes |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of the os disk. | `string` | `"Standard_LRS"` | no |
| <a name="input_os_profile"></a> [os\_profile](#input\_os\_profile) | The profile of the admin user in the vm. | <pre>object({<br>    admin_username = string<br>    admin_password = string<br>  })</pre> | n/a | yes |
| <a name="input_private_ip_type"></a> [private\_ip\_type](#input\_private\_ip\_type) | Is the private ip address is Dynamic or Static. | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_storage_data_disks"></a> [storage\_data\_disks](#input\_storage\_data\_disks) | List of the vm's data disks. | <pre>list(object({<br>    managed_disk_type = string<br>    create_option     = string<br>    disk_size_gb      = string<br>  }))</pre> | `[]` | no |
| <a name="input_storage_image_reference"></a> [storage\_image\_reference](#input\_storage\_image\_reference) | Specifies the image from which the vm is created. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "16.04-LTS",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Nic's subnet id. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The virtual machine name. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the vm. | `string` | `"Standard_F2"` | no |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/2.72.0/docs/resources/virtual_machine) | resource |
## Usage
 ```hcl
module "ubuntu_vm_spoke" {
  vm_name             = "vm"
  source              = "./modules/vm"
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
