variable "tenant_id" {
  type = string
  description = "The value of the Azure Tenant ID."
  sensitive   = true
}

variable "subscription_id" {
  type = string
  description = "The value of the Azure Subscription ID."
  sensitive   = true
}

variable "admin_username" {
  type = string
  sensitive   = true
  description = "The login username of the admin user in the vm."
}

variable "admin_password" {
  type = string
  sensitive   = true
  description = "The login password of the admin user in the vm."
}

variable "spoke_vm_name" {
  type = string
  description = "The vm name"
}