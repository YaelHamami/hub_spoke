variable "subnet_address_prefixes" {
  type        = list(string)
  description = "the address prefixes of the gateway subnet"
}

variable "public_ip_name" {
  type        = string
  description = "gateway public ip name"
}

variable "location" {
  type        = string
  description = "Location name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "vnet_name" {
  type        = string
  description = "Name of virtual network that contains the firewall."
}

variable "virtual_gateway_name" {
  type        = string
  description = "virtual gateway name."
}

variable "client_address_space" {
  type    = list(string)
  description = "The address space the client side use while using the vpn connection."
}

variable "aad_tenant" {
  type        = string
  description = "https://login.microsoftonline.com/{AzureAD TenantID}"
}

variable "aad_audience" {
  type        = string
  description = "Application ID of the Azure_VPN Azure AD Enterprise App."
}

variable "aad_issuer" {
  type        = string
  description = "https://sts.windows.net/{AzureAD TenantID}/"
}

variable "vpn_client_protocols" {
  type    = list(string)
  default = ["OpenVPN",]
  description = "The protocol used for the vpn connection."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "gateway sku"
}
