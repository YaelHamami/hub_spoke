output "public_ip_address" {
  value       = azurerm_public_ip.firewall_public_ip
  description = "the public ip address of the firewall"
}

output "subnet_id" {
  value       = azurerm_subnet.azure_firewall_subnet.id
  description = "the id of the subnet that contains the firewall"
}

output "firewall_private_ip" {
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  description = "the private ip address of the firewall"
}