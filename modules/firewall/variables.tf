variable "location" {
  type        = string
  description = "location name"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "vnet_name" {
  type        = string
  description = "name of virtual network that contains the firewall"
}

variable "firewall_name" {
  type        = string
  description = "firewall name"
}

variable "address_prefixes" {
  type        = list(string)
  description = "firewall address prefixes"
}

variable "policy_name" {
  type = string
  description = "policy name"
}

variable "rule_collection_name" {
  type = string
  description = "rule collection name"
}

variable "rule_collection_priority" {
  type = number
  description = "rule collection priority"
}

variable "network_rule_collection_name" {
  type        = string
  default     = null
  description = "network rule collection name"
}

variable "network_rule_collection_priority" {
  type        = number
  default     = null
  description = "network rule collection name"
}

variable "network_rules" {
  type        = list(object({
    name                  = string
    protocols             = list(string)
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
  }))
  default     = null
  description = "list of network rules"
}

variable "nat_rule_collection_name" {
  type        = string
  default     = null
  description = "nat rule collection name"
}

variable "nat_rule_collection_priority" {
  type        = number
  default     = null
  description = "nat rule collection name"
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
  description = "list of network rules"
}

variable "application_rule_collection_name" {
  type        = string
  default     = null
  description = "nat rule collection name"
}

variable "application_rule_collection_priority" {
  type        = number
  default     = null
  description = "nat rule collection name"
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
  description = "list of network rules"
}

variable "log_analytics_workspace_id" {
  type = string
  description = "log analytics workspace id"
}