variable "nic_name" {
  type        = string
  description = "network_interface_name"
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}

variable "rg_name" {
  type        = string
  description = "resource group name"
}

variable "comp_name" {
  type        = string
  description = "the name of the vm"
}

variable "admin_username" {
  type = string
  description = "admin username"
}

variable "admin_password" {
  type = string
  description = "admin password"
}