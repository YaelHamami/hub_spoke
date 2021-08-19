output "gateway_subnet_id" {
  value       = azurerm_subnet.GatewaySubnet.id
  description = "the id of the subnet that contains the gateway"
}

output "client_address_space" {
  value       = azurerm_virtual_network_gateway.vnet_gateway.vpn_client_configuration[0].address_space[0]
  description = "the address space the client uses to communicate with the other networks"
}