variable "location" {
  type        = string
  description = "The location/region where the network security group is created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "name" {
  type        = string
  description = "Network security group name."
}

variable "security_rules" {
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "subnets_id" {
  type        = set(string)
  description = "All the subnets ids related to the network security group."
}
