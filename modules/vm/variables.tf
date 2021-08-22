variable "vm_name" {
  type        = string
  description = "The virtual machine name."
  validation {
    condition     = length(var.vm_name) > 0 && length(var.vm_name) < 15
    error_message = "The vm name must be between 1 and 15 keys."
  }
}

variable "location" {
  type        = string
  description = "Nic's location."
}

variable "subnet_id" {
  type        = string
  description = "Nic's subnet id."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "private_ip_type" {
  type        = string
  default     = "Dynamic"
  description = "Is the private ip address is Dynamic or Static. "
}

variable "vm_size" {
  type        = string
  default     = "Standard_F2"
  description = "The size of the vm."
}

variable "os_profile" {
  type        = object({
    admin_username = string
    admin_password = string
  })
  description = "The profile of the admin user in the vm."
  sensitive   = true
}

variable "storage_data_disks" {
  type        = list(object({
    managed_disk_type = string
    create_option     = string
    disk_size_gb      = string
  }))
  default     = []
  description = "List of the vm's data disks."
}

variable "storage_image_reference" {
  type        = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default     = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  description = "Specifies the image from which the vm is created."
}

variable "os_disk_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The type of the os disk."
}

variable "computer_name" {
  type        = string
  description = "The host name of the vm."
  default     = null
}

variable "is_linux" {
  type = bool
  default = true
  description = "Is the type of the vm is linux."
}
