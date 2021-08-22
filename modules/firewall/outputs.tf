output "public_ip" {
  value       = azurerm_public_ip.firewall_public_ip
  description = "The public ip address of the firewall."
}

output "subnet_id" {
  value       = azurerm_subnet.azure_firewall_subnet.id
  description = "The id of the subnet that contains the firewall."
}

output "private_ip" {
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  description = "The private ip address of the firewall."
}

output "firewall" {
  value = azurerm_firewall.firewall
  description = "The full firewall object."
}

output "id" {
  value = azurerm_firewall.firewall.id
  description = "The firewall id."
}

output "name" {
  value = azurerm_firewall.firewall.name
  description = "The firewall name."
}