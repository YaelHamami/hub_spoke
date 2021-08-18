variable "nic_name" {
  type        = string
  description = " name of the vm's nic"
}

variable "location" {
  type        = string
  description = "nic's location"
}

variable "subnet_id" {
  type        = string
  description = "nic's subnet id"
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
  type        = string
  description = "admin username"
}

variable "admin_password" {
  type        = string
  description = "admin password"
}