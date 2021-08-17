output "public_ip_address" {
  value = azurerm_public_ip.firewall_public_ip
}

output "subnet_id" {
  value = azurerm_subnet.AzureFirewallSubnet.id
}