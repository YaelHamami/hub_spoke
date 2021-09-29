resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_type
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.is_linux ? 1 : 0
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  network_interface_ids           = [azurerm_network_interface.nic.id,]
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  computer_name                   = var.computer_name != null ? var.computer_name : var.vm_name

  source_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.is_linux ? 0 : 1
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id,]
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  computer_name         = var.computer_name != null ? var.computer_name : var.vm_name

  source_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
}

resource "azurerm_managed_disk" "vm_managed_disk" {
  count                = length(var.storage_data_disks)
  name                 = "${var.vm_name}-datadisk${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_data_disks[count.index].storage_account_type
  create_option        = var.storage_data_disks[count.index].create_option
  disk_size_gb         = var.storage_data_disks[count.index].disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachment" {
  count              = length(var.storage_data_disks)
  managed_disk_id    = azurerm_managed_disk.vm_managed_disk[count.index].id
  virtual_machine_id = var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  lun                = count.index
  caching            = "ReadWrite"
}