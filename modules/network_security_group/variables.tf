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
  type        = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  description = "This object represent a list of all the rules in the network security group. The object must contain a value for one field in the optional pair, for example if source_address_prefix was given a value than, the destination_port_ranges must not get a value and vice versa"
}

variable "subnets_id" {
  type        = list(string)
  description = "All the subnets ids related to the network security group."
}
