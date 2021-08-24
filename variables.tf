variable "admin_details" {
  type = object({
    admin_username = string
    admin_password = string
  })
  sensitive   = true
  description = "The login information of the admin user in the vm."
}