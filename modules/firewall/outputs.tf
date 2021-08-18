output "public_ip_address" {
  value = azurerm_public_ip.firewall_public_ip
}

output "subnet_id" {
  value = azurerm_subnet.azure_firewall_subnet.id
}

output "firewall_private_ip" {
  value = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}