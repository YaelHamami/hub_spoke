module "ubuntu_vm_spoke" {
  source                  = "relative/path/to-file"
  is_linux                = false
  vm_name                 = "vm"
  location                = azurerm_resource_group.spoke.location
  resource_group_name     = azurerm_resource_group.spoke.name
  subnet_id               = module.spoke_vnet.subnets.SpokeSubnet.id
  storage_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  admin_username          = "bob"
  admin_password          = "Aa1234567890"
  storage_data_disks      = [{
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