variable "route_table_name" {
  type        = string
  description = "route table name"
}

variable "location" {
  type        = string
  description = "location name"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "associated_subnet_id" {
  type        = string
  description = "associated subnet id"
}

variable "routes" {
  type = list(object({
    name                       = string
    destination_address_prefix = string
    next_hop_type              = string
    next_hop_ip_address        = optional(string)
  }))
}