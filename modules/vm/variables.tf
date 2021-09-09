variable "prefix" {
  type = string
  description = "The prefix of certain values in the vm module."
}

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
  description = "All the resources location."
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
  description = "Specifies the size of the Virtual Machine. See also Azure VM Naming Conventions."
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  sensitive   = true
}

variable "storage_data_disks" {
  type        = list(object({
    storage_account_type = string
    create_option        = string
    disk_size_gb         = string
  }))
  default     = []
  description = "List of the vm's data disks. create_option - (Required) Specifies how the data disk should be created. Possible values are Attach, FromImage and Empty. disk_size_gb - (Required) Specifies the size of the data disk in gigabytes.caching - (Optional) Specifies the caching requirements."
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
  description = "This block provisions the Virtual Machine from one of two sources: an Azure Platform Image (e.g. Ubuntu/Windows Server) or a Custom Image."
}

variable "storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
}

variable "computer_name" {
  type        = string
  description = "The host name of the vm."
  default     = null
}

