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