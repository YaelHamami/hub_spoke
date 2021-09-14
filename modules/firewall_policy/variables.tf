variable "policy_name" {
  type        = string
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

variable "firewall_public_ip" {
  type = string
  default = null
  description = "The ip address of the firewall associated with the policy. Required only when creating nat rules."
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