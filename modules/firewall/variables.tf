variable "location" {
  type        = string
  description = "The location of all the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "vnet_name" {
  type        = string
  description = "Name of virtual network that contains the firewall."
}

variable "name" {
  type        = string
  description = "Firewall name."
}

variable "firewall_subnet_id" {
  type        = string
  description = "The id of the AzureFirewallSubnet."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log analytics workspace id."
}

variable "firewall_policy_name" {
  type        = string
  description = "Policy name."
}

variable "nat_rule_collection_group" {
  type        = list(object({
    name             = string
    priority         = number
    rule_collections = list(object({
      name     = string
      priority = number
      action   = string
      rules    = list(object({
        name                = string
        protocols           = list(string)
        source_addresses    = list(string)
        destination_address = string
        destination_ports   = list(string)
        translated_address  = string
        translated_port     = string
      }))
    }))
  }))
  default     = []
  description = "This object is a list of all the nat rule collection groups associated with the firewall policy."
}

variable "application_rule_collection_groups" {
  type        = list(object({
    name             = string
    priority         = number
    rule_collections = list(object({
      name     = string
      priority = number
      action   = string
      rules    = list(object({
        name              = string
        protocols         = list(object({
          type = string
          port = number
        }))
        source_addresses  = list(string)
        destination_fqdns = list(string)
      }))
    }))
  }))
  default     = []
  description = "This object is a list of all the application rule collection groups associated with the firewall policy."
}

variable "network_rule_collection_groups" {
  type        = list(object({
    name             = string
    priority         = number
    rule_collections = list(object({
      name     = string
      priority = number
      action   = string
      rules    = list(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = list(string)
        destination_addresses = list(string)
        destination_ports     = list(string)
      }))
    }))
  }))
  default     = []
  description = "This object is a list of all the network rule collection groups associated with the firewall policy."
}

