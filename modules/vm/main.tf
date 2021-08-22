locals {
  local_prefix = var.vm_name
}

resource "azurerm_network_interface" "nic" {
  name                = "${local.local_prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_type
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${local.local_prefix}-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  vm_size               = var.vm_size
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  storage_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }

 storage_os_disk {
      name              = "${local.local_prefix}_OsDisk"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = var.os_disk_type
  }

  dynamic storage_data_disk {
    for_each = var.storage_data_disks
    content {
      name              = "storage-data-disk${storage_data_disk.key + 1}"
      managed_disk_type = storage_data_disk.value.managed_disk_type
      create_option     = storage_data_disk.value.create_option
      lun               = storage_data_disk.key
      disk_size_gb      = storage_data_disk.value.disk_size_gb
    }
  }

  os_profile {
    computer_name  = var.computer_name != null ? var.computer_name : var.vm_name
    admin_username = var.os_profile.admin_username
    admin_password = var.os_profile.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = var.is_linux ? false : null
  }

//  os_profile_windows_config {
//    disable_password_authentication = !(var.is_linux) ? false : null
//  }
}