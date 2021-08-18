variable "subscription_id" {
  type        = string
  description = "subscription ID"
}

variable "network_rule_collection_name" {
  type        = string
  description = "network rule collection name"
}

variable "network_rule_collection_priority" {
  type        = number
  description = "network rule collection name"
}

variable "network_rules" {
  type = list(object({
    name                  = string
    protocols             = list(string)
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
  }))
  default     = []
  description = "list of network rules"
}

variable "nat_rule_collection_name" {
  type        = string
  default     = ""
  description = "nat rule collection name"
}

variable "nat_rule_collection_priority" {
  type        = number
  default     = 700
  description = "nat rule collection name"
}

variable "nat_rules" {
  type = list(object({
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
  default     = ""
  description = "nat rule collection name"
}

variable "application_rule_collection_priority" {
  type        = number
  default     = 700
  description = "nat rule collection name"
}

variable "application_rules" {
  type = list(object({
    name = string
    protocols = list(object({
      type = string
      port = number
    }))
    source_addresses  = list(string)
    destination_fqdns = list(string)
  }))
  default     = []
  description = "list of network rules"
}