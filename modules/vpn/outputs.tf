output "client_address_space" {
  value       = azurerm_virtual_network_gateway.vnet_gateway.vpn_client_configuration[0].address_space[0]
  description = "The address space the client uses to communicate with the other networks."
}

output "vpn_gateway" {
  value = azurerm_virtual_network_gateway.vnet_gateway
  description = "The full vpn gateway."
}

output "id" {
  value = azurerm_virtual_network_gateway.vnet_gateway.id
  description = "The vpn gateway id."
}

output "name" {
  value = azurerm_virtual_network_gateway.vnet_gateway.name
  description = "The vpn gateway name"
}

