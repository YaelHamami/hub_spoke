output "gateway_subnet_id" {
  value = azurerm_subnet.GatewaySubnet.id
}

output "client_address_space" {
  value = azurerm_virtual_network_gateway.vnet_gateway.vpn_client_configuration[0].address_space[0]
}