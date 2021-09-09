variable "prefix" {
  type = string
  description = "The prefix of certain values in the firewall module."
}

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

variable "firewall_name" {
  type        = string
  description = "Firewall name."
}

variable "firewall_subnet_id" {
  type = string
  description = "The id of the AzureFirewallSubnet."
}

variable "firewall_policy_name" {
  type = string
  description = "Policy name."
}

variable "network_rule_collection_priority" {
  type        = number
  default     = 200
  description = "Network rule collection name."
}

variable "network_rules" {
  type        = list(object({
    protocols             = list(string)
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
  }))
  default     = null
  description = "List of network rules."
}

variable "nat_rule_collection_priority" {
  type        = number
  default     = 100
  description = "Nat rule collection name."
}

variable "nat_rules" {
  type        = list(object({
    name                  = string
    protocols             = list(string)
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
    translated_address    = string
    translated_port       = string
  }))
  default     = []
  description = "List of nat rules."
}

variable "application_rule_collection_priority" {
  type        = number
  default     = 300
  description = "Nat rule collection name."
}

variable "application_rules" {
  type        = list(object({
    name              = string
    protocols         = list(object({
      type = string
      port = number
    }))
    source_addresses  = list(string)
    destination_fqdns = list(string)
  }))
  default     = []
  description = "List of application rules."
}

variable "log_analytics_workspace_id" {
  type = string
  description = "Log analytics workspace id."
}

variable "network_rule_action" {
  type = string
  default = "Allow"
  description = "Network rule action (Deny, Allow)."
}

variable "application_rule_action" {
  type = string
  default = "Deny"
  description = "Application rule action (Deny, Allow)."
}

