variable "subscription_id" {
  type        = string
  description = "Subscription ID."
}

variable "location" {
  type = string
  description = "The location of all the resources."
}

variable "admin_details" {
  type      = object({
    admin_username = string
    admin_password = string
  })
  sensitive = true
  description = "The login information of the admin user in the vm."
}

variable "tenant_id" {
  type = string
  description = "The tenant id."
}

variable "audience_id" {
  type = string
  description = "The audience id."
}