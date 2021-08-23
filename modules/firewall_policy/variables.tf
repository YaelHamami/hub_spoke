variable "policy_name" {
  type = string
  description = "policy name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "location" {
  type        = string
  description = "Location name."
}

variable "network_rule_collection_priority" {
  type        = number
  default     = 200
  description = "Network rule collection name."
}

variable "network_rule_action" {
  type = string
  default = "Allow"
  description = "Network rule action."
}

variable "network_rules" {
  type        = list(object({
    protocols             = list(string)
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
  }))
  default     = []
  description = "List of network rules."
}

variable "nat_rule_collection_priority" {
  type        = number
  default     = 100
  description = "Nat rule collection name."
}

variable "nat_rules" {
  type        = list(object({
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

variable "application_rule_action" {
  type = string
  default = "Deny"
  description = "Application rule action."
}

variable "application_rules" {
  type        = list(object({
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

