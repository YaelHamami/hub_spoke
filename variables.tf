variable "tenant_id" {
  type        = string
  description = "The value of the Azure Tenant ID."
  sensitive   = true
}

variable "audience" {
  type        = string
  description = "The client id of the Azure VPN application. See Create an Active Directory (AD) tenant for P2S OpenVPN protocol connections for values This setting is incompatible with the use of root_certificate and revoked_certificate, radius_server_address, and radius_server_secret."
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "The value of the Azure Subscription ID."
  sensitive   = true
}

variable "admin_username" {
  type        = string
  sensitive   = true
  description = "The login username of the admin user in the vm."
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "The login password of the admin user in the vm."
}

variable "spoke_vm_name" {
  type        = string
  description = "The vm name."
}

