variable "vnet1_vnet2_name" {
  type = string
  description = "the name of the peering from vnet1 to vnet2"
}

variable "vnet1_vnet2_resource_group_name" {
  type = string
  description = "resource group name of the peering from vnet1 to vnet2"
}

variable "vnet1_name" {
  type = string
  description = "the name of the first vnet"
}

variable "vnet2_id" {
  type = string
  description = "the id of the second vnet"
}

variable "vnet1_vnet2_allow_gateway_transit" {
  type = bool
  default = false
  description = "does the peering from vnet 1 to vnet 2 allow gateway transit"
}

variable "vnet1_vnet2_use_remote_gateways" {
  type = bool
  default = false
  description = "does the peering from vnet 1 to vnet 2 use remote gateways"
}

variable "vnet1_vnet2_allow_forwarded_traffic" {
  type = bool
  default = true
  description = "does the peering from vnet 1 to vnet 2 allow_forwarded_traffic"
}

variable "vnet1_vnet2_allow_virtual_network_access" {
  type = bool
  default = true
  description = "does the peering from vnet 1 to vnet 2 allow virtual network access"
}

variable "vnet2_vnet1_name" {
  type = string
  description = "the name of the peering from vnet2 to vnet1"
}

variable "vnet2_vnet1_resource_group_name" {
  type = string
  description = "resource group name of the peering from vnet2 to vnet1"
}

variable "vnet2_name" {
  type = string
  description = "the name of the second vnet"
}

variable "vnet1_id" {
  type = string
  description = "the id of the first vnet"
}

variable "vnet2_vnet1_allow_gateway_transit" {
  type = bool
  default = false
  description = "does the peering from vnet2 to vnet1 allow gateway transit"
}

variable "vnet2_vnet1_use_remote_gateways" {
  type = bool
  default = false
  description = "does the peering from vnet2 to vnet1 use remote gateways"
}

variable "vnet2_vnet1_allow_forwarded_traffic" {
  type = bool
  default = true
  description = "does the peering from vnet2 to vnet1 allow_forwarded_traffic"
}

variable "vnet2_vnet1_allow_virtual_network_access" {
  type = bool
  default = true
  description = "does the peering from vnet2 to vnet1 allow virtual network access"
}


























