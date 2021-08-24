variable "local_to_remote_resource_group_name" {
  type = string
  description = "Resource group name of the peering from local to remote."
}

variable "local_vnet_name" {
  type = string
  description = "The name of the local vnet."
}

variable "remote_vnet_id" {
  type = string
  description = "The id of the remote vnet."
}

variable "local_remote_allow_gateway_transit" {
  type = bool
  default = false
  description = "Does the peering from the local to the remote vnet allow gateway transit."
}

variable "local_remote_use_remote_gateways" {
  type = bool
  default = false
  description = "Does the peering of the local vnet to the remote vnet remote use's remote gateways."
}

variable "local_remote_allow_forwarded_traffic" {
  type = bool
  default = true
  description = "Does the peering from the local vnet to the remote vnet allow_forwarded_traffic."
}

variable "local_remote_allow_virtual_network_access" {
  type = bool
  default = true
  description = "Does the peering from the local to the remote vnet allow virtual network access."
}

variable "remote_local_resource_group_name" {
  type = string
  description = "Resource group name of the peering from remote to local."
}

variable "remote_vnet_name" {
  type = string
  description = "The name of the second vnet."
}

variable "local_vnet_id" {
  type = string
  description = "The id of the local vnet."
}

variable "remote_local_allow_gateway_transit" {
  type = bool
  default = false
  description = "Does the peering from remote to local allow gateway transit."
}

variable "remote_local_use_remote_gateways" {
  type = bool
  default = false
  description = "Does the peering from remote to local use remote gateways."
}

variable "remote_local_allow_forwarded_traffic" {
  type = bool
  default = true
  description = "Does the peering from remote to local allow forwarded traffic."
}

variable "remote_local_allow_virtual_network_access" {
  type = bool
  default = true
  description = "Does the peering from remote to local allow virtual network access."
}


























