variable "prefix" {
  type = string
  description = "The prefix of certain values in the vpn module"
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

variable "subnet_id" {
  type = string
  description = "The id of the GatewaySubnet"
}

variable "virtual_gateway_name" {
  type        = string
  description = "The name of the Virtual Network Gateway. Changing the name forces a new resource to be created."
}

variable "client_address_space" {
  type        = list(string)
  description = "The address space the client side uses while using the vpn connection."
}

variable "aad_tenant" {
  type        = string
  description = "https://login.microsoftonline.com/{AzureAD TenantID}"
}

variable "aad_audience" {
  type        = string
  description = "The client id of the Azure VPN application. See Create an Active Directory (AD) tenant for P2S OpenVPN protocol connections for values."
}

variable "aad_issuer" {
  type        = string
  description = "https://sts.windows.net/{AzureAD TenantID}/"
}

variable "vpn_client_protocols" {
  type        = list(string)
  default     = ["OpenVPN",]
  description = " List of the protocols supported by the vpn client. The supported values are SSTP, IkeV2 and OpenVPN. Values SSTP and IkeV2 are incompatible with the use of aad_tenant, aad_audience and aad_issuer."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments."
}
