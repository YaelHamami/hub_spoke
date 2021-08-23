variable "subscription_id" {
  type        = string
  description = "The ID of the Subscription. Changing this forces a new Subscription to be created."
}

variable "location" {
  type        = string
  description = "The location of all the resources."
}

variable "admin_details" {
  type = object({
    admin_username = string
    admin_password = string
  })
  sensitive   = true
  description = "The login information of the admin user in the vm."
}

variable "tenant_id" {
  type        = string
  description = "The Azure Tenant ID."
}

variable "audience_id" {
  type        = string
  description = "The client id of the Azure VPN application. See Create an Active Directory (AD) tenant for P2S OpenVPN protocol connections for values."
}