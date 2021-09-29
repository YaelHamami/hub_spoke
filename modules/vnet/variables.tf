variable "location" {
  type        = string
  description = "The location/region where the virtual network is created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "name" {
  type        = string
  description = "Vnet name."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space."
}

variable "dns_servers" {
  type        = list(string)
  default     = null
  description = "(Optional) List of IP addresses of DNS servers"
}

variable "subnets" {
  type        = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  description = "All subnets related to the vnet."
}
